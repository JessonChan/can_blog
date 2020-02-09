package controllers

import (
	"html/template"
	"time"

	"github.com/JessonChan/cango"
	"github.com/astaxie/beego/orm"

	"github.com/JessonChan/can_blog/manager"
	"github.com/JessonChan/can_blog/models"
	"github.com/JessonChan/can_blog/util"
)

type PageController struct {
	cango.URI
	baseController
}
type query struct {
	page    int
	cateId  int
	keyword string
}

func (c *PageController) list(actionName string, q query) {
	var (
		pagesize int = 6
		page     int
		offset   int
		list     []*models.Post
		hosts    []*models.Post
		// cateId   int
		// keyword  string
	)

	orm.Debug = true
	c.o = orm.NewOrm()
	var result []*models.Config
	c.o.QueryTable(new(models.Config).TableName()).All(&result)
	configs := make(map[string]string)
	for _, v := range result {
		configs[v.Name] = v.Value
	}

	c.Data = map[interface{}]interface{}{}
	c.Data["cates"] = manager.GetAllCate()
	c.Data["config"] = configs

	if q.page < 1 {
		page = 1
	}

	offset = (page - 1) * pagesize
	query := c.o.QueryTable(new(models.Post).TableName())

	if actionName == "resource" {
		query = query.Filter("types", 0)
	} else {
		query = query.Filter("types", 1)
	}

	if q.cateId != 0 {
		query = query.Filter("category_id", q.cateId)
	}
	if q.keyword != "" {
		query = query.Filter("title__contains", q.keyword)
	}
	query.OrderBy("-views").Limit(10, 0).All(&hosts)

	if actionName == "home" {
		query = query.Filter("is_top", 1)
	}
	count, _ := query.Count()
	c.Data["count"] = count
	query.OrderBy("-created").Limit(pagesize, offset).All(&list)

	c.Data["list"] = list
	c.Data["pagebar"] = util.NewPager(page, int(count), pagesize, "/"+actionName, true).ToString()
	c.Data["hosts"] = hosts
}

/**
首页
*/
func (c *PageController) Home(ps struct {
	cango.URI `value:"/;/home.html"`
	Page      int
}) interface{} {
	c.list("home", query{page: ps.Page})
	c.Data["actionName"] = "home"
	return cango.ModelView{Tpl: "/blog/home.html", Model: c.Data}
	// c.TplName = c.controllerName + "/home.html"
}

/**
列表页面
*/
func (c *PageController) Article(ps struct {
	cango.URI `value:"/article.html;/article"`
	Cate_Id   int
}) interface{} {
	c.list("article", query{cateId: ps.Cate_Id})
	c.Data["actionName"] = "article"
	return cango.ModelView{
		Tpl:   "/blog/article.html",
		Model: c.Data,
	}
}

/**
详情
*/
func (c *PageController) Detail(ps struct {
	cango.URI `value:"/detail.html"`
	Id        int
}) interface{} {
	if ps.Id == 0 {
		return cango.Redirect{Url: "/", Code: 302}
	}
	c.o = orm.NewOrm()
	c.Data = map[interface{}]interface{}{}
	post := models.Post{Id: ps.Id}
	_ = c.o.Read(&post)
	post.Views++
	_, _ = c.o.Update(&post)
	c.Data["post"] = post
	c.Data["htmlContent"] = template.HTML(post.Content)
	comments := []*models.Comment{}
	query := c.o.QueryTable(new(models.Comment).TableName()).Filter("post_id", ps.Id)
	query.All(&comments)
	c.Data["comments"] = comments

	c.Data["cates"] = manager.GetAllCate()
	var hosts []*models.Post
	querys := c.o.QueryTable(new(models.Post).TableName()).Filter("types", 1)
	querys.OrderBy("-views").Limit(10, 0).All(&hosts)
	c.Data["hosts"] = hosts
	c.Data["actionName"] = "detail"
	return cango.ModelView{Tpl: "/blog/detail.html", Model: c.Data}
}

/**
关于我们
*/
func (c *PageController) About(struct {
	cango.URI `value:"about.html"`
}) interface{} {
	c.o = orm.NewOrm()
	c.Data = map[interface{}]interface{}{}
	post := models.Post{Id: 1}
	c.o.Read(&post)
	c.Data["post"] = post
	c.Data["actionName"] = "about"
	return cango.ModelView{Tpl: "/blog/about.html", Model: c.Data}
}

// 时间线
func (c *PageController) Timeline(struct {
	cango.URI `value:"timeline.html"`
}) interface{} {
	c.Data = map[interface{}]interface{}{}
	c.Data["actionName"] = "timeline"
	return cango.ModelView{Tpl: "/blog/timeline.html", Model: c.Data}
}

// 资源
func (c *PageController) Resource(struct {
	cango.URI `value:"resource.html"`
}) interface{} {
	c.list("resource", query{})
	c.Data["actionName"] = "resource"
	return cango.ModelView{Tpl: "/blog/resource.html", Model: c.Data}
}

// 插入评价
func (c *PageController) Comment(ps struct {
	cango.URI `value:"comment.html"`
	cango.PostMethod
	UserName string
	Content  string
	Post_id  int
}) interface{} {
	c.o = orm.NewOrm()
	Comment := models.Comment{}
	Comment.Username = ps.UserName
	Comment.Content = ps.Content
	Comment.PostId = ps.Post_id
	Comment.Ip = c.Request().Request.RemoteAddr
	Comment.Created = time.Now()
	msg := "发布评价成功"
	_, err := c.o.Insert(&Comment)
	if err != nil {
		msg = "发布评价失败" + err.Error()
	}
	return cango.Content{
		String: "<script>alert('" + msg + "');window.history.go(-1);</script>",
		Code:   200,
	}
}
