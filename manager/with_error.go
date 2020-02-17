package manager

import (
	"github.com/JessonChan/canlog"
)

func withError(fn func() error) {
	err := fn()
	if err != nil {
		canlog.CanOutput(4, canlog.LError, err.Error())
	}
}
