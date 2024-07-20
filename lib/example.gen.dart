import 'dart:ffi' as ffi;
import 'dart:isolate';
import 'package:ffi/ffi.dart';

final class BridgeException implements Exception {
  String cause;

  BridgeException(this.cause);

  @override
  String toString() {
    return 'BridgeException: $cause';
  }
}

abstract interface class Bridge {
  factory Bridge.open() {
    return _FfiBridge();
  }

  int add(int a, int b);

  Future<int> addAsync(int a, int b);
}

@ffi.Native<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>(symbol: "fgbinternal_init")
external ffi.Pointer<ffi.Void> _fgbInternalInit(ffi.Pointer<ffi.Void> arg0);

@ffi.Native<ffi.Pointer Function(ffi.IntPtr)>(symbol: "fgbinternal_alloc")
external ffi.Pointer _fgbInternalAlloc(int arg0);

@ffi.Native<ffi.Void Function(ffi.Pointer)>(symbol: "fgbinternal_free")
external void _fgbInternalFree(ffi.Pointer arg0);

@ffi.Native<ffi.Void Function(ffi.Pointer<ffi.Void>)>(symbol: "fgbinternal_freepin")
external void _fgbInternalFreePin(ffi.Pointer<ffi.Void> arg0);

ffi.Pointer<ffi.NativeFinalizerFunction> _fgbInternalFreePinPtr = ffi.Native.addressOf(_fgbInternalFreePin);

class _GoAllocator implements ffi.Allocator {
  const _GoAllocator();

  @override
  ffi.Pointer<T> allocate<T extends ffi.NativeType>(int byteCount, {int? alignment}) {
    ffi.Pointer<T> result = _fgbInternalAlloc(byteCount).cast();
    if (result.address == 0) {
      throw ArgumentError('Could not allocate $byteCount bytes.');
    }
    return result;
  }

  @override
  void free(ffi.Pointer pointer) {
  	_fgbInternalFree(pointer);
  }
}

final class _FgbRetAdd extends ffi.Struct {
  @ffi.Int()
  external int res;
  external ffi.Pointer<ffi.Void> err;
}

@ffi.Native<_FgbRetAdd Function(ffi.Int, ffi.Int)>(symbol: "fgb_add")
external _FgbRetAdd _fgbAdd(int arg0, int arg1);

@ffi.Native<ffi.Void Function(ffi.Int, ffi.Int, ffi.Uint64)>(symbol: "fgbasync_add")
external void _fgbAsyncAdd(int arg0, int arg1, int argPtr);

@ffi.Native<_FgbRetAdd Function(ffi.Uint64)>(symbol: "fgbasyncres_add")
external _FgbRetAdd _fgbAsyncResAdd(int arg0);

final class _FfiBridge implements Bridge {
  late _GoAllocator _allocator;
  late ffi.NativeFinalizer _pinFinalizer;

  _FfiBridge() {
    _allocator = const _GoAllocator();
    _pinFinalizer = ffi.NativeFinalizer(_fgbInternalFreePinPtr);

    var initRes = _fgbInternalInit(ffi.NativeApi.initializeApiDLData);
    if (initRes != ffi.nullptr) {
      var errPtr = ffi.Pointer<Utf8>.fromAddress(initRes.address);
      var errMsg = errPtr.toDartString(); 
      _allocator.free(errPtr);

      throw BridgeException(errMsg);
    }
  }

  @override
  int add(int a, int b) {
    var __Dart__a = a;
    var __Dart__b = b;
    return _processAdd(_fgbAdd(__Dart__a, __Dart__b));
  }

  @override
  Future<int> addAsync(int a, int b) async {
    var __Dart__a = a;
    var __Dart__b = b;
    var __DartRecv__ = ReceivePort('AsyncRecv(add)');
    _fgbAsyncAdd(__Dart__a, __Dart__b, __DartRecv__.sendPort.nativePort);
    var __DartMsg__ = await __DartRecv__.first;
    __DartRecv__.close();
    return _processAdd(_fgbAsyncResAdd(__DartMsg__[0]));
  }

  int _processAdd(_FgbRetAdd res) {
    if (res.err != ffi.nullptr) {
      var errPtr = ffi.Pointer<Utf8>.fromAddress(res.err.address);
      var errMsg = errPtr.toDartString(); 
      _allocator.free(errPtr);

      throw BridgeException(errMsg);
    }
    return res.res;
  }


  String _mapToString(ffi.Pointer<ffi.Void> from) {
    var res = ffi.Pointer<Utf8>.fromAddress(from.address).toDartString();
    _allocator.free(from);
    return res;
  }

  ffi.Pointer<ffi.Void> _mapFromString(String from) {
    var res = from.toNativeUtf8(allocator: _allocator);
    return ffi.Pointer<ffi.Void>.fromAddress(res.address);
  }
}
