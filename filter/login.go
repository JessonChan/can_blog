package filter

import (
	"net/http"

	"github.com/JessonChan/cango"
)

type LoginFilter struct {
	cango.Filter `value:"/admin/*"`
}

var _ = cango.RegisterFilter(&LoginFilter{})

func (l *LoginFilter) PreHandle(w http.ResponseWriter, req *http.Request) interface{} {
	if req.URL.Path == "/admin/login" || req.URL.Path == "/admin/login.html" {
		return true
	}
	var userName string
	cango.SessionGet(req, "user", &userName)
	if userName == "admin" {
		return true
	}
	return cango.Redirect{Url: "/admin/login"}
}
