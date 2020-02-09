package main

import (
	"html/template"
	"strings"
	"time"

	"github.com/JessonChan/cango"
	"github.com/astaxie/beego"
	_ "github.com/go-sql-driver/mysql"

	"github.com/JessonChan/can_blog/controllers"
	"github.com/JessonChan/can_blog/models"
	_ "github.com/JessonChan/can_blog/routers"
)

func init() {
	models.Init()
	beego.BConfig.WebConfig.Session.SessionOn = true
}

func Str2html(raw string) template.HTML {
	return template.HTML(raw)
}

// DateFormat pattern rules.
var datePatterns = []string{
	// year
	"Y", "2006", // A full numeric representation of a year, 4 digits   Examples: 1999 or 2003
	"y", "06", // A two digit representation of a year   Examples: 99 or 03

	// month
	"m", "01", // Numeric representation of a month, with leading zeros 01 through 12
	"n", "1", // Numeric representation of a month, without leading zeros   1 through 12
	"M", "Jan", // A short textual representation of a month, three letters Jan through Dec
	"F", "January", // A full textual representation of a month, such as January or March   January through December

	// day
	"d", "02", // Day of the month, 2 digits with leading zeros 01 to 31
	"j", "2", // Day of the month without leading zeros 1 to 31

	// week
	"D", "Mon", // A textual representation of a day, three letters Mon through Sun
	"l", "Monday", // A full textual representation of the day of the week  Sunday through Saturday

	// time
	"g", "3", // 12-hour format of an hour without leading zeros    1 through 12
	"G", "15", // 24-hour format of an hour without leading zeros   0 through 23
	"h", "03", // 12-hour format of an hour with leading zeros  01 through 12
	"H", "15", // 24-hour format of an hour with leading zeros  00 through 23

	"a", "pm", // Lowercase Ante meridiem and Post meridiem am or pm
	"A", "PM", // Uppercase Ante meridiem and Post meridiem AM or PM

	"i", "04", // Minutes with leading zeros    00 to 59
	"s", "05", // Seconds, with leading zeros   00 through 59

	// time zone
	"T", "MST",
	"P", "-07:00",
	"O", "-0700",

	// RFC 2822
	"r", time.RFC1123Z,
}

// Date takes a PHP like date func to Go's time format.
func Date(t time.Time, format string) string {
	replacer := strings.NewReplacer(datePatterns...)
	format = replacer.Replace(format)
	return t.Format(format)
}

func main() {
	// beego.Run()
	can := cango.NewCan()
	can.Route(&controllers.PageController{}).
		Route(&controllers.ManageController{}).
		Filter(&controllers.LoginFilter{}, &controllers.ManageController{}).
		RegTplFunc("str2html", Str2html).
		RegTplFunc("date", Date).
		Run(cango.Addr{Port: 8099},
			cango.StaticOpts{TplSuffix: ".html"},
		)
}
