library js_stream_adapter;

import 'dart:async';
import 'dart:collection';

import 'package:js/js.dart';
import 'package:js/js_util.dart' as js_util;

import 'js_facade/promise.dart';

Stream<T> callbackToStream<J, T>(
    Object object, String name, T Function(J jsValue) unwrapValue) {
  // ignore: close_sinks
  StreamController<T> controller = StreamController.broadcast(sync: true);
  js_util.setProperty(object, name, allowInterop((J event) {
    controller.add(unwrapValue(event));
  }));
  return controller.stream;
}

Future<T> promiseToFuture<J, T>(Promise<J> promise,
    [T Function(J jsValue)? unwrapValue]) {
  // TODO: handle if promise object is already a future.
  var completer = Completer<T>();
  promise.then(allowInterop((value) {
    T? unwrapped;
    if (unwrapValue == null) {
      unwrapped = value as T;
    } else if (value != null) {
      unwrapped = unwrapValue(value);
    }
    completer.complete(unwrapped);
  }), allowInterop((error) {
    completer.completeError(error as Object);
  }));
  return completer.future;
}

Promise<J> futureToPromise<T, J>(Future<T> future,
    [J Function(T value)? wrapValue]) {
  return Promise<J>(
    allowInterop(
      (void Function(J value) resolveFn,
          void Function(Object? error) rejectFn) {
        future.then((value) {
          dynamic wrapped;
          if (wrapValue != null) {
            wrapped = wrapValue(value);
          } else if (value != null) {
            wrapped = value;
          }
          resolveFn(wrapped as J);
        }).catchError((error) {
          rejectFn(error);
        });
      },
    ),
  );
}

Iterable<T> iteratorToIterable<T>(Function iteratorGetter) =>
    _Iterable<T>(iteratorGetter);

class _Iterator<R> implements Iterator<R> {
  final Object _object;
  R? _current;
  _Iterator(this._object);

  @override
  R get current => _current!;

  @override
  bool moveNext() {
    var m = js_util.callMethod(_object, 'next', []) as Object;
    bool hasValue = js_util.getProperty(m, 'done') == false;
    _current = hasValue ? js_util.getProperty(m, 'value') as R? : null;
    return hasValue;
  }
}

class _Iterable<R> extends IterableMixin<R> {
  final Function _getter;
  _Iterable(this._getter);

  @override
  Iterator<R> get iterator => _Iterator(_getter() as Object);
}
