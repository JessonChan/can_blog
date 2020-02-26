package filter

import (
	"compress/flate"
	"compress/gzip"
	"net/http"

	"github.com/JessonChan/cango"
)

type GzipFilter struct {
	cango.Filter `value:"/*"`
}

var _ = cango.RegisterFilter(&GzipFilter{})

type gzipWriter struct {
	http.ResponseWriter
	gzWriter *gzip.Writer
}

func newGzipWriter(w http.ResponseWriter) *gzipWriter {
	w.Header().Set("Content-Encoding", "gzip")
	return &gzipWriter{ResponseWriter: w, gzWriter: func() *gzip.Writer {
		w, _ := gzip.NewWriterLevel(w, flate.BestCompression)
		return w
	}()}
}

func (gw *gzipWriter) Write(bs []byte) (int, error) {
	n, err := gw.gzWriter.Write(bs)
	return n, err
}
func (gw *gzipWriter) Close() error {
	return gw.gzWriter.Close()
}

func (l *GzipFilter) PreHandle(w http.ResponseWriter, req *http.Request) interface{} {
	return newGzipWriter(w)
}
