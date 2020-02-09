package manager

import (
	"github.com/astaxie/beego/orm"

	"github.com/JessonChan/can_blog/models"
)

func GetAllCate() (categories []*models.Category) {
	orm.Debug = true
	o := orm.NewOrm()
	o.QueryTable(new(models.Category).TableName()).All(&categories)
	return
}

func GetConfig() []*models.Config {
	var result []*models.Config
	orm.Debug = true
	o := orm.NewOrm()
	_, _ = o.QueryTable(new(models.Config).TableName()).All(&result)
	return result
}
