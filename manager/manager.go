package manager

import (
	"fmt"
	"log"

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

func AddComment(comment models.Comment) error {
	_, err := yorm.Insert(&comment)
	if err != nil {
		log.Println(err)
	}
	return err
}

func ReadPost(postId int) *models.Post {
	post := &models.Post{Id: postId}
	err := yorm.R(&post)
	if err != nil {
		log.Println(err)
		return nil
	}
	// todo 这里会有并发写入问题
	_, err = yorm.Update("update "+post.TableName()+" set views=views+1 where id=?", post, post.Views)
	if err != nil {
		log.Println(err)
	}
	post.Views++
	return post
}
func CommentList(postId int) (list []models.Comment) {
	err := yorm.R(&list, "select * from "+new(models.Comment).TableName()+" where post_id=?", postId)
	if err != nil {
		log.Println(err)
	}
	return
}

func HotArticles(limit int) (hots []models.Post) {
	_ = yorm.Select(&hots, "select * from "+new(models.Post).TableName()+" order by views desc limit "+fmt.Sprint(limit))
	return
}

func CountArticles() int {
	var cnt int
	err := yorm.Select(&cnt, "select count(0) from "+new(models.Post).TableName()+" where is_top=1")
	if err != nil {
		log.Println(err)
	}
	return cnt
}
func CountCateArticles(cateId int) int {
	var cnt int
	err := yorm.Select(&cnt, "select count(0) from "+new(models.Post).TableName()+" where category_id=?", cateId)
	if err != nil {
		log.Println(err)
	}
	return cnt
}

func NewArticles(offset, size int) (list []models.Post) {
	err := yorm.Select(&list, "select * from "+new(models.Post).TableName()+" where is_top=1  order by updated desc limit ?,? ", offset, size)
	if err != nil {
		log.Println(err)
	}
	return
}
func CateArticles(cateId, offset, size int) (list []models.Post) {
	err := yorm.R(&list, "select * from "+new(models.Post).TableName()+" where is_top=1  and category_id=? order by updated desc limit ?,?", cateId, offset, size)
	if err != nil {
		log.Println(err)
	}
	return
}
