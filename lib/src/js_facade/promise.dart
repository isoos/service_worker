@JS()
library promise_js_facade;

import 'package:js/js.dart';

typedef ResolveFn<T> = void Function(T value);
typedef RejectFn = void Function(dynamic error);

@JS('Promise')
class Promise<T> extends Thenable<T> {
  external Promise(
      void Function(ResolveFn<T> resolveFn, RejectFn rejectFn) callback);
  external static Promise<List> all(List<Promise> values);
  external static Promise reject(dynamic error);
  external static Promise resolve(dynamic value);
}

@JS('Thenable')
abstract class Thenable<T> {
  // ignore: non_constant_identifier_names
  external Thenable JS$catch([RejectFn? rejectFn]);
  external Thenable then([ResolveFn<T>? resolveFn, RejectFn? rejectFn]);
}
