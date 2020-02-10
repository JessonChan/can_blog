# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.28)
# Database: can_blog
# Generation Time: 2020-02-10 01:41:14 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table cb_category
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_category`;

CREATE TABLE `cb_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

LOCK TABLES `cb_category` WRITE;
/*!40000 ALTER TABLE `cb_category` DISABLE KEYS */;

INSERT INTO `cb_category` (`id`, `name`, `created`, `updated`)
VALUES
	(2,'美好生活','2020-02-09 15:35:44','2020-02-09 15:35:44'),
	(4,'编程相关','2020-02-08 18:11:40','2020-02-08 18:11:40'),
	(7,'Golang编程','2020-02-09 15:33:37','2020-02-09 21:55:08');

/*!40000 ALTER TABLE `cb_category` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cb_comment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_comment`;

CREATE TABLE `cb_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(200) DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ip` varchar(100) DEFAULT NULL,
  `post_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;



# Dump of table cb_config
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_config`;

CREATE TABLE `cb_config` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

LOCK TABLES `cb_config` WRITE;
/*!40000 ALTER TABLE `cb_config` DISABLE KEYS */;

INSERT INTO `cb_config` (`id`, `name`, `value`)
VALUES
	(1,'title','Cango blog 源码'),
	(2,'url','https://github.com/JessonChan/can_blog'),
	(5,'keywords','golang Cango'),
	(6,'description','使用Cango 框架开发的博客网站'),
	(7,'email','example@example.com'),
	(9,'timezone','8'),
	(11,'start','1'),
	(12,'qq','10010');

/*!40000 ALTER TABLE `cb_config` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cb_post
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_post`;

CREATE TABLE `cb_post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `url` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '下载地址',
  `content` mediumtext,
  `tags` varchar(100) NOT NULL,
  `views` mediumint(9) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `is_top` tinyint(4) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `category_id` int(11) NOT NULL,
  `types` tinyint(4) DEFAULT NULL COMMENT '1. 文章 0 下载',
  `info` varchar(500) CHARACTER SET utf8 DEFAULT NULL COMMENT '简介',
  `image` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4;

LOCK TABLES `cb_post` WRITE;
/*!40000 ALTER TABLE `cb_post` DISABLE KEYS */;

