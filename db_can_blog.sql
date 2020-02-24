# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.28)
# Database: can_blog
# Generation Time: 2020-02-24 12:16:27 +0000
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cb_comment` WRITE;
/*!40000 ALTER TABLE `cb_comment` DISABLE KEYS */;

INSERT INTO `cb_comment` (`id`, `username`, `content`, `created`, `ip`, `post_id`)
VALUES
	(18,'好的好的','<p><span>你的颈椎病找到好的治疗方法了吗？你还在为你的颈椎病，找不到好的医生而烦恼吗？</span></p>','2020-02-10 18:42:53','127.0.0.1:57071',27);

/*!40000 ALTER TABLE `cb_comment` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cb_config
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_config`;

CREATE TABLE `cb_config` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `cb_post` WRITE;
/*!40000 ALTER TABLE `cb_post` DISABLE KEYS */;

INSERT INTO `cb_post` (`id`, `user_id`, `title`, `url`, `content`, `tags`, `views`, `status`, `is_top`, `created`, `updated`, `category_id`, `types`, `info`, `image`)
VALUES
	(23,1,'欢迎使用can_blog','','<p>基于Go语言和cango框架 前端使用layui 布局 开发的个人博客系统 代码主要由 https://github.com/Echosong/beego_blog 完成，感谢ES @Echosong 的授权</p>','cango',53,0,1,'2020-02-09 21:37:26','2020-02-24 20:14:15',2,1,'cango是一个好用web开发框架',''),
	(24,1,'can_blog简易博客系统','','<p>你好，这是一篇使用can_blog博客系统的博客。</p>','golang,博客',54,0,1,'2020-02-09 21:42:10','2020-02-24 20:14:25',4,1,'can_blog是基于cango web开发框架的博客程序。',''),
	(26,1,'Yorm介绍','','<h1 class=\"unchanged rich-diff-level-one\" style=\"box-sizing: border-box; margin: 24px 0px 16px; line-height: 1.25; padding-bottom: 0.3em; border-bottom: 1px solid rgb(234, 236, 239); color: rgb(36, 41, 46); font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; white-space: normal; background-color: rgb(255, 255, 255);\">README</h1><p class=\"unchanged rich-diff-level-one\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; font-size: 16px; white-space: normal; background-color: rgb(255, 255, 255);\">yOrm is a simple,lightweight orm , for mysql only now.</p><h3 class=\"unchanged rich-diff-level-one\" style=\"box-sizing: border-box; margin-top: 24px; margin-bottom: 16px; font-size: 1.25em; line-height: 1.25; color: rgb(36, 41, 46); font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; white-space: normal; background-color: rgb(255, 255, 255);\">Why this project calls yOrm</h3><p class=\"unchanged rich-diff-level-one\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; font-size: 16px; white-space: normal; background-color: rgb(255, 255, 255);\">yOrm is just a name. more about the detail, cc [<a href=\"https://github.com/lewgun\" style=\"box-sizing: border-box; background-color: initial; color: rgb(3, 102, 214); text-decoration-line: none;\">https://github.com/lewgun</a>]</p><h3 class=\"unchanged rich-diff-level-one\" style=\"box-sizing: border-box; margin-top: 24px; margin-bottom: 16px; font-size: 1.25em; line-height: 1.25; color: rgb(36, 41, 46); font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; white-space: normal; background-color: rgb(255, 255, 255);\">What is this yOrm for?</h3><ul class=\"unchanged rich-diff-level-one list-paddingleft-2\" style=\"box-sizing: border-box; padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; white-space: normal; background-color: rgb(255, 255, 255);\"><li><p>A simple mysql orm to crud</p></li></ul><h2 class=\"unchanged rich-diff-level-one\" style=\"box-sizing: border-box; margin-top: 24px; margin-bottom: 16px; line-height: 1.25; padding-bottom: 0.3em; border-bottom: 1px solid rgb(234, 236, 239); color: rgb(36, 41, 46); font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; white-space: normal; background-color: rgb(255, 255, 255);\">Tags</h2><p class=\"unchanged rich-diff-level-one\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; font-size: 16px; white-space: normal; background-color: rgb(255, 255, 255);\">Now support these types of tag.</p><h3 class=\"unchanged rich-diff-level-one\" style=\"box-sizing: border-box; margin-top: 24px; margin-bottom: 16px; font-size: 1.25em; line-height: 1.25; color: rgb(36, 41, 46); font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; white-space: normal; background-color: rgb(255, 255, 255);\">column</h3><p class=\"unchanged rich-diff-level-one\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; font-size: 16px; white-space: normal; background-color: rgb(255, 255, 255);\">this tag alias struct name to a real column name. &quot;Id int `yorm:&quot;column(autoId)&quot;`&quot; means this field Id will name autoId in mysql column</p><h3 class=\"unchanged rich-diff-level-one\" style=\"box-sizing: border-box; margin-top: 24px; margin-bottom: 16px; font-size: 1.25em; line-height: 1.25; color: rgb(36, 41, 46); font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; white-space: normal; background-color: rgb(255, 255, 255);\">pk</h3><p class=\"unchanged rich-diff-level-one\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; font-size: 16px; white-space: normal; background-color: rgb(255, 255, 255);\">this tag allow you to set a primary key where select/delete/update as the where clause &quot;Id int `yorm:&quot;column(autoId);pk&quot;`&quot;</p><h1 class=\"unchanged rich-diff-level-one\" style=\"box-sizing: border-box; margin: 24px 0px 16px; line-height: 1.25; padding-bottom: 0.3em; border-bottom: 1px solid rgb(234, 236, 239); color: rgb(36, 41, 46); font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; white-space: normal; background-color: rgb(255, 255, 255);\">benchmark</h1><p class=\"unchanged rich-diff-level-one\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; font-size: 16px; white-space: normal; background-color: rgb(255, 255, 255);\">select by id with five fields execute 1e5 times (not very accurate)</p><blockquote class=\"unchanged rich-diff-level-one\" style=\"box-sizing: border-box; margin: 0px 0px 16px; padding: 0px 1em; color: rgb(106, 115, 125); border-left: 0.25em solid rgb(223, 226, 229); font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; white-space: normal; background-color: rgb(255, 255, 255);\"><p class=\"unchanged\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 0px;\">beegoOrm 13376 milliseconds<br style=\"box-sizing: border-box;\"/>xorm 16718 milliseconds<br style=\"box-sizing: border-box;\"/>yorm 6759 milliseconds</p></blockquote><blockquote class=\"unchanged rich-diff-level-one\" style=\"box-sizing: border-box; margin: 0px 0px 16px; padding: 0px 1em; color: rgb(106, 115, 125); border-left: 0.25em solid rgb(223, 226, 229); font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; white-space: normal; background-color: rgb(255, 255, 255);\"><p class=\"unchanged\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 0px;\">beegoOrm 14149 milliseconds<br style=\"box-sizing: border-box;\"/>xorm 17685 milliseconds<br style=\"box-sizing: border-box;\"/>yorm 7568 milliseconds</p></blockquote><p class=\"unchanged rich-diff-level-one\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; font-size: 16px; white-space: normal; background-color: rgb(255, 255, 255);\">code is here:</p><pre class=\"unchanged rich-diff-level-one\" style=\"box-sizing: border-box; font-family: SFMono-Regular, Consolas, &quot;Liberation Mono&quot;, Menlo, monospace; font-size: 13.6px; margin-top: 0px; margin-bottom: 16px; overflow-wrap: normal; padding: 10px 20px; overflow: auto; line-height: 1.45; background-color: rgb(246, 248, 250); border-radius: 3px; color: rgb(36, 41, 46);\">package&nbsp;main\r\n\r\nimport&nbsp;(\r\n	&quot;beego/orm&quot;\r\n	&quot;fmt&quot;\r\n	&quot;time&quot;\r\n\r\n	&quot;github.com/JessonChan/fastfunc&quot;\r\n	&quot;github.com/JessonChan/yorm&quot;\r\n	_&nbsp;&quot;github.com/go-sql-driver/mysql&quot;\r\n	&quot;github.com/go-xorm/xorm&quot;\r\n)\r\n\r\nconst&nbsp;db&nbsp;=&nbsp;`root:@tcp(127.0.0.1:3306)/yorm_test?charset=utf8`\r\n\r\ntype&nbsp;ProgramLanguage&nbsp;struct&nbsp;{\r\n	Id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int64\r\n	Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;string\r\n	RankMonth&nbsp;time.Time\r\n	Position&nbsp;&nbsp;int\r\n	Created&nbsp;&nbsp;&nbsp;time.Time\r\n}\r\n\r\nvar&nbsp;engine&nbsp;*xorm.Engine\r\nvar&nbsp;o&nbsp;orm.Ormer\r\n\r\nfunc&nbsp;init()&nbsp;{\r\n	orm.RegisterDataBase(&quot;default&quot;,&nbsp;&quot;mysql&quot;,&nbsp;db)\r\n	orm.RegisterModel(new(ProgramLanguage))\r\n	yorm.Register(db)\r\n	engine,&nbsp;_&nbsp;=&nbsp;xorm.NewEngine(&quot;mysql&quot;,&nbsp;db)\r\n	o&nbsp;=&nbsp;orm.NewOrm()\r\n}\r\n\r\nfunc&nbsp;main()&nbsp;{\r\n	fastfunc.SetRunTimes(1e5)\r\n	fmt.Println(&quot;beegoOrm&quot;,&nbsp;fastfunc.Run(beegoOrm)/1e6,&nbsp;&quot;milliseconds&quot;)\r\n	fmt.Println(&quot;&nbsp;&nbsp;&nbsp;&nbsp;xorm&quot;,&nbsp;fastfunc.Run(xomrTest)/1e6,&nbsp;&quot;milliseconds&quot;)\r\n	fmt.Println(&quot;&nbsp;&nbsp;&nbsp;&nbsp;yorm&quot;,&nbsp;fastfunc.Run(yormTest)/1e6,&nbsp;&quot;milliseconds&quot;)\r\n}\r\n\r\nfunc&nbsp;beegoOrm()&nbsp;{\r\n	p&nbsp;:=&nbsp;ProgramLanguage{Id:&nbsp;1}\r\n	o.Read(&amp;p)\r\n	if&nbsp;p.Name&nbsp;==&nbsp;&quot;&quot;&nbsp;{\r\n		panic(p)\r\n	}\r\n}\r\nfunc&nbsp;yormTest()&nbsp;{\r\n	p&nbsp;:=&nbsp;ProgramLanguage{Id:&nbsp;1}\r\n	yorm.SelectByPK(&amp;p)\r\n	if&nbsp;p.Name&nbsp;==&nbsp;&quot;&quot;&nbsp;{\r\n		panic(p)\r\n	}\r\n}\r\nfunc&nbsp;xomrTest()&nbsp;{\r\n	p&nbsp;:=&nbsp;ProgramLanguage{Id:&nbsp;1}\r\n	engine.Get(&amp;p)\r\n	if&nbsp;p.Name&nbsp;==&nbsp;&quot;&quot;&nbsp;{\r\n		panic(p)\r\n	}\r\n}</pre><p><code style=\"box-sizing: border-box; font-family: SFMono-Regular, Consolas, &quot;Liberation Mono&quot;, Menlo, monospace; font-size: 13.6px; padding: 0px; margin: 0px; background: initial; border-radius: 3px; word-break: normal; border: 0px; display: inline; overflow: visible; line-height: inherit; overflow-wrap: normal;\"><br/></code></p><p><br/></p>','golang',52,0,1,'2020-02-10 09:40:16','2020-02-24 20:14:33',7,1,'yOrm is a simple,lightweight orm , for mysql only now.',''),
	(28,1,'2个颈椎病自我锻炼方法，让你的颈椎康复疗效倍增！','','<p style=\"margin-top: 0px; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">李国民：2个颈椎病自我锻炼方法，让你的颈椎康复疗效倍增！</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">从今天开始你就去做，OK吗？ 。每天写一篇文章，分享我的实际治疗经验和案例，希望给你些启发和帮助 。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">今是元宵节，首先祝你元宵节快乐！</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">元宵节过完就说明年就过完了，李医生我今天起了一个大早，就开始写今天的文章。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">今天我居然不记得今天是元宵节，本来我说元宵节我不直播的，但是我还是要直播。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">因为说过的事情还是要坚持，还是需要给你持续的分享。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">所以当你开始决定自我锻炼的时候，那么你就需要持续的去做。一定不要等到很严重的时候才去做自我锻炼。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">每当你想开始做的时候，可能已经拖得很晚了。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">昨天直播的时候也有个朋友问我，他说他治疗了一两年还一点效果没有，问我做自我锻炼晚不晚？</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">其实并不算晚，你要知道你已经开始做了，你后面还有百分之七八十，八九十的人，还没有开始。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">今天想跟你分享一下，做自我锻炼应该如何去做。</p><h2 style=\"margin: 2.33333em 0px 1.16667em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); font-size: 1.2em; font-weight: 400; color: rgb(68, 68, 68); font-family: inherit; font-style: inherit; font-variant: inherit; white-space: normal; background-color: rgb(255, 255, 255); font-stretch: inherit; line-height: 1.5; clear: left;\">一、你需要做的基础锻炼。</h2><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">昨天好几个朋友在问我的时候，他说他应该做什么锻炼。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">你应该做的锻炼是根据你颈椎的情况来，当然有一些基础的自我锻炼是可以马上去做的。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">今天李医生给你推荐两个，必须要去做的锻炼：</p><blockquote style=\"margin: 1.4em 0px; padding: 0px 0px 0px 1em; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(100, 100, 100); border-left: 3px solid rgb(211, 211, 211);\">1、靠墙站立训练</blockquote><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">靠墙站立训练，应该是所有训练中最基础的。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">不过你有听李医生昨天直播的时候，昨天直播上就有人，他做了两三天的锻炼</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">然后他就觉得他的颈椎舒服多了，而且他的脖子的僵硬，和这种脖子的疼痛改善了很多。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">很正常，因为你做了自我锻炼，一定会比没做的，你的恢复会好一些。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\"><span style=\"font-weight: 600;\">第1步，</span>你的身体的后背、后脑勺以及你的臀部都靠到墙上去，同时你的脚后跟，距离墙壁是5~10厘米。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\"><span style=\"font-weight: 600;\">第2步，</span>你的面部是垂直于地面的，你的下巴不能翘起，也不能低下，同时你两个肩胛骨的后面，去找贴墙的感觉。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\"><span style=\"font-weight: 600;\">第3步，</span>想像有一根绳子在你的头顶上，往上拉。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">这三个步骤非常的简单，你只要持续去做，一定会有效果。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">你每天做三次，每次做5分钟。</p><blockquote style=\"margin: 1.4em 0px; padding: 0px 0px 0px 1em; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(100, 100, 100); border-left: 3px solid rgb(211, 211, 211);\">2、眼球训练</blockquote><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">昨天直播分享的是头晕的课，昨天分享的这个案例就是一个头晕的患者，四川的，40多岁，他是一名电工，他当时是因为头晕，然后整天都在家里，哪里都去不了，非常的厉害。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">我就给他推荐了眼球训练，因为我通过评估之后，他是属于前庭的问题。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">他做了眼球训练，做了将近有个把月的时候，他就告诉我，他的头晕就改善了90%。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">然后一年后，也就是昨天他给我发信息告诉我，他说他头晕，现在基本上已经好了。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">如果说你有李医生我的朋友圈，你就可以看到，其实他的效果是非常好的，一年了，他居然没有复发。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\"><span style=\"font-weight: 600;\">你说眼球训练，你现在需不需要去做？</span></p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">眼球训练还有一个更重要的效果，它可以强化你颈椎的力量，比你自己去做其他的健身房的锻炼要强得多。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\"><span style=\"font-weight: 600;\">首先，</span>在与眼睛同高的墙壁上，画一个实心的圆点，大小和拇指粗细不多。眼睛距离这个圆点，是1米的距离。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\"><span style=\"font-weight: 600;\">其次，</span>左右来回转动你的头部，同时你的眼睛盯着这个圆点不离开。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\"><span style=\"font-weight: 600;\">最后，</span>向左向右转动的幅度不能超过30度。一定记住是水平方向的转动，不是说随便的转。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">眼球训练，你每天可以做3次，每次可以做2~3分钟没有问题。</p><h2 style=\"margin: 2.33333em 0px 1.16667em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); font-size: 1.2em; font-weight: 400; color: rgb(68, 68, 68); font-family: inherit; font-style: inherit; font-variant: inherit; white-space: normal; background-color: rgb(255, 255, 255); font-stretch: inherit; line-height: 1.5; clear: left;\">二、锻炼的时间</h2><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">我建议你，如果你开始锻炼了，那么你就要持续的做下去，不要说今天做一下，明天又停一下，这样是看不到效果的。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">还有一点，你锻炼的时间最好是能够固定起来，今天是早上做，那么你明天应该也是早上做，不要今天早上做，明天就是晚上做，这样是不对的。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">自我锻炼的效果，一定是连续的持续的去做，这样你的效果会更加的明显。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">切记你在做锻炼的时候，不要三天打渔两天晒网。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">你不能够坚持下来，那么你的颈椎情况好不了，也是正常的</p><h2 style=\"margin: 2.33333em 0px 1.16667em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); font-size: 1.2em; font-weight: 400; color: rgb(68, 68, 68); font-family: inherit; font-style: inherit; font-variant: inherit; white-space: normal; background-color: rgb(255, 255, 255); font-stretch: inherit; line-height: 1.5; clear: left;\">三、锻炼的强度</h2><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">锻炼的强度，我要跟你说一下，一般李医生我所有的锻炼，有一个前提。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">这个前提就是，你在做所有的锻炼，必须是没有不舒服。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">你不要想到一下子你就做100次，把100天的或者 10多天的训练一次性做完。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">这样不但没有效果，还会起反作用，因为我说过，这个自我锻炼是需要你每天去做的，而不是你一天把所有的都做完。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">如果你一天把所有的锻炼都做完，把一个月的都做完，你这不是打肿脸充胖子吗？是没有必要的。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">如果说你做的过程中，有不舒服的时候，及时跟李医生我互动，可以来咨询我，因为有可能是你做的不对，也有可能你存在其他的问题。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">原则上95%以上做自我锻炼的时候，是没有不舒服的啊，所以要找你的原因。</p><h2 style=\"margin: 2.33333em 0px 1.16667em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); font-size: 1.2em; font-weight: 400; color: rgb(68, 68, 68); font-family: inherit; font-style: inherit; font-variant: inherit; white-space: normal; background-color: rgb(255, 255, 255); font-stretch: inherit; line-height: 1.5; clear: left;\">四、注意事项</h2><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">自我锻炼的注意事项，主要有3点：</p><blockquote style=\"margin: 1.4em 0px; padding: 0px 0px 0px 1em; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(100, 100, 100); border-left: 3px solid rgb(211, 211, 211);\">1、听话照做。</blockquote><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">也就是说你在做这些锻炼的时候，你需要持续的去做。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">还有就是当你的症状好转之后，尽量不要停，因为你要让他至少有半年的时间不会复发。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">当你的症状好转的时候，你还是要持续去做，说明你的自我锻炼是对的。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">这一点很关键。</p><blockquote style=\"margin: 1.4em 0px; padding: 0px 0px 0px 1em; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(100, 100, 100); border-left: 3px solid rgb(211, 211, 211);\">2、正确的做</blockquote><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">就是说你在做自我锻炼的时候，你不要做错了，当你做错的时候做的，没有效果的时候，你要过来咨询我做个互动。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">也就是说你要做的一定要正确，当然你有看李医生的直播，你当然可以看到我是怎么去做的。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">最好的办法直接把你做的发给我，我给你指导，这是最简单的。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">所以说你要做的，你一定要做正确，这个很重要。</p><blockquote style=\"margin: 1.4em 0px; padding: 0px 0px 0px 1em; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(100, 100, 100); border-left: 3px solid rgb(211, 211, 211);\">3、不要一次性做。</blockquote><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">在所有的自我锻炼里，切记不要做的太过。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">昨天就有一个朋友，他说他每次做眼球训练，做半个小时，一个眼球训练，如果说你做半个小时，那肯定眼睛会累啊。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">而且做半个小时太久了，既然你可以做很久的话，你就把半个小时分成三次对不对？每次就做10分钟，这样不是更好。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">好锻炼一定是分次做，你一次性做完效果不见得好。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">你可以每天在你办公桌上面，写一个早上几点钟做眼球训练，中午几点钟做眼球训练，下午几点钟做眼睛训练，非常简单的。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">就当做一日三餐来进行治疗，对不对？</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">所以说不要大幅度大强度的去做。</p><p style=\"margin-top: 1.4em; margin-bottom: 1.4em; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">从今天开始你就去做，OK吗？</p><p style=\"margin-top: 1.4em; margin-bottom: 0px; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\"><span style=\"font-weight: 600;\">你是不是担心你的颈椎病会治不好？</span>你的颈椎病找到好的治疗方法了吗？你还在为你的颈椎病，找不到好的医生而烦恼吗？</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); color: rgb(68, 68, 68); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, 微软雅黑, Tahoma, Arial, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">发布于 2020-02-08</p><p><br/></p>','颈椎病',15,0,1,'2020-02-21 18:09:08','2020-02-24 20:15:53',2,1,'昨天好几个朋友在问我的时候，他说他应该做什么锻炼。\r\n\r\n你应该做的锻炼是根据你颈椎的情况来，当然有一些基础的自我锻炼是可以马上去做的。\r\n\r\n今天李医生给你推荐两个，必须要去做的锻炼：','');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
