package filter

import (
	"github.com/JessonChan/cango"
)

type LoginFilter struct {
	cango.Filter `value:"/admin/*"`
}

var _ = cango.RegisterFilter(&LoginFilter{})

func (l *LoginFilter) PreHandle(req *cango.WebRequest) interface{} {
	if req.URL.Path == "/admin/login" || req.URL.Path == "/admin/login.html" {
		return true
	}
	var userName string
	req.SessionGet("user", &userName)
	if userName == "admin" {
		return true
	}
	return cango.Redirect{Url: "/admin/login"}
}