INSERT INTO `cb_post` (`id`, `user_id`, `title`, `url`, `content`, `tags`, `views`, `status`, `is_top`, `created`, `updated`, `category_id`, `types`, `info`, `image`)
VALUES
	(23,1,'欢迎使用can_blog','','<p>基于Go语言和cango框架 前端使用layui 布局 开发的个人博客系统 代码主要由 https://github.com/Echosong/beego_blog 完成，感谢ES @Echosong 的授权</p>','cango',9,0,1,'2020-02-09 21:37:26','2020-02-09 21:48:08',2,1,'cango是一个好用web开发框架',''),
	(24,1,'can_blog简易博客系统','','<p>你好，这是一篇使用can_blog博客系统的博客。</p>','golang,博客',8,0,1,'2020-02-09 21:42:10','2020-02-09 21:47:24',4,1,'can_blog是基于cango web开发框架的博客程序。',''),
	(25,1,'cango 是一个实验性的web开发框架','','<h1 md-src-pos=\"0..7\" style=\"font-size: 2.25em; margin: 1em 0px 16px; box-sizing: border-box; line-height: 1.2; position: relative; padding-bottom: 0.3em; border-bottom: 1px solid rgb(44, 44, 44); color: rgb(204, 204, 204); font-family: Helvetica, Arial, freesans, sans-serif; white-space: normal; background-color: rgb(60, 63, 65);\">cango</h1><p md-src-pos=\"8..81\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: rgb(204, 204, 204); font-family: Helvetica, Arial, freesans, sans-serif; font-size: 16px; white-space: normal; background-color: rgb(60, 63, 65);\">cango 是一个实验性的web开发框架，支持模板和模板，高效的使用golang的tag特性，将路由定义、变量赋值和更多的操作通过在tag中定义。</p><h2 md-src-pos=\"84..91\" style=\"box-sizing: border-box; margin-top: 1em; margin-bottom: 16px; line-height: 1.225; font-size: 1.75em; position: relative; padding-bottom: 0.3em; border-bottom: 1px solid rgb(44, 44, 44); color: rgb(204, 204, 204); font-family: Helvetica, Arial, freesans, sans-serif; white-space: normal; background-color: rgb(60, 63, 65);\">路由设计</h2><p md-src-pos=\"92..151\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: rgb(204, 204, 204); font-family: Helvetica, Arial, freesans, sans-serif; font-size: 16px; white-space: normal; background-color: rgb(60, 63, 65);\">Route方法注册所有的Controller<br style=\"box-sizing: border-box;\"/>Controller结构体上定义路由路径和路径上对应的变量，例如</p><pre style=\"overflow: auto; font-family: Consolas, &quot;Liberation Mono&quot;, Menlo, Courier, monospace; font-size: 13.6px; box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; font-stretch: normal; line-height: 1.45; padding: 16px; background-color: rgb(44, 44, 44); border-radius: 3px; overflow-wrap: normal; color: rgb(204, 204, 204);\">type&nbsp;Controller&nbsp;struct&nbsp;{&nbsp;&nbsp;&nbsp;&nbsp;\r\n&nbsp;&nbsp;&nbsp;&nbsp;URI&nbsp;`value:&quot;/blog/{blogName}/article/{articleId}&quot;`&nbsp;&nbsp;\r\n&nbsp;&nbsp;&nbsp;&nbsp;BlogName&nbsp;string&nbsp;&nbsp;\r\n&nbsp;&nbsp;&nbsp;&nbsp;ArticleId&nbsp;int&nbsp;&nbsp;\r\n}</pre><p md-src-pos=\"293..322\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: rgb(204, 204, 204); font-family: Helvetica, Arial, freesans, sans-serif; font-size: 16px; white-space: normal; background-color: rgb(60, 63, 65);\">在Controller的方法传参上定义具体的执行方法，例如</p><pre style=\"overflow: auto; font-family: Consolas, &quot;Liberation Mono&quot;, Menlo, Courier, monospace; font-size: 13.6px; box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; font-stretch: normal; line-height: 1.45; padding: 16px; background-color: rgb(44, 44, 44); border-radius: 3px; overflow-wrap: normal; color: rgb(204, 204, 204);\">func&nbsp;(c&nbsp;*Controller)Comment(param&nbsp;struct{\r\n&nbsp;&nbsp;&nbsp;&nbsp;URI&nbsp;`value:&quot;/commnet/{commentId}.json&quot;`\r\n&nbsp;&nbsp;&nbsp;&nbsp;CommentId&nbsp;int\r\n}){\r\n&nbsp;&nbsp;&nbsp;&nbsp;//do&nbsp;sth\r\n}</pre><p md-src-pos=\"457..588\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: rgb(204, 204, 204); font-family: Helvetica, Arial, freesans, sans-serif; font-size: 16px; white-space: normal; background-color: rgb(60, 63, 65);\">我们约定：<br style=\"box-sizing: border-box;\"/>1、所有的路由变量都使用{}包围<br style=\"box-sizing: border-box;\"/>2、所有的对应变量都只能使用首字母小写的驼峰来命名<br style=\"box-sizing: border-box;\"/>3、所有的路由方法必须只有一个参数，且实现了URI接口<br style=\"box-sizing: border-box;\"/>4、所有的路由方法有且只有第一个返回值做为是restful的返回值，如果没有返回值则返回{}</p><h2 md-src-pos=\"590..605\" style=\"box-sizing: border-box; margin-top: 1em; margin-bottom: 16px; line-height: 1.225; font-size: 1.75em; position: relative; padding-bottom: 0.3em; border-bottom: 1px solid rgb(44, 44, 44); color: rgb(204, 204, 204); font-family: Helvetica, Arial, freesans, sans-serif; white-space: normal; background-color: rgb(60, 63, 65);\">路由设计具体实现漫谈</h2><p md-src-pos=\"606..819\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: rgb(204, 204, 204); font-family: Helvetica, Arial, freesans, sans-serif; font-size: 16px; white-space: normal; background-color: rgb(60, 63, 65);\">以GET方法为例说明。<br style=\"box-sizing: border-box;\"/>从Controller中抽离出路由urlC和变量列表varsC，从Controller中抽离出方法路由urlM和变量列表varsM，则urlC+urlM为路由方法最终的路由，varsC+varsM为路由方法最终的变量列表。 当某个已知的路由来时，先使用gorilla/mux包Match出指定的控制器和方法，通过反射将控制器进行初始化、通过反射对路由方法的唯一参数进行初始化，然后使用反射进行调用。</p><p md-src-pos=\"821..881\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: rgb(204, 204, 204); font-family: Helvetica, Arial, freesans, sans-serif; font-size: 16px; white-space: normal; background-color: rgb(60, 63, 65);\">定义一个map来存放路由方法，由于路由方法第一个参数就是controller本身，所以可以很好的还原现场，实现调用.</p><h2 md-src-pos=\"883..891\" style=\"box-sizing: border-box; margin-top: 1em; margin-bottom: 16px; line-height: 1.225; font-size: 1.75em; position: relative; padding-bottom: 0.3em; border-bottom: 1px solid rgb(44, 44, 44); color: rgb(204, 204, 204); font-family: Helvetica, Arial, freesans, sans-serif; white-space: normal; background-color: rgb(60, 63, 65);\">过滤器设计</h2><p md-src-pos=\"892..966\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: rgb(204, 204, 204); font-family: Helvetica, Arial, freesans, sans-serif; font-size: 16px; white-space: normal; background-color: rgb(60, 63, 65);\">过滤器要支持两种URL匹配风格，一种就是在工程已经实现的，基于controller去匹配，另外一种就是通过tag来定义，如实现最通用的AntPath</p><p><br/></p>','cango',0,0,1,'2020-02-10 09:38:00','2020-02-10 09:38:00',7,1,'cango 是一个实验性的web开发框架，支持模板和模板，高效的使用golang的tag特性，将路由定义、变量赋值和更多的操作通过在tag中定义。',''),
	(26,1,'Yorm介绍','','<h1 md-src-pos=\"0..10\" style=\"font-size: 2.25em; margin: 1em 0px 16px; box-sizing: border-box; line-height: 1.2; position: relative; padding-bottom: 0.3em; border-bottom: 1px solid rgb(44, 44, 44); color: rgb(204, 204, 204); font-family: Helvetica, Arial, freesans, sans-serif; white-space: normal; background-color: rgb(60, 63, 65);\">README</h1><p md-src-pos=\"12..67\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: rgb(204, 204, 204); font-family: Helvetica, Arial, freesans, sans-serif; font-size: 16px; white-space: normal; background-color: rgb(60, 63, 65);\">yOrm is a simple,lightweight orm , for mysql only now.</p><h3 md-src-pos=\"69..104\" style=\"box-sizing: border-box; margin-top: 1em; margin-bottom: 16px; line-height: 1.43; font-size: 1.5em; position: relative; color: rgb(204, 204, 204); font-family: Helvetica, Arial, freesans, sans-serif; white-space: normal; background-color: rgb(60, 63, 65);\">Why this project calls yOrm</h3><p md-src-pos=\"106..163\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: rgb(204, 204, 204); font-family: Helvetica, Arial, freesans, sans-serif; font-size: 16px; white-space: normal; background-color: rgb(60, 63, 65);\">yOrm is just a name.<br style=\"box-sizing: border-box;\"/>thanks [<a href=\"https://github.com/lewgun\" md-src-pos=\"137..162\" style=\"background-color: transparent; box-sizing: border-box; color: rgb(88, 157, 246); text-decoration-line: none;\">https://github.com/lewgun</a>]</p><h3 md-src-pos=\"165..195\" style=\"box-sizing: border-box; margin-top: 1em; margin-bottom: 16px; line-height: 1.43; font-size: 1.5em; position: relative; color: rgb(204, 204, 204); font-family: Helvetica, Arial, freesans, sans-serif; white-space: normal; background-color: rgb(60, 63, 65);\">What is this yOrm for?</h3><ul md-src-pos=\"197..225\" style=\"box-sizing: border-box; padding: 0px 0px 0px 2em; margin-bottom: 16px; color: rgb(204, 204, 204); font-family: Helvetica, Arial, freesans, sans-serif; white-space: normal; background-color: rgb(60, 63, 65);\" class=\" list-paddingleft-2\"><li><p>A simple mysql orm to crud</p></li></ul><h2 md-src-pos=\"227..237\" style=\"box-sizing: border-box; margin-top: 1em; margin-bottom: 16px; line-height: 1.225; font-size: 1.75em; position: relative; padding-bottom: 0.3em; border-bottom: 1px solid rgb(44, 44, 44); color: rgb(204, 204, 204); font-family: Helvetica, Arial, freesans, sans-serif; white-space: normal; background-color: rgb(60, 63, 65);\">Tags</h2><p md-src-pos=\"240..271\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: rgb(204, 204, 204); font-family: Helvetica, Arial, freesans, sans-serif; font-size: 16px; white-space: normal; background-color: rgb(60, 63, 65);\">Now support these types of tag.</p><h3 md-src-pos=\"273..287\" style=\"box-sizing: border-box; margin-top: 1em; margin-bottom: 16px; line-height: 1.43; font-size: 1.5em; position: relative; color: rgb(204, 204, 204); font-family: Helvetica, Arial, freesans, sans-serif; white-space: normal; background-color: rgb(60, 63, 65);\">column</h3><p md-src-pos=\"288..425\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: rgb(204, 204, 204); font-family: Helvetica, Arial, freesans, sans-serif; font-size: 16px; white-space: normal; background-color: rgb(60, 63, 65);\">this tag alias struct name to a real column name. &quot;Id int `yorm:&quot;column(autoId)&quot;`&quot; means this field Id will name autoId in mysql column</p><h3 md-src-pos=\"427..437\" style=\"box-sizing: border-box; margin-top: 1em; margin-bottom: 16px; line-height: 1.43; font-size: 1.5em; position: relative; color: rgb(204, 204, 204); font-family: Helvetica, Arial, freesans, sans-serif; white-space: normal; background-color: rgb(60, 63, 65);\">pk</h3><p md-src-pos=\"438..563\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: rgb(204, 204, 204); font-family: Helvetica, Arial, freesans, sans-serif; font-size: 16px; white-space: normal; background-color: rgb(60, 63, 65);\">this tag allow you to set a primary key where select/delete/update as the where clause &quot;Id int `yorm:&quot;column(autoId);pk&quot;`&quot;</p><h1 md-src-pos=\"566..579\" style=\"font-size: 2.25em; margin: 1em 0px 16px; box-sizing: border-box; line-height: 1.2; position: relative; padding-bottom: 0.3em; border-bottom: 1px solid rgb(44, 44, 44); color: rgb(204, 204, 204); font-family: Helvetica, Arial, freesans, sans-serif; white-space: normal; background-color: rgb(60, 63, 65);\">benchmark</h1><p md-src-pos=\"581..648\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: rgb(204, 204, 204); font-family: Helvetica, Arial, freesans, sans-serif; font-size: 16px; white-space: normal; background-color: rgb(60, 63, 65);\">select by id with five fields execute 1e5 times (not very accurate)</p><blockquote md-src-pos=\"650..748\" style=\"box-sizing: border-box; margin: 0px 0px 16px; padding: 0px 15px; color: rgb(160, 164, 165); border-left: 4px solid rgb(98, 102, 103); font-family: Helvetica, Arial, freesans, sans-serif; white-space: normal; background-color: rgb(60, 63, 65);\"><p md-src-pos=\"652..748\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 0px;\">beegoOrm 13376 milliseconds<br style=\"box-sizing: border-box;\"/>xorm 16718 milliseconds<br style=\"box-sizing: border-box;\"/>yorm 6759 milliseconds</p></blockquote><blockquote md-src-pos=\"750..847\" style=\"box-sizing: border-box; margin: 0px 0px 16px; padding: 0px 15px; color: rgb(160, 164, 165); border-left: 4px solid rgb(98, 102, 103); font-family: Helvetica, Arial, freesans, sans-serif; white-space: normal; background-color: rgb(60, 63, 65);\"><p md-src-pos=\"752..847\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 0px;\">beegoOrm 14149 milliseconds<br style=\"box-sizing: border-box;\"/>xorm 17685 milliseconds<br style=\"box-sizing: border-box;\"/>yorm 7568 milliseconds</p></blockquote><p md-src-pos=\"849..862\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: rgb(204, 204, 204); font-family: Helvetica, Arial, freesans, sans-serif; font-size: 16px; white-space: normal; background-color: rgb(60, 63, 65);\">code is here:</p><pre style=\"overflow: auto; font-family: Consolas, &quot;Liberation Mono&quot;, Menlo, Courier, monospace; font-size: 13.6px; box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; font-stretch: normal; line-height: 1.45; padding: 16px; background-color: rgb(44, 44, 44); border-radius: 3px; overflow-wrap: normal; color: rgb(204, 204, 204);\">package&nbsp;main\r\n\r\nimport&nbsp;(\r\n	&quot;beego/orm&quot;\r\n	&quot;fmt&quot;\r\n	&quot;time&quot;\r\n\r\n	&quot;github.com/JessonChan/fastfunc&quot;\r\n	&quot;github.com/JessonChan/yorm&quot;\r\n	_&nbsp;&quot;github.com/go-sql-driver/mysql&quot;\r\n	&quot;github.com/go-xorm/xorm&quot;\r\n)\r\n\r\nconst&nbsp;db&nbsp;=&nbsp;`root:@tcp(127.0.0.1:3306)/yorm_test?charset=utf8`\r\n\r\ntype&nbsp;ProgramLanguage&nbsp;struct&nbsp;{\r\n	Id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int64\r\n	Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;string\r\n	RankMonth&nbsp;time.Time\r\n	Position&nbsp;&nbsp;int\r\n	Created&nbsp;&nbsp;&nbsp;time.Time\r\n}\r\n\r\nvar&nbsp;engine&nbsp;*xorm.Engine\r\nvar&nbsp;o&nbsp;orm.Ormer\r\n\r\nfunc&nbsp;init()&nbsp;{\r\n	orm.RegisterDataBase(&quot;default&quot;,&nbsp;&quot;mysql&quot;,&nbsp;db)\r\n	orm.RegisterModel(new(ProgramLanguage))\r\n	yorm.Register(db)\r\n	engine,&nbsp;_&nbsp;=&nbsp;xorm.NewEngine(&quot;mysql&quot;,&nbsp;db)\r\n	o&nbsp;=&nbsp;orm.NewOrm()\r\n}\r\n\r\nfunc&nbsp;main()&nbsp;{\r\n	fastfunc.SetRunTimes(1e5)\r\n	fmt.Println(&quot;beegoOrm&quot;,&nbsp;fastfunc.Run(beegoOrm)/1e6,&nbsp;&quot;milliseconds&quot;)\r\n	fmt.Println(&quot;&nbsp;&nbsp;&nbsp;&nbsp;xorm&quot;,&nbsp;fastfunc.Run(xomrTest)/1e6,&nbsp;&quot;milliseconds&quot;)\r\n	fmt.Println(&quot;&nbsp;&nbsp;&nbsp;&nbsp;yorm&quot;,&nbsp;fastfunc.Run(yormTest)/1e6,&nbsp;&quot;milliseconds&quot;)\r\n}\r\n\r\nfunc&nbsp;beegoOrm()&nbsp;{\r\n	p&nbsp;:=&nbsp;ProgramLanguage{Id:&nbsp;1}\r\n	o.Read(&amp;p)\r\n	if&nbsp;p.Name&nbsp;==&nbsp;&quot;&quot;&nbsp;{\r\n		panic(p)\r\n	}\r\n}\r\nfunc&nbsp;yormTest()&nbsp;{\r\n	p&nbsp;:=&nbsp;ProgramLanguage{Id:&nbsp;1}\r\n	yorm.SelectByPK(&amp;p)\r\n	if&nbsp;p.Name&nbsp;==&nbsp;&quot;&quot;&nbsp;{\r\n		panic(p)\r\n	}\r\n}\r\nfunc&nbsp;xomrTest()&nbsp;{\r\n	p&nbsp;:=&nbsp;ProgramLanguage{Id:&nbsp;1}\r\n	engine.Get(&amp;p)\r\n	if&nbsp;p.Name&nbsp;==&nbsp;&quot;&quot;&nbsp;{\r\n		panic(p)\r\n	}\r\n}</pre><p><br/></p>','golang',0,0,1,'2020-02-10 09:40:16','2020-02-10 09:40:16',7,1,'yOrm is a simple,lightweight orm , for mysql only now.','');

