package manager

import (
	"github.com/JessonChan/yorm"

	"github.com/JessonChan/can_blog/models"
)

func GetAllCate() (categories []models.Category) {
	_ = yorm.R(&categories)
	return
}

func GetConfig() (configs []models.Config) {
	_ = yorm.R(&configs)
	return
}
