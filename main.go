package main

import (
	"html/template"
	"time"

	"github.com/JessonChan/cango"
	_ "github.com/go-sql-driver/mysql"

	"github.com/JessonChan/can_blog/controllers"
)

func main() {
	can := cango.NewCan()
	can.Route(&controllers.PageController{}).
		Route(&controllers.ManageController{}).
		Filter(&controllers.LoginFilter{}, &controllers.ManageController{}).
		RegTplFunc("str2html", func(s string) template.HTML { return template.HTML(s) }).
		RegTplFunc("date", func(t time.Time, f string) string {
			if f == "Y-m-d H:i:s" {
				return t.Format("2006-03-02 15:04:05")
			} else {
				return t.Format("2006-03-02")
			}
		}).
		Run(cango.Addr{Port: 8099},
			cango.StaticOpts{TplSuffix: ".html"},
		)
}
