package models

import (
	"github.com/JessonChan/yorm"
)

var dsn = "root:123456@tcp(127.0.0.1:3306)/can_blog?charset=utf8&loc=Asia%2FShanghai"
var dbPrefix = "cb_"

func init() {
	yorm.Register(dsn)
	yorm.RegisterTableFunc(TableName)
}

// 返回带前缀的表名
func TableName(str string) string {
	return dbPrefix + str
}
