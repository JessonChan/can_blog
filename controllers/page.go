package controllers

import (
	"time"

	"github.com/JessonChan/cango"

	"github.com/JessonChan/can_blog/manager"
	"github.com/JessonChan/can_blog/models"
	"github.com/JessonChan/can_blog/util"
)

type PageController struct {
	cango.URI
	Data           map[interface{}]interface{}
	controllerName string
	actionName     string
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
		list     []models.Post
		// cateId   int
		// keyword  string
	)

	var result = manager.GetConfig()
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

	var count int
	offset = (page - 1) * pagesize
	if q.cateId == 0 {
		count = manager.CountArticles()
		if count > offset {
			list = manager.NewArticles(offset, pagesize)
		}
	} else {
		count = manager.CountCateArticles(q.cateId)
		if count > offset {
			list = manager.CateArticles(q.cateId, offset, pagesize)
		}
	}
	c.Data["count"] = count

	c.Data["list"] = list
	c.Data["pagebar"] = util.NewPager(page, int(count), pagesize, "/"+actionName, true).ToString()
	c.Data["hosts"] = manager.HotArticles(10)
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
	c.Data = map[interface{}]interface{}{}
	c.Data["post"] = manager.ReadPost(ps.Id)
	c.Data["comments"] = manager.CommentList(ps.Id)

	c.Data["cates"] = manager.GetAllCate()
	c.Data["hosts"] = manager.HotArticles(10)
	c.Data["actionName"] = "detail"
	return cango.ModelView{Tpl: "/blog/detail.html", Model: c.Data}
}

/**
关于我们
*/
func (c *PageController) About(struct {
	cango.URI `value:"about.html"`
}) interface{} {
	c.Data = map[interface{}]interface{}{}
	c.Data["post"] = manager.ReadPost(1)
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
	// cango.PostMethod
	UserName string
	Content  string
	Post_id  int
}) interface{} {
	comment := models.Comment{}
	comment.Username = ps.UserName
	comment.Content = ps.Content
	comment.PostId = ps.Post_id
	comment.Ip = c.Request().Request.RemoteAddr
	comment.Created = time.Now()
	msg := "发布评价成功"
	err := manager.AddComment(comment)
	if err != nil {
		msg = "发布评价失败" + err.Error()
	}
	return cango.Content{
		String: "<script>alert('" + msg + "');window.history.go(-1);</script>",
		Code:   200,
	}
}