/*!40000 ALTER TABLE `cb_post` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cb_tag
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_tag`;

CREATE TABLE `cb_tag` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '标签名',
  `count` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '使用次数',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

LOCK TABLES `cb_tag` WRITE;
/*!40000 ALTER TABLE `cb_tag` DISABLE KEYS */;

INSERT INTO `cb_tag` (`id`, `name`, `count`, `created`, `updated`)
VALUES
	(1,'iPhone',3,'2017-08-08 10:58:39','2017-08-08 10:58:39'),
	(2,'越狱',3,'2017-08-08 10:58:39','2017-08-08 10:58:39');

/*!40000 ALTER TABLE `cb_tag` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cb_tag_post
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_tag_post`;

CREATE TABLE `cb_tag_post` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tag_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '标签id',
  `post_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '内容id',
  PRIMARY KEY (`id`),
  KEY `tagid` (`tag_id`),
  KEY `postid` (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

LOCK TABLES `cb_tag_post` WRITE;
/*!40000 ALTER TABLE `cb_tag_post` DISABLE KEYS */;

INSERT INTO `cb_tag_post` (`id`, `tag_id`, `post_id`)
VALUES
	(1,1,22),
	(2,2,22),
	(3,1,21),
	(4,2,21),
	(5,1,20),
	(6,2,20);

/*!40000 ALTER TABLE `cb_tag_post` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cb_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_user`;

CREATE TABLE `cb_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `login_count` int(11) DEFAULT NULL,
  `last_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `last_ip` varchar(200) DEFAULT 'current_timestamp()',
  `state` tinyint(4) DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

LOCK TABLES `cb_user` WRITE;
/*!40000 ALTER TABLE `cb_user` DISABLE KEYS */;

INSERT INTO `cb_user` (`id`, `username`, `password`, `email`, `login_count`, `last_time`, `last_ip`, `state`, `created`, `updated`)
VALUES
	(1,'admin',' e10adc3949ba59abbe56e057f20f883e','',27,NULL,'127.0.0.1:64686',0,NULL,'2017-08-08 19:48:05');

/*!40000 ALTER TABLE `cb_user` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
