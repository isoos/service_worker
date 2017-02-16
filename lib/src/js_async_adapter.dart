library js_stream_adapter;

import 'dart:async';

import 'package:func/func.dart';
import 'package:js/js.dart';
import 'package:js/js_util.dart' as js_util;

import 'js_facade/promise.dart';

Stream<T> callbackToStream<J, T>(dynamic object, String name, Func1<J, T> unwrapValue) {
  // ignore: close_sinks
  StreamController<T> controller = new StreamController.broadcast(sync: true);
  js_util.setProperty(object, name, allowInterop((J event) {
    controller.add(unwrapValue(event));
  }));
  return controller.stream;
}

Future<T> promiseToFuture<J, T>(Promise<J> promise, [Func1<J, T> unwrapValue]) {
  // TODO: handle if promise object is already a future.
  Completer<T> completer = new Completer();
  promise.then(allowInterop((value) {
    T unwrapped;
    if (unwrapValue == null) {
      unwrapped = value;
    } else if (value != null) {
      unwrapped = unwrapValue(value);
    }
    completer.complete(unwrapped);
  }), allowInterop((error) {
    completer.completeError(error);
  }));
  return completer.future;
}

Promise futureToPromise(Future future, [Func1 wrapValue]) {
  return new Promise(allowInterop((VoidFunc1 resolve, VoidFunc1 reject) {
    future.then((value) {
      dynamic wrapped;
      if (wrapValue != null) {
        wrapped = wrapValue(value);
      } else if (value != null) {
        wrapped = value;
      }
      resolve(wrapped);
    }).catchError((error) {
      reject(error);
    });
  }));
}
