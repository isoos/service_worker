library sw;

import 'dart:async';

import 'package:service_worker/worker.dart';

// Reminder: ServiceWorker mustn't use async in the [main] method.
void main(List<String> args) {
  print('SW started.');

  onInstall.listen((InstallEvent event) {
    print('Installing.');
    event.waitUntil(_initCache());
  });

  onActivate.listen((ExtendableEvent event) {
    print('Activating.');
  });

  onFetch.listen((FetchEvent event) {
    print('fetch request: ${event.request}');
    event.respondWith(_getCachedOrFetch(event.request));
  });

  onMessage.listen((ExtendableMessageEvent event) {
    print('onMessage received ${event.data}');
    event.source.postMessage('reply from SW');
    print('replied');
  });

  onPush.listen((PushEvent event) {
    print('onPush received: ${event.data}');
    registration.showNotification('Notification: ${event.data}');
  });
}

Future<Response> _getCachedOrFetch(Request request) async {
  Response r = await caches.match(request);
  if (r != null) {
    print('Found in cache: ${request.url} $r');
    return r;
  } else {
    print('No cached version. Fetching: ${request.url}');
    r = await fetch(request);
    print('Got for ${request.url}: $r');
  }
  return r;
}

Future _initCache() async {
  print('Init cache...');
  Cache cache = await caches.open('offline-v1');
  await cache.addAll([
    '/',
    '/main.dart',
    '/main.dart.js',
    '/styles.css',
    '/packages/browser/dart.js',
  ]);
  print('Cache initialized.');
}
