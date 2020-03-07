package main

import (
	"html/template"
	"time"

	"github.com/JessonChan/cango"
	"github.com/JessonChan/canlog"
	_ "github.com/go-sql-driver/mysql"

	_ "github.com/JessonChan/can_blog/controllers"
	_ "github.com/JessonChan/can_blog/filter"
)

func main() {
	if cango.Env("log") != "console" {
		cango.InitLogger(canlog.NewFileWriter(cango.Env("log")))
	}
	can := cango.NewCan()
	can.
		RegTplFunc("str2html", func(s string) template.HTML { return template.HTML(s) }).
		RegTplFunc("date", func(t time.Time, f string) string {
			if f == "Y-m-d H:i:s" {
				return t.Format("2006-01-02 15:04:05")
			} else {
				return t.Format("2006-01-02")
			}
		}).
		Run(cango.Addr{Port: 8088},
			cango.Opts{TplSuffix: []string{".html", ".tpl"}, TplDir: "views"},
		)
}
