package filter

import (
	"compress/flate"
	"compress/gzip"
	"io"
	"net/http"
	"reflect"
	"strings"

	"github.com/JessonChan/cango"
	"github.com/JessonChan/canlog"
)

type GzipFilter struct {
	cango.Filter `value:"/*"`
}

var _ = cango.RegisterFilter(&GzipFilter{})

type gzipWriter struct {
	http.ResponseWriter
	gzWriter *gzip.Writer
}

var writerType = reflect.TypeOf(&gzipWriter{})

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
	if strings.Contains(req.Header.Get("Accept-Encoding"), "gzip") {
		return newGzipWriter(w)
	}
	return true
}

func (l *GzipFilter) PostHandle(w http.ResponseWriter, req *http.Request) interface{} {
	if reflect.TypeOf(w) == writerType {
		err := w.(io.Closer).Close()
		if err != nil {
			canlog.CanError(err)
		}
	}
	return true
}
