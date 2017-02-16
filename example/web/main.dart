import 'dart:async';
import 'dart:html';

import 'package:service_worker/window.dart' as sw;

Future main() async {
  querySelector('#output').text = 'Your Dart app is running.';

  if (sw.serviceWorker == null) {
    print('ServiceWorkers are not supported.');
    return;
  }

  await sw.serviceWorker.register('sw.dart.js');
  print('registered');

  sw.ServiceWorkerRegistration registration = await sw.serviceWorker.ready;
  print('ready');

  sw.serviceWorker.onMessage.listen((MessageEvent event) {
    print('reply received: ${event.data}');
  });

  sw.ServiceWorker active = registration.active;
  active.postMessage('x');
  print('sent');

  sw.PushSubscription subs = await registration.pushManager
      .subscribe(new sw.PushSubscriptionOptions(userVisibleOnly: true));
  print('endpoint: ${subs.endpoint}');
}
