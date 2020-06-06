package controller

import (
	"fmt"
	"strings"
	"time"

	"github.com/JessonChan/cango"

	"github.com/JessonChan/can_blog/manager"
	"github.com/JessonChan/can_blog/model"
	"github.com/JessonChan/can_blog/util"
)

// ManageController 是管理后台的控制器
type ManageController struct {
	cango.URI `value:"/admin"`
}

var _ = cango.RegisterURI(&ManageController{})

// Config 配置信息
func (c *ManageController) Config(ps struct {
	cango.URI `value:"/config;/config.html"`
	cango.GetMethod
}) interface{} {
	return cango.ModelView{
		Tpl:   "/admin/config.html",
		Model: map[string]interface{}{"config": manager.GetConfigMap()},
	}
}

// Config 配置信息
func (c *ManageController) ConfigPost(ps struct {
	cango.URI `value:"/config;/config.html"`
	cango.PostMethod
	Url         string
	Title       string
	Keywords    string
	Description string
	Email       string
	Start       string
	Qq          string
}) interface{} {
	keys := []string{"url", "title", "keywords", "description", "email", "start", "qq"}
	values := []string{ps.Url, ps.Title, ps.Keywords, ps.Description, ps.Email, ps.Start, ps.Qq}
	for idx, key := range keys {
		if values[idx] != "" {
			manager.UpdateConfig(key, values[idx])
		}
	}
	return cango.ModelView{
		Tpl:   "/admin/config.html",
		Model: map[string]interface{}{"config": manager.GetConfigMap()},
	}
}

// Login 后台用户登录
func (c *ManageController) Login(ps struct {
	cango.URI `value:"/login;/login.html"`
	cango.GetMethod
}) interface{} {
	return cango.ModelView{
		Tpl: "/admin/login.html",
	}
}

// Login 后台用户登录
func (c *ManageController) DoLogin(ps struct {
	cango.URI `value:"/login;/login.html"`
	cango.PostMethod
	Username string
	Password string
}) interface{} {
	user := manager.GetUserByName(ps.Username)
	if user == nil || user.Password == "" {
		return getErrorContent("账号不存在")
	}

	if ps.Password != strings.Trim(user.Password, " ") {
		return getErrorContent("密码错误")
	}
	c.Request().SessionPut("user", ps.Username)
	return cango.Redirect{Url: "/admin/main"}
}

// Logout 退出
func (c *ManageController) Logout(struct {
	cango.URI `value:"/logout;/logout.html"`
}) interface{} {
	c.Request().SessionPut("user", nil)
	return cango.Redirect{Url: "/admin/main"}
}

// Index 后台首页
func (c *ManageController) Index(ps struct {
	cango.URI `value:"/index;/index.html"`
	Title     string
	CateId    int `name:"cate_id"`
	Page      int
}) interface{} {
	var (
		page     int
		pagesize int = 8
		offset   int
		keyword  string
		cateId   int
	)
	dataModel := map[string]interface{}{}
	dataModel["categories"] = manager.GetAllCate()
	keyword = ps.Title
	cateId = ps.CateId
	if page = ps.Page; page < 1 {
		page = 1
	}
	offset = (page - 1) * pagesize

	dataModel["keyword"] = keyword
	count := manager.CountArticles()
	dataModel["count"] = count
	dataModel["list"] = manager.NewArticles(offset, pagesize)
	dataModel["cate_id"] = cateId
	dataModel["pagebar"] = util.NewPager(page, int(count), pagesize,
		fmt.Sprintf("/admin/index.html?keyword=%s", keyword), true).ToString()
	return cango.ModelView{
		Tpl:   "/admin/list.html",
		Model: dataModel,
	}
}

// Main 主页
func (c *ManageController) Main(struct {
	cango.URI `value:"main;main.html"`
}) interface{} {
	return cango.ModelView{
		Tpl: "/admin/main.html",
	}
}

// Article 文章
func (c *ManageController) Article(ps struct {
	cango.URI `value:"/article;/article.html"`
	Id        int
}) interface{} {
	articleModel := map[string]interface{}{}
	if ps.Id > 0 {
		articleModel["post"] = manager.ReadPost(ps.Id, true)
	}
	articleModel["categories"] = manager.GetAllCate()
	return cango.ModelView{
		Tpl:   "/admin/_form.html",
		Model: articleModel,
	}
}

// Save 保存
func (c *ManageController) Save(ps struct {
	cango.URI `value:"/save"`
	cango.PostMethod
	PostId  int `name:"post_id"`
	Title   string
	Content string
	IsTop   int8 `name:"is_top"`
	Types   int8
	Tags    string
	Url     string
	CateId  int `name:"cate_id"`
	Info    string
	Image   string
}) interface{} {
	post := model.Post{}
	post.UserId = 1
	post.Title = ps.Title
	post.Content = ps.Content
	post.IsTop = ps.IsTop
	post.Types = ps.Types
	post.Tags = ps.Tags
	post.Url = ps.Url
	post.CategoryId = ps.CateId
	post.Info = ps.Info
	post.Image = ps.Image
	post.Created = time.Now()
	post.Updated = time.Now()

	if ps.PostId == 0 {
		manager.AddPost(post)
	} else {
		post.Id = ps.PostId
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

// Delete Delete
func (c *ManageController) Delete(ps struct {
	cango.URI `value:"/delete;/delete.html"`
	Id        int
}) interface{} {
	if ps.Id == 0 {
		return getErrorContent("参数错误")
	}
	if _, err := manager.DeletePost(ps.Id); err != nil {
		return getErrorContent("未能成功删除")
	}
	return cango.Redirect{Url: "/admin/index.html"}
}

// Category 类目
func (c *ManageController) Category(struct {
	cango.URI `value:"category;category.html"`
}) interface{} {
	return cango.ModelView{
		Tpl:   "/admin/category.html",
		Model: manager.GetAllCate(),
	}
}

// Categoryadd 添加修改类目
func (c *ManageController) Categoryadd(ps struct {
	cango.URI `value:"/categoryadd;categoryadd.html"`
	Id        int
}) interface{} {
	return cango.ModelView{
		Tpl:   "/admin/category_add.html",
		Model: manager.ReadCate(ps.Id),
	}
}

// CategorySave 处理插入数据的字段
func (c *ManageController) CategorySave(ps struct {
	cango.URI `value:"categorysave;categorysave.html"`
	cango.PostMethod
	Id   int
	Name string
}) interface{} {
	category := model.Category{}
	category.Name = ps.Name
	if ps.Id == 0 {
		manager.AddCate(category)
	} else {
		category.Id = ps.Id
		manager.UpdateCate(category)
	}

	return cango.Redirect{Url: "/admin/category.html"}
}

// CategoryDel CategoryDel
func (c *ManageController) CategoryDel(ps struct {
	cango.URI `value:"categorydel;categorydel.html"`
	Id        int
}) interface{} {
	if ps.Id == 0 {
		return getErrorContent("参数错误")
	}
	if _, err := manager.DeleteCate(ps.Id); err != nil {
		return getErrorContent("参数错误")
	} else {
		return cango.Redirect{Url: "/admin/category.html"}
	}
}
