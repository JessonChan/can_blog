package filter

import (
	"compress/gzip"
	"net/http"

	"github.com/JessonChan/cango"
)

// 对静态文件进行压缩处理，只适合于静态文件
// 其它情况不适合
type GzipFilter struct {
	cango.Filter `value:"/static/*"`
}

var _ = cango.RegisterFilter(&GzipFilter{})

type gzipWriter struct {
	http.ResponseWriter
	gzWriter *gzip.Writer
}

func newGzipWriter(w http.ResponseWriter) *gzipWriter {
	w.Header().Set("Content-Encoding", "gzip")
	return &gzipWriter{ResponseWriter: w, gzWriter: gzip.NewWriter(w)}
}

func (gw *gzipWriter) Write(bs []byte) (int, error) {
	n, err := gw.gzWriter.Write(bs)
	_ = gw.gzWriter.Close()
	return n, err
}

func (l *GzipFilter) PreHandle(w http.ResponseWriter, req *http.Request) interface{} {
	return newGzipWriter(w)
}
