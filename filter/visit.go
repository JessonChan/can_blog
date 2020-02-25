package filter

import (
	"net/http"

	"github.com/JessonChan/cango"
	"github.com/JessonChan/canlog"
)

type VisitFilter struct {
	cango.Filter `value:"/*"`
}

var _ = cango.RegisterFilter(&VisitFilter{})

func (v *VisitFilter) PreHandle(req *http.Request) interface{} {
	canlog.CanDebug(req.Method, req.URL.Path, req.RemoteAddr, req.Header.Get("X-Forwarded-For"))
	return true
}
