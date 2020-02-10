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

func UpdateConfig(k, v string) {
	_, err := yorm.Update("update "+new(models.Config).TableName()+" set value=? where name=? and value<>?", v, k, v)
	if err != nil {
		log.Println(err)
	}
}

func GetUserByName(name string) *models.User {
	user := &models.User{}
	err := yorm.Select(user, "select * from "+user.TableName()+" where username=?", name)
	if err != nil {
		log.Println(err)
	}
	return user
}

func AddComment(comment models.Comment) error {
	_, err := yorm.Insert(&comment)
	if err != nil {
		log.Println(err)
	}
	return err
}

func ReadCate(cateId int) *models.Category {
	cate := models.Category{}
	err := yorm.Select(&cate, "select * from "+new(models.Category).TableName()+" where id=?", cateId)
	if err != nil {
		log.Println(err)
	}
	return &cate
}

func AddCate(cate models.Category) {
	_, err := yorm.Insert(&cate)
	if err != nil {
		log.Println(err)
	}
}
func UpdateCate(cate models.Category) {
	_, err := yorm.Update("update "+new(models.Category).TableName()+" set name=? ,updated=now() where id=? ", cate.Name, cate.Id)
	if err != nil {
		log.Println(err)
	}
}

func DeleteCate(cateId int) (int64, error) {
	return yorm.Delete("delete from "+new(models.Category).TableName()+"  where id=?", cateId)
}

func AddPost(post models.Post) {
	_, err := yorm.Insert(&post)
	if err != nil {
		log.Println(err)
	}
}
func UpdatePost(ps models.Post) {
	_, err := yorm.Update("update "+new(models.Post).TableName()+" set title=?,content=?,category_id=?,info=?,  updated=now() where id=?", ps.Title, ps.Content, ps.CategoryId, ps.Info, ps.Id)
	if err != nil {
		log.Println(err)
	}
}

func DeletePost(postId int) (int64, error) {
	return yorm.Delete("delete from "+new(models.Post).TableName()+" where id=?", postId)
}

func ReadPost(postId int, readOnly ...bool) *models.Post {
	post := &models.Post{Id: postId}
	err := yorm.R(post)
	if err != nil {
		log.Println(err)
		return nil
	}
	if append(readOnly, false)[0] {
		return post
	}
	// todo 这里会有并发写入问题
	_, err = yorm.Update("update "+new(models.Post).TableName()+" set views=views+1 where id=?", postId)
	if err != nil {
		log.Println(err)
	}
	post.Views++
	return post
}
func CommentList(postId int) []models.Comment {
	var list []models.Comment
	err := yorm.R(&list, "select * from "+new(models.Comment).TableName()+" where post_id=?", postId)
	if err != nil {
		log.Println(err)
	}
	return list
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
