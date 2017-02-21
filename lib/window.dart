library service_worker.window;

import 'dart:async';

import 'src/service_worker_api.dart';
export 'src/service_worker_api.dart'
    show
        ErrorEvent,
        Event,
        ExtendableEvent,
        NotificationEvent,
        MessageEvent,
        PushManager,
        PushSubscription,
        PushSubscriptionOptions,
        ServiceWorkerContainer,
        ServiceWorkerRegisterOptions,
        ServiceWorkerRegistration,
        ServiceWorker,
        ShowNotificationOptions;

ServiceWorkerContainer _self = ServiceWorkerContainer.navigatorContainer;

/// API entry point for web apps (window.navigator.serviceWorker).
/// Deprecated, use top-level fields and methods instead.
@deprecated
ServiceWorkerContainer get serviceWorker => _self;

/// Whether ServiceWorker is supported in the current browser.
bool get isSupported => _self != null;

/// Whether ServiceWorker is not supported in the current browser.
bool get isNotSupported => !isSupported;

/// Returns a ServiceWorker object if its state is activated (the same object
/// returned by ServiceWorkerRegistration.active). This property returns null
/// if the request is a force refresh (Shift + refresh) or if there is no
/// active worker.
ServiceWorker get controller => _self.controller;

/// Defines whether a service worker is ready to control a page or not.
/// It returns a Promise that will never reject, which resolves to a
/// ServiceWorkerRegistration with an ServiceWorkerRegistration.active worker.
Future<ServiceWorkerRegistration> get ready => _self.ready;

/// An event handler fired whenever a controllerchange event occurs — when
/// the document's associated ServiceWorkerRegistration acquires a new
/// ServiceWorkerRegistration.active worker.
Stream<Event> get onControllerChange => _self.onControllerChange;

/// An event handler fired whenever an error event occurs in the associated
/// service workers.
Stream<ErrorEvent> get onError => _self.onError;

/// An event handler fired whenever a message event occurs — when incoming
/// messages are received to the ServiceWorkerContainer object (e.g. via a
/// MessagePort.postMessage() call.)
Stream<MessageEvent> get onMessage => _self.onMessage;

/// Creates or updates a ServiceWorkerRegistration for the given scriptURL.
/// Currently available options are: scope: A USVString representing a URL
/// that defines a service worker's registration scope; what range of URLs a
/// service worker can control. This is usually a relative URL, and it
/// defaults to '/' when not specified.
Future<ServiceWorkerRegistration> register(String scriptURL,
        [ServiceWorkerRegisterOptions options]) =>
    _self.register(scriptURL, options);

/// Gets a ServiceWorkerRegistration object whose scope URL matches the
/// provided document URL.  If the method can't return a
/// ServiceWorkerRegistration, it returns a Promise.
/// scope URL of the registration object you want to return. This is usually
/// a relative URL.
Future<ServiceWorkerRegistration> getRegistration([String scope]) =>
    _self.getRegistration(scope);

/// Returns all ServiceWorkerRegistrations associated with a
/// ServiceWorkerContainer in an array.  If the method can't return
/// ServiceWorkerRegistrations, it returns a Promise.
Future<List<ServiceWorkerRegistration>> getRegistrations() =>
    _self.getRegistrations();

/// Attach an event listener.
void addEventListener<K>(String type, listener(K event), [bool useCapture]) =>
    _self.addEventListener(type, listener, useCapture);
