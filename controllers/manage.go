package controllers

import (
	"fmt"
	"net/http"
	"strings"
	"time"

	"github.com/JessonChan/cango"
	"github.com/astaxie/beego/orm"

	"github.com/gorilla/sessions"

	"github.com/JessonChan/can_blog/manager"
	"github.com/JessonChan/can_blog/models"
	"github.com/JessonChan/can_blog/util"
)

type ManageController struct {
	cango.URI      `value:"/admin"`
	Data           map[interface{}]interface{}
	controllerName string
	actionName     string
	o              orm.Ormer
}

type LoginFilter struct {
	cango.Filter
}

func (l *LoginFilter) PreHandle(req *http.Request) interface{} {
	if req.URL.Path == "/admin/login" || req.URL.Path == "/admin/login.html" {
		return true
	}
	u, _ := LocalSession.Get(req, "user")
	if u.IsNew {
		return cango.Redirect{Url: "/admin/login"}
	}
	if u.Values["user"] == "admin" {
		return true
	}
	return cango.Redirect{Url: "/admin/login"}
}

func (p *ManageController) prepare(actionName string) {
	p.Data = map[interface{}]interface{}{}
	p.controllerName = "admin"
	p.actionName = actionName
	p.o = orm.NewOrm()
}

// 配置信息
func (c *ManageController) Config(ps struct {
	cango.URI `value:"/config;/config.html"`
	cango.PostMethod
	cango.GetMethod
	Url         string
	Title       string
	Keywords    string
	Description string
	Email       string
	Start       string
	Qq          string
}) interface{} {
	c.prepare("config")

	var result []*models.Config
	_, _ = c.o.QueryTable(new(models.Config).TableName()).All(&result)
	options := make(map[string]string)
	mp := make(map[string]*models.Config)
	for _, v := range result {
		options[v.Name] = v.Value
		mp[v.Name] = v
	}
	if c.Request().Request.Method == "POST" {
		keys := []string{"url", "title", "keywords", "description", "email", "start", "qq"}
		values := []string{ps.Url, ps.Title, ps.Keywords, ps.Description, ps.Email, ps.Start, ps.Qq}
		for idx, key := range keys {
			if values[idx] == "" {
				continue
			}
			if _, ok := mp[key]; !ok {
				options[key] = values[idx]
				_, _ = c.o.Insert(&models.Config{Name: key, Value: values[idx]})
			} else {
				opt := mp[key]
				if _, err := c.o.Update(&models.Config{Id: opt.Id, Name: opt.Name, Value: values[idx]}); err != nil {
					continue
				}
			}
		}
		return getErrorContent("配置出错")
	}
	c.Data["config"] = options
	return cango.ModelView{
		Tpl:   "/admin/config.html",
		Model: c.Data,
	}
}

var LocalSession = sessions.NewCookieStore([]byte("something-very-secret"))

// 后台用户登录
func (c *ManageController) Login(ps struct {
	cango.URI `value:"/login;/login.html"`
	cango.PostMethod
	cango.GetMethod
	Username string
	Password string
}) interface{} {
	c.prepare("login")
	if c.Request().Request.Method == http.MethodGet {
		return cango.ModelView{
			Tpl:   "/admin/login.html",
			Model: c.Data,
		}
	}
	user := models.User{Username: ps.Username}
	c.o.Read(&user, "username")

	if user.Password == "" {
		return getErrorContent("账号不存在")
	}

	if util.Md5(ps.Password) != strings.Trim(user.Password, " ") {
		return getErrorContent("密码错误")
	}
	user.LastIp = c.Request().Request.RemoteAddr
	user.LoginCount = user.LoginCount + 1
	if _, err := c.o.Update(&user); err != nil {
		return getErrorContent("登陆异常")
	}
	u, _ := LocalSession.New(c.Request().Request, "user")
	u.Values["user"] = ps.Username
	_ = u.Save(c.Request().Request, c.Request().ResponseWriter)
	return cango.Redirect{Url: "/admin/main"}
}

func (c *ManageController) Logout(struct {
	cango.URI `value:"/logout;/logout.html"`
}) interface{} {
	c.prepare("logout")
	u, _ := LocalSession.Get(c.Request().Request, "user")
	u.Values["user"] = nil
	_ = u.Save(c.Request().Request, c.Request().ResponseWriter)
	return cango.Redirect{Url: "/admin/main"}
}

// 后台首页
func (c *ManageController) Index(ps struct {
	cango.URI `value:"/index;/index.html"`
	Title     string
	Cate_id   int
	Page      int
}) interface{} {
	c.prepare("index")
	c.Data["categorys"] = manager.GetAllCate()
	var (
		page     int
		pagesize int = 8
		offset   int
		list     []*models.Post
		keyword  string
		cateId   int
	)
	keyword = ps.Title
	cateId = ps.Cate_id
	if page = ps.Page; page < 1 {
		page = 1
	}
	offset = (page - 1) * pagesize
	// c.Ctx.WriteString(new(models.Post).TableName())
	query := c.o.QueryTable(new(models.Post).TableName())
	if keyword != "" {
		query = query.Filter("title__contains", keyword)
	}
	count, _ := query.Count()
	if count > 0 {
		_, _ = query.OrderBy("-is_top", "-created").Limit(pagesize, offset).All(&list)
	}
	c.Data["keyword"] = keyword
	c.Data["count"] = count
	c.Data["list"] = list
	c.Data["cate_id"] = cateId
	c.Data["pagebar"] = util.NewPager(page, int(count), pagesize,
		fmt.Sprintf("/admin/index.html?keyword=%s", keyword), true).ToString()
	return cango.ModelView{
		Tpl:   "/admin/list.html",
		Model: c.Data,
	}
}

