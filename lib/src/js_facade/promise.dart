@JS()
library promise_js_facade;

import 'package:func/func.dart';
import 'package:js/js.dart';

@JS('Promise')
class Promise<T> extends Thenable<T> {
  external Promise(VoidFunc2<VoidFunc1, VoidFunc1> resolver);
  external static Promise<List> all(List<Promise> values);
  external static Promise reject(dynamic error);
  external static Promise resolve(dynamic value);
}

@JS('Thenable')
abstract class Thenable<T> {
  // ignore: non_constant_identifier_names
  external Thenable JS$catch([VoidFunc1 reject]);
  external Thenable then([VoidFunc1 resolve, VoidFunc1 reject]);
}
