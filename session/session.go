package session

import (
	"github.com/gorilla/sessions"
)

var LocalSession = sessions.NewCookieStore([]byte("can_blog_lg"))

const UserCookieName = "__user"
