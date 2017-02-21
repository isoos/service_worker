# Service Worker API for Dart

Dart-y wrappers for the ServiceWorker APIs.

Warning: the API is experimental, and subject to change.

## Service Workers

A service worker is an event-driven worker registered against an origin and a path.
It takes the form of a JavaScript file that can control the web page/site it is
associated with, intercepting and modifying navigation and resource requests, and
caching resources in a very granular fashion to give you complete control over how
your app behaves in certain situations (the most obvious one being when the network
is not available.)

A service worker is run in a worker context: it therefore has no DOM access, and
runs on a different thread to the main JavaScript that powers your app, so it is
not blocking. It is designed to be fully async; as a consequence, APIs such as
synchronous XHR and localStorage can't be used inside a service worker.

- W3C draft: [https://www.w3.org/TR/service-workers/](https://www.w3.org/TR/service-workers/)
- Mozilla doc: [https://developer.mozilla.org/en/docs/Web/API/Service_Worker_API](https://developer.mozilla.org/en/docs/Web/API/Service_Worker_API)

## Quickstart

Register the Service Worker from your application script, like in `example/web/main.dart`:

````dart
import 'package:service_worker/window.dart' as sw;

void main() {
  if (sw.isSupported) {
    sw.register('sw.dart.js');
  } else {
    print('ServiceWorkers are not supported.');
  }
}
````

Write the Service Worker in a separate script, like in `example/web/sw.dart`:

````dart
import 'package:service_worker/service_worker.dart';

void main(List<String> args) {
  onInstall.listen((event) {
    print('ServiceWorker installed.');
  });
}
````
