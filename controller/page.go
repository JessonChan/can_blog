package controller

import (
	"time"

	"github.com/JessonChan/cango"

	"github.com/JessonChan/can_blog/manager"
	"github.com/JessonChan/can_blog/model"
)

type PageController struct {
	cango.URI
}

var _ = cango.RegisterURI(&PageController{})

var defaultPageSize = 10

/**
首页
*/
func (c *PageController) Home(ps struct {
	cango.URI `value:"/;/home.html"`
	Page      int
}) interface{} {
	if ps.Page == 0 {
		ps.Page = 1
	}
	return cango.ModelView{Tpl: "/blog/list_v2.html", Model: map[string]interface{}{
		"config":     manager.GetConfigMap(),
		"categories": manager.GetAllCate(),
		"list":       manager.HomeList(ps.Page, defaultPageSize),
		"hots":       manager.HotArticles(defaultPageSize),
		"nextPage":   ps.Page + 1,
	}}
}

/**
列表页面
*/
func (c *PageController) Category(ps struct {
	cango.URI `value:"/category.html;/category"`
	CateId    int
	Page      int
}) interface{} {
	if ps.Page == 0 {
		ps.Page = 1
	}
	return cango.ModelView{Tpl: "/blog/list_v2.html", Model: map[string]interface{}{
		"config":     manager.GetConfigMap(),
		"categories": manager.GetAllCate(),
		"list":       manager.CateArticles(ps.CateId, ps.Page, defaultPageSize),
		"hots":       manager.HotArticles(defaultPageSize),
		"nextPage":   ps.Page + 1,
	}}
}

/**
详情
*/
func (c *PageController) Detail(ps struct {
	cango.URI `value:"/detail.html"`
	Id        int
}) interface{} {
	if ps.Id == 0 {
		return cango.Redirect{Url: "/"}
	}
	return cango.ModelView{Tpl: "/blog/detail_v2.html", Model: map[string]interface{}{
		"config":     manager.GetConfigMap(),
		"categories": manager.GetAllCate(),
		"hots":       manager.HotArticles(defaultPageSize),
		"post":       manager.ReadPost(ps.Id),
		"before":     manager.BeforePost(ps.Id),
		"next":       manager.NextPost(ps.Id),
	}}
}

// 插入评价
func (c *PageController) Comment(ps struct {
	cango.URI `value:"comment.html"`
	// cango.PostMethod
	UserName string
	Content  string
	PostId   int `value:"post_id"`
}) interface{} {
	comment := model.Comment{}
	comment.Username = ps.UserName
	comment.Content = ps.Content
	comment.PostId = ps.PostId
	comment.Ip = c.Request().Request.RemoteAddr
	comment.Created = time.Now()
	msg := "发布评价成功"
	err := manager.AddComment(comment)
	if err != nil {
		msg = "发布评价失败" + err.Error()
	}
	return cango.Content{
		String: "<script>alert('" + msg + "');window.history.go(-1);</script>",
	}
}
