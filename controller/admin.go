package controller

import (
	"fmt"
	"net/http"
	"strings"
	"time"

	"github.com/JessonChan/cango"

	"github.com/JessonChan/can_blog/manager"
	"github.com/JessonChan/can_blog/util"
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
}

func (l *LoginUser) Construct(r *http.Request) {
	tk := time.Time{}.Add(time.Duration(l.TimeToken))
	if tk.Sub(time.Now()) > 5*time.Minute {
		l.isLogin = false
		return
	}
	user := manager.GetUserByName(l.UserName)
	if user == nil || user.Password == "" {
		l.isLogin = false
		return
	}
	if util.Md5(l.Password) != strings.Trim(user.Password, " ") {
		l.isLogin = false
		return
	}
	l.isLogin = true
}

func (m *manageCtrl) Login(ps struct {
	cango.URI `value:"/login"`
	cango.GetMethod
	cango.PostMethod
}, lu *LoginUser) interface{} {
	if ps.URI.Request().Method == http.MethodGet {
		// set token
		http.SetCookie(ps.Request().ResponseWriter, &http.Cookie{
			Name:     "_can_blog_token",
			Value:    fmt.Sprintf("%d", time.Now().Nanosecond()),
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
