package main

import (
	"html/template"
	"time"

	"github.com/JessonChan/cango"
	_ "github.com/go-sql-driver/mysql"

	_ "github.com/JessonChan/can_blog/controller"
	_ "github.com/JessonChan/can_blog/filter"
	"github.com/JessonChan/can_blog/model"
)

func main() {
	model.InitDB()
	cango.NewCan().
		RegTplFunc("str2html", func(s string) template.HTML { return template.HTML(s) }).
		RegTplFunc("date", func(t time.Time, f string) string {
			if f == "Y-m-d H:i:s" {
				return t.Format("2006-01-02 15:04:05")
			} else {
				return t.Format("2006-01-02")
			}
		}).
		Run()
}
