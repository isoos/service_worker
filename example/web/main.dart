import 'dart:async';
import 'dart:html';

import 'package:service_worker/window.dart' as sw;

void _log(Object o) => print('  MAIN: $o');

Future main() async {
  querySelector('#output')!.text =
      'Your Dart app is running.\nOpen your Developer console to see details.';

  if (sw.isNotSupported) {
    _log('ServiceWorkers are not supported.');
    return;
  }

  await sw.register('sw.dart.js');
  _log('registered');

  sw.ServiceWorkerRegistration registration = await sw.ready;
  _log('ready');

  sw.onMessage.listen((MessageEvent event) {
    _log('reply received: ${event.data}');
  });

  var message = 'Sample message: ${DateTime.now()}';
  _log('Sending message: `$message`');
  registration.active!.postMessage(message);
  _log('Message sent: `$message`');

  try {
    var subs = await registration.pushManager
        .subscribe(sw.PushSubscriptionOptions(userVisibleOnly: true));
    _log('endpoint: ${subs.endpoint}');
  } on DomException catch (_) {
    _log('Error: Adding push subscription failed.');
    _log('       See github.com/isoos/service_worker/issues/10');
  }
}
