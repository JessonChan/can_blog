package filter

import (
	"github.com/JessonChan/cango"
	"github.com/JessonChan/canlog"
)

type VisitFilter struct {
	cango.Filter `value:"/*"`
}

var _ = cango.RegisterFilter(&VisitFilter{})

func (v *VisitFilter) PreHandle(req *cango.WebRequest) interface{} {
	canlog.CanDebug(req.Method, req.URL.Path, req.RemoteAddr, req.Request.Header.Get("X-Forwarded-For"))
	return true
}
