@JS()
library promise_js_facade;

import 'package:js/js.dart';

typedef void ResolveFn<T>(T value);
typedef void RejectFn(dynamic error);

@JS('Promise')
class Promise<T> extends Thenable<T> {
  external Promise(void callback(ResolveFn<T> resolveFn, RejectFn rejectFn));
  external static Promise<List> all(List<Promise> values);
  external static Promise reject(dynamic error);
  external static Promise resolve(dynamic value);
}

@JS('Thenable')
abstract class Thenable<T> {
  // ignore: non_constant_identifier_names
  external Thenable JS$catch([RejectFn rejectFn]);
  external Thenable then([ResolveFn<T> resolveFn, RejectFn rejectFn]);
}
