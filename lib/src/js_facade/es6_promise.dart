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
  /*external Thenable<U> then<U>([U|Thenable<U> onFulfilled(T value), U|Thenable<U> onRejected(dynamic error)]);*/
  /*external Thenable<U> then<U>([U|Thenable<U> onFulfilled(T value), void onRejected(dynamic error)]);*/
  external Thenable<dynamic/*=U*/ > then/*<U>*/(
      [dynamic /*U|Thenable<U>*/ onFulfilled(T value),
      Function /*Func1<dynamic, U|Thenable<U>>|VoidFunc1<dynamic>*/ onRejected]);
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
      void callback(void resolve([dynamic /*T|Thenable<T>*/ value]),
          void reject([dynamic error])));

  /// onFulfilled is called when/if 'promise' resolves. onRejected is called when/if 'promise' rejects.
  /// Both are optional, if either/both are omitted the next onFulfilled/onRejected in the chain is called.
  /// Both callbacks have a single parameter , the fulfillment value or rejection reason.
  /// 'then' returns a new promise equivalent to the value you return from onFulfilled/onRejected after being passed through Promise.resolve.
  /// If an error is thrown in the callback, the returned promise rejects with that error.
  /*external Promise<U> then<U>([U|Thenable<U> onFulfilled(T value), U|Thenable<U> onRejected(dynamic error)]);*/
  /*external Promise<U> then<U>([U|Thenable<U> onFulfilled(T value), void onRejected(dynamic error)]);*/
  @override
  external Promise<dynamic/*=U*/ > then/*<U>*/(
      [dynamic /*U|Thenable<U>*/ onFulfilled(T value),
      Function /*Func1<dynamic, U|Thenable<U>>|VoidFunc1<dynamic>*/ onRejected]);

  /// Sugar for promise.then(undefined, onRejected)
  external Promise<dynamic/*=U*/ > JS$catch/*<U>*/(
      [dynamic /*U|Thenable<U>*/ onRejected(dynamic error)]);
}

// Module Promise
/// Make a new promise from the thenable.
/// A thenable is promise-like in as far as it has a 'then' method.
@JS('Promise.resolve')
external Promise<dynamic/*=T*/ > resolve/*<T>*/(
    [dynamic /*T|Thenable<T>*/ value]);

/// Make a promise that rejects to obj. For consistency and debugging (eg stack traces), obj should be an instanceof Error
/*external Promise<dynamic> reject(dynamic error);*/
/*external Promise<T> reject<T>(T error);*/
@JS('Promise.reject')
external Promise<dynamic> /*Promise<dynamic>|Promise<T>*/ reject/*<T>*/(
    dynamic /*dynamic|T*/ error);