// 主页
func (c *ManageController) Main(struct {
	cango.URI `value:"main;main.html"`
}) interface{} {
	c.prepare("main")
	return cango.ModelView{
		Tpl:   "/admin/main.html",
		Model: c.Data,
	}
}

// 文章
func (c *ManageController) Article(ps struct {
	cango.URI `value:"/article;/article.html"`
	Id        int
}) interface{} {
	c.prepare("article")
	if ps.Id > 0 {
		post := models.Post{Id: ps.Id}
		c.o.Read(&post)
		c.Data["post"] = post
	}
	c.Data["categorys"] = manager.GetAllCate()
	return cango.ModelView{
		Tpl:   "/admin/_form.html",
		Model: c.Data,
	}
}

// // 上传接口
// func (c *ManageController) Upload() {
// 	f, h, err := c.GetFile("uploadname")
// 	result := make(map[string]interface{})
// 	img := ""
// 	if err == nil {
// 		exStrArr := strings.Split(h.Filename, ".")
// 		exStr := strings.ToLower(exStrArr[len(exStrArr)-1])
// 		if exStr != "jpg" && exStr != "png" && exStr != "gif" {
// 			result["code"] = 1
// 			result["message"] = "上传只能.jpg 或者png格式"
// 		}
// 		img = "/static/upload/" + util.UniqueId() + "." + exStr
// 		c.SaveToFile("upFilename", img) // 保存位置在 static/upload, 没有文件夹要先创建
// 		result["code"] = 0
// 		result["message"] = img
// 	} else {
// 		result["code"] = 2
// 		result["message"] = "上传异常" + err.Error()
// 	}
// 	defer f.Close()
// 	c.Data["json"] = result
// 	c.ServeJSON()
// }

// 保存
func (c *ManageController) Save(ps struct {
	cango.URI `value:"/save"`
	cango.PostMethod
	Id      int
	Title   string
	Content string
	Is_top  int8
	Types   int8
	Tags    string
	Url     string
	Cate_id int
	Info    string
	Image   string
}) interface{} {
	c.prepare("save")
	post := models.Post{}
	post.UserId = 1
	post.Title = ps.Title
	post.Content = ps.Content
	post.IsTop = ps.Is_top
	post.Types = ps.Types
	post.Tags = ps.Tags
	post.Url = ps.Url
	post.CategoryId = ps.Cate_id
	post.Info = ps.Info
	post.Image = ps.Image
	post.Created = time.Now()
	post.Updated = time.Now()

	var err error
	if ps.Id == 0 {
		_, err = c.o.Insert(&post)
	} else {
		post.Id = ps.Id
		_, err = c.o.Update(&post)
	}
	if err != nil {
		return getErrorContent("参数错误")
	}
	return cango.Redirect{
		Url:  "/admin/index.html",
		Code: 302,
	}

}

func getErrorContent(msg string) cango.Content {
	return cango.Content{
		String: "<script>alert('" + msg + "');window.history.go(-1);</script>",
	}
}

func (c *ManageController) Delete(ps struct {
	cango.URI `value:"/delete;/delete.html"`
	Id        int
}) interface{} {
	c.prepare("delete")
	if ps.Id == 0 {
		return getErrorContent("参数错误")
	}
	if _, err := c.o.Delete(&models.Post{Id: ps.Id}); err != nil {
		return getErrorContent("未能成功删除")
	}
	return cango.Redirect{Url: "/admin/index.html"}
}

// 类目
func (c *ManageController) Category(struct {
	cango.URI `value:"category;category.html"`
}) interface{} {
	c.prepare("category")
	c.Data["categorys"] = manager.GetAllCate()
	return cango.ModelView{
		Tpl:   "/admin/category.html",
		Model: c.Data,
	}
}

// 添加修改类目
func (c *ManageController) Categoryadd(ps struct {
	cango.URI `value:"/categoryadd;categoryadd.html"`
	Id        int
}) interface{} {
	c.prepare("categoryadd")
	if ps.Id != 0 {
		cate := models.Category{Id: ps.Id}
		c.o.Read(&cate)
		c.Data["cate"] = cate
	}
	return cango.ModelView{
		Tpl:   "/admin/category_add.html",
		Model: c.Data,
	}
}

// 处理插入数据的字段
func (c *ManageController) CategorySave(ps struct {
	cango.URI `value:"categorysave;categorysave.html"`
	cango.PostMethod
	Id   int
	Name string
}) interface{} {
	c.prepare("categorysave")
	category := models.Category{}
	category.Name = ps.Name
	var err error
	if ps.Id == 0 {
		_, err = c.o.Insert(&category)
	} else {
		category.Id = ps.Id
		_, err = c.o.Update(&category)
	}
	if err != nil {
		return getErrorContent("数据错误")
	}
	return cango.Redirect{Url: "/admin/category.html"}
}

func (c *ManageController) CategoryDel(ps struct {
	cango.URI `value:"categorydel;categorydel.html"`
	Id        int
}) interface{} {
	c.prepare("categorydel")
	if ps.Id == 0 {
		return getErrorContent("参数错误")
	}
	if _, err := c.o.Delete(&models.Category{Id: ps.Id}); err != nil {
		return getErrorContent("参数错误")
	} else {
		return cango.Redirect{Url: "/admin/category.html"}
	}
}
