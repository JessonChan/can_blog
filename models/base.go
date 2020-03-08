package models

import (
	"time"

	"github.com/JessonChan/cango"
	"github.com/JessonChan/canlog"
	"github.com/JessonChan/yorm"
)

func InitDB() {
	_ = yorm.Register(cango.Env("dsn"))
	yorm.InitLogger(canlog.GetLogger())
	yorm.SetLoggerLevel(yorm.Debug)
	yorm.RegisterTableFunc(TableName)
}

// 返回带前缀的表名
func TableName(str string) string {
	return "cb_" + str
}

// 对应的表结构
type (
	Category struct {
		Id      int
		Name    string
		Created time.Time
		Updated time.Time
	}

	Config struct {
		Id    int
		Name  string
		Value string
	}

	Comment struct {
		Id       int
		Username string
		Content  string
		Created  time.Time
		PostId   int
		Ip       string
	}
	Post struct {
		Id         int
		UserId     int
		Title      string
		Url        string
		Content    string
		Tags       string
		Views      int
		IsTop      int8
		Created    time.Time
		Updated    time.Time
		CategoryId int
		Status     int8
		Types      int8
		Info       string
		Image      string
	}
	User struct {
		Id         int
		Username   string
		Password   string
		Email      string
		LoginCount int
		LastTime   time.Time
		LastIp     string
		State      int8
		Created    time.Time
		Updated    time.Time
	}
)
