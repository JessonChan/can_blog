package filter

import (
	"net/http"

	"github.com/JessonChan/cango"

	"github.com/JessonChan/can_blog/session"
)

type AdminFilter struct {
	cango.Filter `value:"/manage/*"`
}

var _ = cango.RegisterFilter(&AdminFilter{})

func (l *AdminFilter) PreHandle(w http.ResponseWriter, req *http.Request) interface{} {
	if req.URL.Path == "/manage/login" {
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
