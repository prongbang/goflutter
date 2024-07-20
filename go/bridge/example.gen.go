// This code was generated by flutter-go-bridge. Do not manually edit.
package main

import (
	"errors"
	"fmt"
	"unsafe"

	orig "com.github.com/prongbang/example"
	"github.com/csnewman/flutter-go-bridge/runtime"
)

/*
#include <stdlib.h>
#include <stdint.h>

typedef struct {
	int res;
	void* err;
} fgb_ret_add;
*/
import "C"

var ErrDart = errors.New("dart")

// Required by cgo
func main() {}

func mapToString(from unsafe.Pointer) string {
	res := C.GoString((*C.char)(from))
	C.free(from)
	return res
}

func mapFromString(from string) unsafe.Pointer {
	return unsafe.Pointer(C.CString(from))
}

func mapToError(from unsafe.Pointer) error {
	res := C.GoString((*C.char)(from))
	C.free(from)
	return fmt.Errorf("%w: %v", ErrDart, res)
}

func mapFromError(from error) unsafe.Pointer {
	return unsafe.Pointer(C.CString(from.Error()))
}

//export fgb_add
func fgb_add(arg_a C.int, arg_b C.int) (resw C.fgb_ret_add) {
	defer func() {
		r := recover()
		if r == nil {
			return
		}

		resw = C.fgb_ret_add{
			err: unsafe.Pointer(C.CString(fmt.Sprintf("panic: %v", r))),
		}
	}()
	
	arggo_a := (int)(arg_a)
	arggo_b := (int)(arg_b)
	gres := orig.Add(arggo_a, arggo_b)
	
	cres := (C.int)(gres)

	return C.fgb_ret_add{
		res: cres,
	}
}

//export fgbasync_add
func fgbasync_add(arg_a C.int, arg_b C.int, fgbPort int64) {
	go func() {
		value := fgb_add(arg_a, arg_b)
		ptr := runtime.Pin(value)
		h := uint64(ptr)

		sent := runtime.Send(fgbPort, []uint64{h}, func() {
			runtime.FreePin(ptr)
		})
		if !sent {
			runtime.FreePin(ptr)
		}
	}()
}

//export fgbasyncres_add
func fgbasyncres_add(h uint64) C.fgb_ret_add {
	ptr := uintptr(h)
	return runtime.GetPin[C.fgb_ret_add](ptr)
}
