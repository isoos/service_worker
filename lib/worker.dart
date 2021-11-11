/// The Worker global scope of the ServiceWorker.
library service_worker;

import 'dart:async';
import 'dart:indexed_db';

import 'src/service_worker_api.dart';

export 'src/service_worker_api.dart' hide ServiceWorkerContainer;

ServiceWorkerGlobalScope _self = ServiceWorkerGlobalScope.globalScope;

/// Contains the CacheStorage object associated with the service worker.
CacheStorage get caches => _self.caches;

/// Contains the Clients object associated with the service worker.
ServiceWorkerClients get clients => _self.clients;

/// Contains the ServiceWorkerRegistration object that represents the
/// service worker's registration.
ServiceWorkerRegistration get registration => _self.registration;

/// An event handler fired whenever an activate event occurs — when a
/// ServiceWorkerRegistration acquires a new ServiceWorkerRegistration.active
/// worker.
Stream<ExtendableEvent> get onActivate => _self.onActivate;

/// An event handler fired whenever a fetch event occurs — when a fetch()
/// is called.
Stream<FetchEvent> get onFetch => _self.onFetch;

/// An event handler fired whenever an install event occurs — when a
/// ServiceWorkerRegistration acquires a new
/// ServiceWorkerRegistration.installing worker.
Stream<InstallEvent> get onInstall => _self.onInstall;

/// An event handler fired whenever a message event occurs — when incoming
/// messages are received. Controlled pages can use the
/// MessagePort.postMessage() method to send messages to service workers.
/// The service worker can optionally send a response back via the
/// MessagePort exposed in event.data.port, corresponding to the controlled
/// page.
/// `onmessage` is actually fired with `ExtendableMessageEvent`, but
/// since we are merging the interface into `Window`, we should
/// make sure it's compatible with `window.onmessage`
/// onmessage: (messageevent: ExtendableMessageEvent) => void;
Stream<ExtendableMessageEvent> get onMessage => _self.onMessage;

/// An event handler fired whenever a notificationclick event occurs — when
/// a user clicks on a displayed notification.
Stream<NotificationEvent> get onNotificationClick => _self.onNotificationClick;

/// An event handler fired whenever a push event occurs — when a server
/// push notification is received.
Stream<PushEvent> get onPush => _self.onPush;

/// An event handler fired whenever a pushsubscriptionchange event occurs —
/// when a push subscription has been invalidated, or is about to be
/// invalidated (e.g. when a push service sets an expiration time).
Stream<PushEvent> get onPushSubscriptionChange =>
    _self.onPushSubscriptionChange;

/// Allows the current service worker registration to progress from waiting
/// to active state while service worker clients are using it.
Future<void> skipWaiting() => _self.skipWaiting();

/// Attach an event listener.
void addEventListener<K>(String type, Function(K event) listener,
        [bool? useCapture]) =>
    _self.addEventListener(type, listener, useCapture);

/// Fetches the [request] and returns the [Response]
Future<Response> fetch(dynamic /*Request|String*/ request,
        [RequestInit? requestInit]) =>
    _self.fetch(request, requestInit);

/// Returns the indexedDB in the current scope.
IdbFactory? get indexedDB => _self.indexedDB;

// Returns the location object of the worker.
WorkerLocation get location => _self.location;
