library js_stream_adapter;

import 'dart:async';
import 'dart:collection';

import 'package:js/js.dart';
import 'package:js/js_util.dart' as js_util;

import 'js_facade/promise.dart';

Stream<T> callbackToStream<J, T>(
    dynamic object, String name, T unwrapValue(J jsValue)) {
  // ignore: close_sinks
  StreamController<T> controller = new StreamController.broadcast(sync: true);
  js_util.setProperty(object, name, allowInterop((J event) {
    controller.add(unwrapValue(event));
  }));
  return controller.stream;
}

Future<T> promiseToFuture<J, T>(Promise<J> promise,
    [T unwrapValue(J jsValue)]) {
  // TODO: handle if promise object is already a future.
  Completer<T> completer = new Completer();
  promise.then(allowInterop((value) {
    T unwrapped;
    if (unwrapValue == null) {
      unwrapped = value as T;
    } else if (value != null) {
      unwrapped = unwrapValue(value);
    }
    completer.complete(unwrapped);
  }), allowInterop((error) {
    completer.completeError(error);
  }));
  return completer.future;
}

Promise<J> futureToPromise<T, J>(Future<T> future, [J wrapValue(T value)]) {
  return new Promise<J>(
    allowInterop(
      (void resolveFn(J value), void rejectFn(error)) {
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
    new _Iterable(iteratorGetter);

class _Iterator<R> implements Iterator<R> {
  final dynamic _object;
  R _current;
  _Iterator(this._object);

  @override
  R get current => _current;

  @override
  bool moveNext() {
    dynamic m = js_util.callMethod(_object, 'next', []);
    bool hasValue = js_util.getProperty(m, 'done') == false;
    _current = hasValue ? js_util.getProperty(m, 'value') as R : null;
    return hasValue;
  }
}

class _Iterable<R> extends IterableMixin<R> {
  final Function _getter;
  _Iterable(this._getter);

  @override
  Iterator<R> get iterator => new _Iterator(_getter());
}
