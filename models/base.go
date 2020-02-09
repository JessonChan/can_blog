package models

import (
	"github.com/JessonChan/yorm"
	"github.com/astaxie/beego/orm"
)

var dsn = "root:123456@tcp(127.0.0.1:3306)/can_blog?charset=utf8&loc=Asia%2FShanghai"
var dbPrefix = "cb_"

func init() {
	yorm.Register(dsn)
	yorm.RegisterTableFunc(TableName)
	_ = orm.RegisterDataBase("default", "mysql", dsn)
	orm.RegisterModel(new(User), new(Category), new(Post), new(Config), new(Comment))
}

// 返回带前缀的表名
func TableName(str string) string {
	return dbPrefix + str
}
