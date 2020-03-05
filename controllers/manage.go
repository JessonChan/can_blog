package controllers

import (
	"fmt"
	"log"
	"net/http"
	"strings"
	"time"

	"github.com/JessonChan/cango"

	"github.com/JessonChan/can_blog/manager"
	"github.com/JessonChan/can_blog/models"
	"github.com/JessonChan/can_blog/session"
	"github.com/JessonChan/can_blog/util"
)

type ManageController struct {
	cango.URI      `value:"/admin"`
	Data           map[interface{}]interface{}
	controllerName string
	actionName     string
}

var _ = cango.RegisterURI(&ManageController{})

func (p *ManageController) prepare(actionName string) {
	p.Data = map[interface{}]interface{}{}
	p.controllerName = "admin"
	p.actionName = actionName
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

	if c.Request().Request.Method == http.MethodPost {
		keys := []string{"url", "title", "keywords", "description", "email", "start", "qq"}
		values := []string{ps.Url, ps.Title, ps.Keywords, ps.Description, ps.Email, ps.Start, ps.Qq}
		for idx, key := range keys {
			if values[idx] != "" {
				manager.UpdateConfig(key, values[idx])
			}
		}
	}
	cfs := manager.GetConfig()
	options := map[string]string{}

	for _, cf := range cfs {
		options[cf.Name] = cf.Value
	}
	c.Data["config"] = options
	return cango.ModelView{
		Tpl:   "/admin/config.html",
		Model: c.Data,
	}
}

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
	user := manager.GetUserByName(ps.Username)
	if user == nil || user.Password == "" {
		return getErrorContent("账号不存在")
	}

	if util.Md5(ps.Password) != strings.Trim(user.Password, " ") {
		return getErrorContent("密码错误")
	}
	u, _ := session.LocalSession.New(c.Request().Request, session.UserCookieName)
	u.Values["user"] = ps.Username
	err := u.Save(c.Request().Request, c.Request().ResponseWriter)
	if err != nil {
		log.Println("login in error", err)
	}
	return cango.Redirect{Url: "/admin/main"}
}

func (c *ManageController) Logout(struct {
	cango.URI `value:"/logout;/logout.html"`
}) interface{} {
	c.prepare("logout")
	u, _ := session.LocalSession.Get(c.Request().Request, session.UserCookieName)
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
		// list     []*models.Post
		keyword string
		cateId  int
	)
	keyword = ps.Title
	cateId = ps.Cate_id
	if page = ps.Page; page < 1 {
		page = 1
	}
	offset = (page - 1) * pagesize

	c.Data["keyword"] = keyword
	count := manager.CountArticles()
	c.Data["count"] = count
	c.Data["list"] = manager.NewArticles(offset, pagesize)
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
		c.Data["post"] = manager.ReadPost(ps.Id, true)
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
	Post_id int
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

	if ps.Post_id == 0 {
		manager.AddPost(post)
	} else {
		post.Id = ps.Post_id
		manager.UpdatePost(post)
	}
	return cango.Redirect{
		Url: "/admin/index.html",
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
	if _, err := manager.DeletePost(ps.Id); err != nil {
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
		c.Data["cate"] = manager.ReadCate(ps.Id)
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
	if ps.Id == 0 {
		manager.AddCate(category)
	} else {
		category.Id = ps.Id
		manager.UpdateCate(category)
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
	if _, err := manager.DeleteCate(ps.Id); err != nil {
		return getErrorContent("参数错误")
	} else {
		return cango.Redirect{Url: "/admin/category.html"}
	}
}
