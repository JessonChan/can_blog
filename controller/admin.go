package controller

import (
	"fmt"
	"net/http"
	"strings"
	"time"

	"github.com/JessonChan/cango"

	"github.com/JessonChan/can_blog/manager"
	"github.com/JessonChan/can_blog/model"
)

type manageCtrl struct {
	cango.URI `value:"/manage"`
}

var _ = cango.RegisterURI(&manageCtrl{})

type LoginUser struct {
	cango.Constructor
	UserName  string
	Password  string
	TimeToken int64 `cookie:"_can_blog_token"`
	isLogin   bool
	user      *model.User
}

func (l *LoginUser) Construct(r *http.Request) {
	if time.Duration(time.Now().UnixNano()-l.TimeToken) > 5*time.Minute {
		return
	}
	user := manager.GetUserByName(l.UserName)
	if user == nil || user.Password == "" {
		return
	}
	if l.Password != strings.Trim(user.Password, " ") {
		return
	}
	l.user = user
	l.isLogin = true
}

func (m *manageCtrl) Login(ps struct {
	cango.URI `value:"/login"`
	cango.GetMethod
	cango.PostMethod
}, lu *LoginUser) interface{} {
	if ps.Request().IsGet() {
		ps.Request().SetCookie(&http.Cookie{
			Name:     "_can_blog_token",
			Value:    fmt.Sprintf("%d", time.Now().UnixNano()),
			Path:     "/",
			Expires:  time.Now().AddDate(0, 0, 7),
			MaxAge:   0,
			HttpOnly: true,
		})
		return cango.ModelView{
			Tpl: "/manage/login.html",
		}
	}
	if lu.isLogin == false {
		return cango.Redirect{Url: "/manage/login"}
	}
	return cango.Redirect{Url: "/manage/main"}
}
