library sw;

import 'dart:async';

import 'package:service_worker/worker.dart';

void _log(Object o) => print('WORKER: $o');

// Reminder: ServiceWorker mustn't use async in the [main] method.
void main(List<String> args) {
  var id = 0;

  _log('SW started.');

  onInstall.listen((InstallEvent event) {
    _log('Installing.');
    event.waitUntil(_initCache());
  });

  onActivate.listen((ExtendableEvent event) {
    _log('Activating.');
  });

  onFetch.listen((FetchEvent event) {
    _log('Fetch request for $id: ${event.request.url}');
    event.respondWith(_getCachedOrFetch(id, event.request));
    id++;
  });

  onMessage.listen((ExtendableMessageEvent event) {
    _log('Message received: `${event.data}`');
    event.source.postMessage('reply from SW');
    _log('Sent reply');
  });

  onPush.listen((PushEvent event) {
    _log('onPush received: `${event.data.text()}`');
    registration.showNotification('Notification: ${event.data}');
  });
}

Future<Response> _getCachedOrFetch(int id, Request request) async {
  var r = await caches.match(request);
  if (r != null) {
    _log('  $id: Found in cache');
    return r;
  } else {
    _log('  $id: No cached version. Fetching: ${request.url}');
    r = await fetch(request);
    _log('  $id: Got for ${request.url}: ${r.statusText}');
  }
  return r;
}

Future _initCache() async {
  _log('Init cache...');
  Cache cache = await caches.open('offline-v1');
  await cache.addAll([
    '/',
    '/main.dart',
    '/main.dart.js',
    '/styles.css',
    '/packages/browser/dart.js',
  ]);
  _log('Cache initialized.');
}
