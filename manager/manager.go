package manager

import (
	"fmt"

	"github.com/JessonChan/canlog"
	"github.com/JessonChan/yorm"

	"github.com/JessonChan/can_blog/models"
)

func GetAllCate() (categories []models.Category) {
	withError(func() error {
		return yorm.R(&categories)
	})
	return
}

func GetConfig() (configs []models.Config) {
	withError(func() error {
		return yorm.R(&configs)
	})
	return
}
func GetConfigMap() map[string]string {
	var result = GetConfig()
	configs := make(map[string]string)
	for _, v := range result {
		configs[v.Name] = v.Value
	}
	return configs
}

func UpdateConfig(k, v string) {
	_, err := yorm.Update("update cb_config set value=? where name=? and value<>?", v, k, v)
	if err != nil {
		canlog.CanError(err)
	}
}

func GetUserByName(name string) *models.User {
	user := &models.User{}
	err := yorm.Select(user, "select * from cb_user  where username=?", name)
	if err != nil {
		canlog.CanError(err)
	}
	return user
}

func AddComment(comment models.Comment) error {
	_, err := yorm.Insert(&comment)
	if err != nil {
		canlog.CanError(err)
	}
	return err
}

func ReadCate(cateId int) *models.Category {
	cate := models.Category{}
	err := yorm.Select(&cate, "select * from cb_category where id=?", cateId)
	if err != nil {
		canlog.CanError(err)
	}
	return &cate
}

func AddCate(cate models.Category) {
	_, err := yorm.Insert(&cate)
	if err != nil {
		canlog.CanError(err)
	}
}
func UpdateCate(cate models.Category) {
	_, err := yorm.Update("update cb_category set name=? ,updated=now() where id=? ", cate.Name, cate.Id)
	if err != nil {
		canlog.CanError(err)
	}
}

func DeleteCate(cateId int) (int64, error) {
	return yorm.Delete("delete from cb_category  where id=?", cateId)
}

func AddPost(post models.Post) {
	_, err := yorm.Insert(&post)
	if err != nil {
		canlog.CanError(err)
	}
}
func UpdatePost(ps models.Post) {
	_, err := yorm.Update("update cb_post set title=?,content=?,category_id=?,info=?,  updated=now() where id=?", ps.Title, ps.Content, ps.CategoryId, ps.Info, ps.Id)
	if err != nil {
		canlog.CanError(err)
	}
}

func DeletePost(postId int) (int64, error) {
	return yorm.Delete("delete from cb_post where id=?", postId)
}

func BeforePost(id int) *models.Post {
	post := &models.Post{}
	withError(func() error {
		return yorm.Select(post, "select * from cb_post where id<? order by id desc", id)
	})
	return post
}
func NextPost(id int) *models.Post {
	post := &models.Post{}
	withError(func() error {
		return yorm.Select(post, "select * from cb_post where id>? order by id asc", id)
	})
	return post
}

func ReadPost(postId int, readOnly ...bool) *models.Post {
	post := &models.Post{Id: postId}
	err := yorm.R(post)
	if err != nil {
		canlog.CanError(err)
		return nil
	}
	if append(readOnly, false)[0] {
		return post
	}
	// todo 这里会有并发写入问题
	_, err = yorm.Update("update cb_post set views=views+1 where id=?", postId)
	if err != nil {
		canlog.CanError(err)
	}
	post.Views++
	return post
}
func CommentList(postId int) []models.Comment {
	var list []models.Comment
	err := yorm.R(&list, "select * from cb_comment where post_id=?", postId)
	if err != nil {
		canlog.CanError(err)
	}
	return list
}

func HotArticles(limit int) (hots []models.Post) {
	_ = yorm.Select(&hots, "select * from cb_post order by views desc limit "+fmt.Sprint(limit))
	return
}

func CountArticles() int {
	var cnt int
	err := yorm.Select(&cnt, "select count(0) from cb_post where is_top=1")
	if err != nil {
		canlog.CanError(err)
	}
	return cnt
}
func CountCateArticles(cateId int) int {
	var cnt int
	err := yorm.Select(&cnt, "select count(0) from cb_post where category_id=?", cateId)
	if err != nil {
		canlog.CanError(err)
	}
	return cnt
}
func HomeList(page, size int) (list []models.Post) {
	if page <= 0 {
		page = 1
	}
	if size <= 0 {
		size = 10
	}
	offset := (page - 1) * size
	err := yorm.Select(&list, "select * from cb_post where is_top=1  order by updated desc limit ?,? ", offset, size)
	if err != nil {
		canlog.CanError(err)
	}
	return
}

func NewArticles(offset, size int) (list []models.Post) {
	err := yorm.Select(&list, "select * from cb_post where is_top=1  order by updated desc limit ?,? ", offset, size)
	if err != nil {
		canlog.CanError(err)
	}
	return
}
func CateArticles(cateId, page, size int) (list []models.Post) {
	if page <= 0 {
		page = 1
	}
	if size <= 0 {
		size = 10
	}
	offset := (page - 1) * size
	err := yorm.R(&list, "select * from cb_post where is_top=1  and category_id=? order by updated desc limit ?,?", cateId, offset, size)
	if err != nil {
		canlog.CanError(err)
	}
	return
}