/// Make a promise that fulfills when every item in the array fulfills, and rejects if (and when) any item rejects.
/// the array passed to all can be a mixture of promise-like objects and other objects.
/// The fulfillment value is an array (in order) of fulfillment values. The rejection value is the first rejection value.
/*external Promise<Tuple of <T1,T2,T3,T4,T5,T6,T7,T8,T9,T10>> all<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(Tuple of <T1|Thenable<T1>,T2|Thenable<T2>,T3|Thenable<T3>,T4|Thenable<T4>,T5|Thenable<T5>,T6|Thenable<T6>,T7|Thenable<T7>,T8|Thenable<T8>,T9|Thenable<T9>,T10|Thenable<T10>> values);*/
/*external Promise<Tuple of <T1,T2,T3,T4,T5,T6,T7,T8,T9>> all<T1, T2, T3, T4, T5, T6, T7, T8, T9>(Tuple of <T1|Thenable<T1>,T2|Thenable<T2>,T3|Thenable<T3>,T4|Thenable<T4>,T5|Thenable<T5>,T6|Thenable<T6>,T7|Thenable<T7>,T8|Thenable<T8>,T9|Thenable<T9>> values);*/
/*external Promise<Tuple of <T1,T2,T3,T4,T5,T6,T7,T8>> all<T1, T2, T3, T4, T5, T6, T7, T8>(Tuple of <T1|Thenable<T1>,T2|Thenable<T2>,T3|Thenable<T3>,T4|Thenable<T4>,T5|Thenable<T5>,T6|Thenable<T6>,T7|Thenable<T7>,T8|Thenable<T8>> values);*/
/*external Promise<Tuple of <T1,T2,T3,T4,T5,T6,T7>> all<T1, T2, T3, T4, T5, T6, T7>(Tuple of <T1|Thenable<T1>,T2|Thenable<T2>,T3|Thenable<T3>,T4|Thenable<T4>,T5|Thenable<T5>,T6|Thenable<T6>,T7|Thenable<T7>> values);*/
/*external Promise<Tuple of <T1,T2,T3,T4,T5,T6>> all<T1, T2, T3, T4, T5, T6>(Tuple of <T1|Thenable<T1>,T2|Thenable<T2>,T3|Thenable<T3>,T4|Thenable<T4>,T5|Thenable<T5>,T6|Thenable<T6>> values);*/
/*external Promise<Tuple of <T1,T2,T3,T4,T5>> all<T1, T2, T3, T4, T5>(Tuple of <T1|Thenable<T1>,T2|Thenable<T2>,T3|Thenable<T3>,T4|Thenable<T4>,T5|Thenable<T5>> values);*/
/*external Promise<Tuple of <T1,T2,T3,T4>> all<T1, T2, T3, T4>(Tuple of <T1|Thenable<T1>,T2|Thenable<T2>,T3|Thenable<T3>,T4|Thenable<T4>> values);*/
/*external Promise<Tuple of <T1,T2,T3>> all<T1, T2, T3>(Tuple of <T1|Thenable<T1>,T2|Thenable<T2>,T3|Thenable<T3>> values);*/
/*external Promise<Tuple of <T1,T2>> all<T1, T2>(Tuple of <T1|Thenable<T1>,T2|Thenable<T2>> values);*/
/*external Promise<List<T>> all<T>(List<T|Thenable<T>> values);*/
@JS('Promise.all')
external Promise<
    List<
        dynamic>> /*Promise<Tuple of <T1,T2,T3,T4,T5,T6,T7,T8,T9,T10>>|Promise<Tuple of <T1,T2,T3,T4,T5,T6,T7,T8,T9>>|Promise<Tuple of <T1,T2,T3,T4,T5,T6,T7,T8>>|Promise<Tuple of <T1,T2,T3,T4,T5,T6,T7>>|Promise<Tuple of <T1,T2,T3,T4,T5,T6>>|Promise<Tuple of <T1,T2,T3,T4,T5>>|Promise<Tuple of <T1,T2,T3,T4>>|Promise<Tuple of <T1,T2,T3>>|Promise<Tuple of <T1,T2>>|Promise<List<T>>*/ all/*<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T>*/(
    List<
        dynamic> /*Tuple of <T1|Thenable<T1>,T2|Thenable<T2>,T3|Thenable<T3>,T4|Thenable<T4>,T5|Thenable<T5>,T6|Thenable<T6>,T7|Thenable<T7>,T8|Thenable<T8>,T9|Thenable<T9>,T10|Thenable<T10>>|Tuple of <T1|Thenable<T1>,T2|Thenable<T2>,T3|Thenable<T3>,T4|Thenable<T4>,T5|Thenable<T5>,T6|Thenable<T6>,T7|Thenable<T7>,T8|Thenable<T8>,T9|Thenable<T9>>|Tuple of <T1|Thenable<T1>,T2|Thenable<T2>,T3|Thenable<T3>,T4|Thenable<T4>,T5|Thenable<T5>,T6|Thenable<T6>,T7|Thenable<T7>,T8|Thenable<T8>>|Tuple of <T1|Thenable<T1>,T2|Thenable<T2>,T3|Thenable<T3>,T4|Thenable<T4>,T5|Thenable<T5>,T6|Thenable<T6>,T7|Thenable<T7>>|Tuple of <T1|Thenable<T1>,T2|Thenable<T2>,T3|Thenable<T3>,T4|Thenable<T4>,T5|Thenable<T5>,T6|Thenable<T6>>|Tuple of <T1|Thenable<T1>,T2|Thenable<T2>,T3|Thenable<T3>,T4|Thenable<T4>,T5|Thenable<T5>>|Tuple of <T1|Thenable<T1>,T2|Thenable<T2>,T3|Thenable<T3>,T4|Thenable<T4>>|Tuple of <T1|Thenable<T1>,T2|Thenable<T2>,T3|Thenable<T3>>|Tuple of <T1|Thenable<T1>,T2|Thenable<T2>>|List<T|Thenable<T>>*/ values);

/// Make a Promise that fulfills when any item fulfills, and rejects if any item rejects.
@JS('Promise.race')
external Promise<dynamic/*=T*/ > race/*<T>*/(
    List<dynamic /*T|Thenable<T>*/ > promises);
// End module Promise

// Module es6-promise
@JS('es6-promise.foo')
external dynamic get foo;
@JS('es6-promise.foo')
external set foo(dynamic v);
// Module rsvp
@JS('es6-promise.rsvp.Promise')
external dynamic get rsvp_Promise;
@JS('es6-promise.rsvp.Promise')
external set rsvp_Promise(dynamic v);
@JS('es6-promise.rsvp.polyfill')
external void polyfill();
// End module rsvp
/* WARNING: export assignment not yet supported. */

// End module es6-promise
