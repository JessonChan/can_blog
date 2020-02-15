package main

import (
	"html/template"
	"time"

	"github.com/JessonChan/cango"
	_ "github.com/go-sql-driver/mysql"

	"github.com/JessonChan/can_blog/controllers"
	"github.com/JessonChan/can_blog/filter"
)

func main() {
	can := cango.NewCan()
	can.Route(&controllers.PageController{}).
		Route(&controllers.ManageController{}).
		Filter(&filter.LoginFilter{}, &controllers.ManageController{}).
		RegTplFunc("str2html", func(s string) template.HTML { return template.HTML(s) }).
		RegTplFunc("date", func(t time.Time, f string) string {
			if f == "Y-m-d H:i:s" {
				return t.Format("2006-01-02 15:04:05")
			} else {
				return t.Format("2006-01-02")
			}
		}).
		Run(cango.Addr{Port: 8088},
			cango.StaticOpts{TplSuffix: []string{".html", ".tpl"}},
		)
}
