@JS()
library es6_promise;

import 'package:js/js.dart';

/// Type definitions for es6-promise
/// Project: https://github.com/jakearchibald/ES6-Promise
/// Definitions by: François de Campredon <https://github.com/fdecampredon/>, vvakame <https://github.com/vvakame>
/// Definitions: https://github.com/DefinitelyTyped/DefinitelyTyped
@anonymous
@JS()
abstract class Thenable<T> {
  external Thenable<U> then<U>(
      [Thenable<U> Function(T value)? onFulfilled,
      Function? /* Func1<dynamic, U|Thenable<U>>|VoidFunc1<dynamic> */ onRejected]);
}

@JS()
class Promise<T> implements Thenable<T> {
  // @Ignore
  Promise.fakeConstructor$();

  /// If you call resolve in the body of the callback passed to the constructor,
  /// your promise is fulfilled with result object passed to resolve.
  /// If you call reject your promise is rejected with the object passed to reject.
  /// For consistency and debugging (eg stack traces), obj should be an instanceof Error.
  /// Any errors thrown in the constructor callback will be implicitly passed to reject().
  external factory Promise(
      void Function(void Function([Thenable<T>? value]) resolve,
              void Function([dynamic error]) reject)
          callback);

  /// onFulfilled is called when/if 'promise' resolves. onRejected is called when/if 'promise' rejects.
  /// Both are optional, if either/both are omitted the next onFulfilled/onRejected in the chain is called.
  /// Both callbacks have a single parameter , the fulfillment value or rejection reason.
  /// 'then' returns a new promise equivalent to the value you return from onFulfilled/onRejected after being passed through Promise.resolve.
  /// If an error is thrown in the callback, the returned promise rejects with that error.
  /*external Promise<U> then<U>([U|Thenable<U> onFulfilled(T value), U|Thenable<U> onRejected(dynamic error)]);*/
  /*external Promise<U> then<U>([U|Thenable<U> onFulfilled(T value), void onRejected(dynamic error)]);*/
  @override
  external Promise<U> then<U>(
      [Thenable<U> Function(T value)? onFulfilled,
      Function? /* Func1<dynamic, U|Thenable<U>>|VoidFunc1<dynamic> */ onRejected]);

  /// Sugar for promise.then(undefined, onRejected)
  // ignore: non_constant_identifier_names
  external Promise<U> JS$catch<U>(
      [Thenable<U> Function(dynamic error)? onRejected]);
}

// Module Promise
/// Make a new promise from the thenable.
/// A thenable is promise-like in as far as it has a 'then' method.
@JS('Promise.resolve')
external Promise<T> resolve<T>([dynamic /* T|Thenable<T> */ value]);

/// Make a promise that rejects to obj. For consistency and debugging (eg stack traces), obj should be an instanceof Error
@JS('Promise.reject')
external Promise<T> reject<T>(T error);

/// Make a promise that fulfills when every item in the array fulfills, and rejects if (and when) any item rejects.
/// the array passed to all can be a mixture of promise-like objects and other objects.
/// The fulfillment value is an array (in order) of fulfillment values. The rejection value is the first rejection value.
@JS('Promise.all')
external Promise<List<T>> all<T>(List<Thenable<T>> values);

/// Make a Promise that fulfills when any item fulfills, and rejects if any item rejects.
@JS('Promise.race')
external Promise<T> race<T>(List<Thenable<T>> promises);
// End module Promise

// Module es6-promise
@JS('es6-promise.foo')
external dynamic get foo;
@JS('es6-promise.foo')
external set foo(dynamic v);
// Module rsvp
@JS('es6-promise.rsvp.Promise')
// ignore: non_constant_identifier_names
external dynamic get rsvp_Promise;
@JS('es6-promise.rsvp.Promise')
// ignore: non_constant_identifier_names
external set rsvp_Promise(dynamic v);
@JS('es6-promise.rsvp.polyfill')
external void polyfill();
// End module rsvp
/* WARNING: export assignment not yet supported. */

// End module es6-promise
