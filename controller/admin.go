package controller

import (
	"fmt"
	"net/http"
	"time"

	"github.com/JessonChan/cango"
	"github.com/JessonChan/canlog"
)

type manageCtrl struct {
	cango.URI `value:"/manage"`
}

var _ = cango.RegisterURI(&manageCtrl{})

type LoginUser struct {
	cango.Constructor
	UserName  string
	Password  string
	TimeToken string `cookie:"_can_blog_token"`
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
	if lu.UserName == "hello" && lu.Password == "nihao" {
		canlog.CanError(lu.TimeToken)
	}
	return cango.Redirect{Url: "/"}
}
