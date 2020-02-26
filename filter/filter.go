package filter

import (
	"net/http"

	"github.com/JessonChan/cango"

	"github.com/JessonChan/can_blog/session"
)

type LoginFilter struct {
	cango.Filter `value:"/admin/*"`
}

var _ = cango.RegisterFilter(&LoginFilter{})

func (l *LoginFilter) PreHandle(w http.ResponseWriter, req *http.Request) interface{} {
	if req.URL.Path == "/admin/login" || req.URL.Path == "/admin/login.html" {
		return true
	}
	u, _ := session.LocalSession.Get(req, session.UserCookieName)
	if u.IsNew {
		return cango.Redirect{Url: "/admin/login"}
	}
	if u.Values["user"] == "admin" {
		return true
	}
	return cango.Redirect{Url: "/admin/login"}
}
