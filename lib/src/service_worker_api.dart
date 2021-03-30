import 'dart:async';
import 'dart:convert' show json;
import 'dart:html'
    show
        Blob,
        Element,
        ErrorEvent,
        Event,
        Events,
        EventListener,
        EventTarget,
        FormData,
        MessageEvent,
        MessagePort,
        Worker;
import 'dart:indexed_db';
import 'dart:typed_data' show ByteBuffer;

import 'package:js/js.dart';
import 'package:js/js_util.dart' as js_util;

import 'js_adapter.dart';
import 'js_facade/service_worker_api.dart' as facade;

import 'js_facade/service_worker_api.dart'
    show
        CacheOptions,
        Notification,
        PushSubscriptionOptions,
        RequestInit,
        ServiceWorkerClientsMatchOptions,
        ServiceWorkerRegisterOptions,
        ShowNotificationOptions;

export 'dart:html' show ErrorEvent, Event, MessageEvent;

export 'js_facade/service_worker_api.dart'
    show
        CacheOptions,
        Notification,
        PushSubscriptionOptions,
        RequestInit,
        ServiceWorkerClientsMatchOptions,
        ServiceWorkerRegisterOptions,
        ShowNotificationAction,
        ShowNotificationOptions;

/// A ServiceWorkerGlobalScope object represents the global execution context of
/// a service worker.
class ServiceWorkerGlobalScope {
  /// API entry point for ServiceWorkers.
  static final ServiceWorkerGlobalScope globalScope =
      new ServiceWorkerGlobalScope._(facade.globalScopeSelf);

  /// As ServiceWorkerGlobalScope has an instance-level self defined, this
  /// static value will be removed in the next release.
  @deprecated
  static final ServiceWorkerGlobalScope self = globalScope;

  // Masked type: facade.ServiceWorkerGlobalScope
  final Object _delegate;
  CacheStorage? _caches;
  ServiceWorkerClients? _clients;
  ServiceWorkerRegistration? _registration;
  Stream<ExtendableEvent>? _onActivate;
  Stream<FetchEvent>? _onFetch;
  Stream<InstallEvent>? _onInstall;
  Stream<ExtendableMessageEvent>? _onMessage;
  Stream<NotificationEvent>? _onNotificationClick;
  Stream<PushEvent>? _onPush;
  Stream<PushEvent>? _onPushSubscriptionChange;
  WorkerLocation? _location;

  ServiceWorkerGlobalScope._(this._delegate);

  /// Contains the CacheStorage object associated with the service worker.
  CacheStorage get caches =>
      _caches ??= new CacheStorage._(_getProperty(_delegate, 'caches'));

  /// Contains the Clients object associated with the service worker.
  ServiceWorkerClients get clients => _clients ??=
      new ServiceWorkerClients._(_getProperty(_delegate, 'clients'));

  /// Contains the ServiceWorkerRegistration object that represents the
  /// service worker's registration.
  ServiceWorkerRegistration get registration =>
      _registration ??
      new ServiceWorkerRegistration._(_getProperty(_delegate, 'registration'));

  /// An event handler fired whenever an activate event occurs — when a
  /// ServiceWorkerRegistration acquires a new ServiceWorkerRegistration.active
  /// worker.
  Stream<ExtendableEvent> get onActivate => _onActivate ??= callbackToStream(
      _delegate, 'onactivate', (Object j) => new ExtendableEvent._(j));

  /// An event handler fired whenever a fetch event occurs — when a fetch()
  /// is called.
  Stream<FetchEvent> get onFetch => _onFetch ??=
      callbackToStream(_delegate, 'onfetch', (Object j) => new FetchEvent._(j));

  /// An event handler fired whenever an install event occurs — when a
  /// ServiceWorkerRegistration acquires a new
  /// ServiceWorkerRegistration.installing worker.
  Stream<InstallEvent> get onInstall => _onInstall ??= callbackToStream(
      _delegate, 'oninstall', (Object j) => new InstallEvent._(j));

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
  Stream<ExtendableMessageEvent> get onMessage =>
      _onMessage ??= callbackToStream(_delegate, 'onmessage',
          (Object j) => new ExtendableMessageEvent._(j));

  /// An event handler fired whenever a notificationclick event occurs — when
  /// a user clicks on a displayed notification.
  Stream<NotificationEvent> get onNotificationClick =>
      _onNotificationClick ??= callbackToStream(_delegate,
          'onnotificationclick', (Object j) => new NotificationEvent._(j));

  /// An event handler fired whenever a push event occurs — when a server
  /// push notification is received.
  Stream<PushEvent> get onPush =>
      _onPush ??= callbackToStream<Object, PushEvent>(
          _delegate, 'onpush', (Object j) => new PushEvent._(j));

  /// An event handler fired whenever a pushsubscriptionchange event occurs —
  /// when a push subscription has been invalidated, or is about to be
  /// invalidated (e.g. when a push service sets an expiration time).
  Stream<PushEvent> get onPushSubscriptionChange =>
      _onPushSubscriptionChange ??= callbackToStream(_delegate,
          'onpushsubscriptionchange', (Object j) => new PushEvent._(j));

  /// Allows the current service worker registration to progress from waiting
  /// to active state while service worker clients are using it.
  Future<void> skipWaiting() =>
      promiseToFuture(_callMethod(_delegate, 'skipWaiting', []));

  /// Attach an event listener.
  void addEventListener<K>(String type, listener(K event),
          [bool? useCapture]) =>
      _callMethod(_delegate, 'addEventListener',
          [type, allowInterop(listener), useCapture]);

  /// Fetches the [request] and returns the [Response]
  Future<Response> fetch(dynamic /*Request|String*/ request,
      [RequestInit? requestInit]) {
    List args = [_wrapRequest(request)];
    if (requestInit != null) {
      args.add(requestInit);
    }
    return promiseToFuture<Object, Response>(
        _callMethod(_delegate, 'fetch', args), (Object j) => new Response._(j));
  }

  /// Returns the indexedDB in the current scope.
  IdbFactory? get indexedDB => _getProperty(_delegate, 'indexedDB');

  // Returns the location object of the worker.
  WorkerLocation get location =>
      _location ??= new WorkerLocation(_getProperty(_delegate, 'location'));
}

/// Provides an object representing the service worker as an overall unit in the
/// network ecosystem, including facilities to register, unregister and update
/// service workers, and access the state of service workers
/// and their registrations.
class ServiceWorkerContainer {
  /// API entry point for web apps (window.navigator.serviceWorker).
  static final ServiceWorkerContainer? navigatorContainer =
      (facade.navigatorContainer != null)
          ? ServiceWorkerContainer._(facade.navigatorContainer!)
          : null;

  Stream<Event>? _onControllerChange;
  Stream<ErrorEvent>? _onError;
  Stream<MessageEvent>? _onMessage;
  // Masked type: facade.ServiceWorkerContainer
  final Object _delegate;

  ServiceWorkerContainer._(this._delegate);

  /// Returns a ServiceWorker object if its state is activated (the same object
  /// returned by ServiceWorkerRegistration.active). This property returns null
  /// if the request is a force refresh (Shift + refresh) or if there is no
  /// active worker.
  ServiceWorker? get controller =>
      ServiceWorker._fromDelegate(_getProperty(_delegate, 'controller'));

  /// Defines whether a service worker is ready to control a page or not.
  /// It returns a Promise that will never reject, which resolves to a
  /// ServiceWorkerRegistration with an ServiceWorkerRegistration.active worker.
  Future<ServiceWorkerRegistration> get ready =>
      promiseToFuture<Object, ServiceWorkerRegistration>(
          _getProperty(_delegate, 'ready'),
          (Object j) => new ServiceWorkerRegistration._(j));

  /// An event handler fired whenever a controllerchange event occurs — when
  /// the document's associated ServiceWorkerRegistration acquires a new
  /// ServiceWorkerRegistration.active worker.
  Stream<Event> get onControllerChange =>
      _onControllerChange ??= callbackToStream(
          _delegate, 'oncontrollerchange', (Object j) => j as Event);

  /// An event handler fired whenever an error event occurs in the associated
  /// service workers.
  Stream<ErrorEvent> get onError => _onError ??=
      callbackToStream(_delegate, 'onerror', (Object j) => j as ErrorEvent);

  /// An event handler fired whenever a message event occurs — when incoming
  /// messages are received to the ServiceWorkerContainer object (e.g. via a
  /// MessagePort.postMessage() call.)
  Stream<MessageEvent> get onMessage => _onMessage ??=
      callbackToStream(_delegate, 'onmessage', (Object j) => j as MessageEvent);

  /// Creates or updates a ServiceWorkerRegistration for the given scriptURL.
  /// Currently available options are: scope: A USVString representing a URL
  /// that defines a service worker's registration scope; what range of URLs a
  /// service worker can control. This is usually a relative URL, and it
  /// defaults to '/' when not specified.
  Future<ServiceWorkerRegistration> register(String scriptURL,
          [ServiceWorkerRegisterOptions? options]) =>
      promiseToFuture<Object, ServiceWorkerRegistration>(
          _callMethod(_delegate, 'register', [scriptURL, options]),
          (Object j) => new ServiceWorkerRegistration._(j));

  /// Gets a ServiceWorkerRegistration object whose scope URL matches the
  /// provided document URL.  If the method can't return a
  /// ServiceWorkerRegistration, it returns a Promise.
  /// scope URL of the registration object you want to return. This is usually
  /// a relative URL.
  Future<ServiceWorkerRegistration> getRegistration([String? scope]) =>
      promiseToFuture<Object, ServiceWorkerRegistration>(
          _callMethod(_delegate, 'getRegistration', [scope]),
          (Object j) => new ServiceWorkerRegistration._(j));

  /// Returns all ServiceWorkerRegistrations associated with a
  /// ServiceWorkerContainer in an array.  If the method can't return
  /// ServiceWorkerRegistrations, it returns a Promise.
  Future<List<ServiceWorkerRegistration>> getRegistrations() =>
      promiseToFuture<List, List<ServiceWorkerRegistration>>(
          _callMethod(_delegate, 'getRegistrations', []),
          (List list) => list
              .map<ServiceWorkerRegistration>(
                  (j) => new ServiceWorkerRegistration._(j as Object))
              .toList());

  /// Attach an event listener.
  void addEventListener<K>(String type, listener(K event), [bool? useCapture]) {
    _callMethod(_delegate, 'addEventListener',
        [type, allowInterop(listener), useCapture]);
  }
}

/// Represents the storage for Cache objects. It provides a master directory of
/// all the named caches that a ServiceWorker can access and maintains a mapping
/// of string names to corresponding Cache objects.
class CacheStorage {
  // Masked type: facade.CacheStorage
  final Object _delegate;
  CacheStorage._(this._delegate);

  /// Checks if a given Request is a key in any of the Cache objects that the
  /// CacheStorage object tracks and returns a Promise that resolves
  /// to that match.
  Future<Response?> match(dynamic /*Request|String*/ request,
          [CacheOptions? options]) =>
      promiseToFuture<Object, Response?>(
          _callMethod(_delegate, 'match', [_wrapRequest(request), options]),
          (Object? j) => (j == null) ? null : new Response._(j));

  /// Returns a Promise that resolves to true if a Cache object matching
  /// the cacheName exists.
  /// CacheStorage.
  Future<bool> has(String cacheName) =>
      promiseToFuture(_callMethod(_delegate, 'has', [cacheName]));

  /// Returns a Promise that resolves to the Cache object matching
  /// the cacheName.
  Future<Cache> open(String cacheName) => promiseToFuture<Object, Cache>(
      _callMethod(_delegate, 'open', [cacheName]),
      (Object j) => new Cache._(j));

  /// Finds the Cache object matching the cacheName, and if found, deletes the
  /// Cache object and returns a Promise that resolves to true. If no
  /// Cache object is found, it returns false.
  Future<bool> delete(String cacheName) =>
      promiseToFuture(_callMethod(_delegate, 'delete', [cacheName]));

  /// Returns a Promise that will resolve with an array containing strings
  /// corresponding to all of the named Cache objects tracked by the
  /// CacheStorage. Use this method to iterate over a list of all the
  /// Cache objects.
  Future<List<String>> keys() => promiseToFuture<List, List<String>>(
      _callMethod(_delegate, 'keys', []),
      (List list) => new List<String>.from(list));
}

/// Represents the storage for Request / Response object pairs that are cached as
/// part of the ServiceWorker life cycle.
class Cache {
  // Masked type: facade.Cache
  final Object _delegate;
  Cache._(this._delegate);

  /// Returns a Promise that resolves to the response associated with the first
  /// matching request in the Cache object.
  Future<Response> match(dynamic /*Request|String*/ request,
          [CacheOptions? options]) =>
      promiseToFuture<Object, Response>(
          _callMethod(_delegate, 'match', [_wrapRequest(request), options]),
          (Object j) => new Response._(j));

  /// Returns a Promise that resolves to an array of all matching responses in
  /// the Cache object.
  Future<List<Response>> matchAll(dynamic /*Request|String*/ request,
          [CacheOptions? options]) =>
      promiseToFuture<List, List<Response>>(
          _callMethod(_delegate, 'matchAll', [_wrapRequest(request), options]),
          (List list) => list
              .map<Response>((item) => Response._(item as Object))
              .toList());

  /// Returns a Promise that resolves to a new Cache entry whose key
  /// is the request.
  Future<Null> add(dynamic /*Request|String*/ request) =>
      promiseToFuture(_callMethod(_delegate, 'add', [_wrapRequest(request)]));

  /// Returns a Promise that resolves to a new array of Cache entries whose
  /// keys are the requests.
  Future<Null> addAll(List<dynamic /*Request|String*/ > requests) =>
      promiseToFuture(_callMethod(
          _delegate, 'addAll', [requests.map(_wrapRequest).toList()]));

  /// Adds additional key/value pairs to the current Cache object.
  Future<Null> put(dynamic /*Request|String*/ request, Response response) {
    dynamic unwrapped = request is Request ? request._delegate : request;
    return promiseToFuture(
        _callMethod(_delegate, 'put', [unwrapped, response._delegate]));
  }

  /// Finds the Cache entry whose key is the request, and if found, deletes the
  /// Cache entry and returns a Promise that resolves to true. If no Cache
  /// entry is found, it returns false.
  Future<bool> delete(dynamic /*Request|String*/ request,
          [CacheOptions? options]) =>
      promiseToFuture(
          _callMethod(_delegate, 'delete', [_wrapRequest(request), options]));

  /// Returns a Promise that resolves to an array of Cache keys.
  Future<List<Request>> keys([Request? request, CacheOptions? options]) {
    List params = [];
    if (request != null) {
      params.add(_wrapRequest(request));
      if (options != null) {
        params.add(options);
      }
    }
    return promiseToFuture<List, List<Request>>(
        _callMethod(_delegate, 'keys', params),
        (List list) =>
            list.map<Request>((item) => Request._(item as Object)).toList());
  }
}

/// Represents a container for a list of Client objects; the main way to access
/// the active service worker clients at the current origin.
class ServiceWorkerClients {
  // Masked type: facade.ServiceWorkerClients
  final Object _delegate;
  ServiceWorkerClients._(this._delegate);

  /// Gets a service worker client matching a given id and returns it in a Promise.
  Future<ServiceWorkerClient> operator [](String clientId) =>
      promiseToFuture<Object, ServiceWorkerClient>(
          _callMethod(_delegate, 'get', [clientId]),
          (Object j) => new ServiceWorkerClient._(j));

  /// Gets a list of service worker clients and returns them in a Promise.
  /// Include the options parameter to return all service worker clients whose
  /// origin is the same as the associated service worker's origin. If options
  /// are not included, the method returns only the service worker clients
  /// controlled by the service worker.
  Future<List<ServiceWorkerClient>> matchAll(
          [ServiceWorkerClientsMatchOptions? options]) =>
      promiseToFuture<List, List<ServiceWorkerClient>>(
          _callMethod(_delegate, 'matchAll', [options]),
          (List list) => list
              .map<ServiceWorkerClient>(
                  (j) => ServiceWorkerClient._(j as Object))
              .toList());

  /// Opens a service worker Client in a new browser window.
  /// in the window.
  Future<WindowClient> openWindow(String url) =>
      promiseToFuture<Object, WindowClient>(
          _callMethod(_delegate, 'openWindow', [url]),
          (Object j) => new WindowClient._(j));

  /// Allows an active Service Worker to set itself as the active worker for a
  /// client page when the worker and the page are in the same scope.
  Future<Null> claim() => promiseToFuture(_callMethod(_delegate, 'claim', []));
}

/// Represents the scope of a service worker client. A service worker client is
/// either a document in a browser context or a SharedWorker, which is controlled
/// by an active worker.
class ServiceWorkerClient {
  // Masked type: facade.ServiceWorkerClient
  final Object _delegate;
  ServiceWorkerClient._(this._delegate);

  /// Allows a service worker client to send a message to a ServiceWorker.
  /// to a port.
  void postMessage(dynamic message, [List<dynamic>? transfer]) {
    List args = [message];
    if (transfer != null) args.add(transfer);
    _callMethod(_delegate, 'postMessage', args);
  }

  /// Indicates the type of browsing context of the current client.
  /// This value can be one of auxiliary, top-level, nested, or none.
  String? get frameType => _getProperty(_delegate, 'frameType');

  /// Returns the id of the Client object.
  String? get id => _getProperty(_delegate, 'id');

  /// The URL of the current service worker client.
  String? get url => _getProperty(_delegate, 'url');
}

class WindowClient extends ServiceWorkerClient {
  // Masked type: facade.WindowClient
  WindowClient._(Object delegate) : super._(delegate);

  /// Gives user input focus to the current client.
  Future<Null> focus() => promiseToFuture(_callMethod(_delegate, 'focus', []));

  /// A boolean that indicates whether the current client has focus.
  bool? get focused => _getProperty(_delegate, 'focused');

  /// Indicates the visibility of the current client. This value can be one of
  /// hidden, visible, prerender, or unloaded.
  String? get visibilityState => _getProperty(_delegate, 'visibilityState');
}

/// Represents a service worker registration.
class ServiceWorkerRegistration implements EventTarget {
  // Masked type: facade.ServiceWorkerRegistration
  final Object _delegate;
  PushManager? _pushManager;
  Stream? _onUpdateFound;
  ServiceWorkerRegistration._(this._delegate);

  /// The raw JS object reference.
  ///
  /// Exposed for simpler third-party integration that takes the JS object
  /// reference of the registration and handles the rest (e.g. firebase-dart).
  dynamic get jsObject => _delegate;

  /// Returns a unique identifier for a service worker registration.
  /// This must be on the same origin as the document that registers
  /// the ServiceWorker.
  dynamic get scope => _getProperty(_delegate, 'scope');

  /// Returns a service worker whose state is installing. This is initially
  /// set to null.
  ServiceWorker? get installing =>
      ServiceWorker._fromDelegate(_getProperty(_delegate, 'installing'));

  /// Returns a service worker whose state is installed. This is initially
  /// set to null.
  ServiceWorker? get waiting =>
      ServiceWorker._fromDelegate(_getProperty(_delegate, 'waiting'));

  /// Returns a service worker whose state is either activating or activated.
  /// This is initially set to null. An active worker will control a
  /// ServiceWorkerClient if the client's URL falls within the scope of the
  /// registration (the scope option set when ServiceWorkerContainer.register
  /// is first called).
  ServiceWorker? get active =>
      ServiceWorker._fromDelegate(_getProperty(_delegate, 'active'));

  /// Returns an interface to for managing push subscriptions, including
  /// subscribing, getting an active subscription, and accessing push
  /// permission status.
  PushManager get pushManager => _pushManager ??=
      new PushManager._(_getProperty(_delegate, 'pushManager'));

  /// An EventListener property called whenever an event of type updatefound
  /// is fired; it is fired any time the ServiceWorkerRegistration.installing
  /// property acquires a new service worker.
  Stream get onUpdateFound => _onUpdateFound ??=
      callbackToStream(_delegate, 'onupdatefound', (Object j) => null);

  /// Allows you to update a service worker.
  void update() => _callMethod(_delegate, 'update', []);

  /// Unregisters the service worker registration and returns a promise
  /// (see Promise). The service worker will finish any ongoing operations
  /// before it is unregistered.
  Future<bool> unregister() =>
      promiseToFuture(_callMethod(_delegate, 'unregister', []));

  @override
  void addEventListener(String type, EventListener? listener,
      [bool? useCapture]) {
    _callMethod(_delegate, 'addEventListener',
        [type, allowInterop(listener as Function), useCapture]);
  }

  @override
  bool dispatchEvent(Event event) =>
      _callMethod(_delegate, 'dispatchEvent', [event]);

  @override
  Events get on => _getProperty(_delegate, 'on');

  @override
  void removeEventListener(String type, EventListener? listener,
          [bool? useCapture]) =>
      throw new UnimplementedError();

  /// Creates a notification on an active service worker.
  Future<NotificationEvent> showNotification(String title,
      [ShowNotificationOptions? options]) {
    List args = [title];
    if (options != null) args.add(options);
    return promiseToFuture<Object, NotificationEvent>(
        _callMethod(_delegate, 'showNotification', args),
        (Object j) => new NotificationEvent._(j));
  }
}

/// The PushManager interface provides a way to receive notifications from
/// third-party servers as well as request URLs for push notifications.
/// This interface has replaced functionality offered by the obsolete
/// PushRegistrationManager.
class PushManager {
  // Masked type: facade.PushManager
  final Object _delegate;
  PushManager._(this._delegate);

  /// Returns a promise that resolves to a PushSubscription with details of a
  /// new push subscription.
  Future<PushSubscription> subscribe([PushSubscriptionOptions? options]) =>
      promiseToFuture<Object, PushSubscription>(
          _callMethod(_delegate, 'subscribe', [options]),
          (Object j) => new PushSubscription._(j));

  /// Returns a promise that resolves to a PushSubscription details of
  /// the retrieved push subscription.
  Future<PushSubscription> getSubscription() =>
      promiseToFuture<Object, PushSubscription>(
          _callMethod(_delegate, 'getSubscription', []),
          (Object j) => new PushSubscription._(j));

  /// Returns a promise that resolves to the PushPermissionStatus of the
  /// requesting webapp, which will be one of granted, denied, or default.
  @Deprecated('User permissionState() instead.')
  Future<String> hasPermission() =>
      promiseToFuture(_callMethod(_delegate, 'hasPermission', []));

  /// Returns a promise that resolves to the PushPermissionStatus of the
  /// requesting webapp, which will be one of granted, denied, or prompt.
  Future<String> permissionState([PushSubscriptionOptions? options]) =>
      promiseToFuture(_callMethod(_delegate, 'permissionState', [options]));
}

/// The PushSubscription interface provides a subcription's URL endpoint and
/// subscription ID.
class PushSubscription {
  // Masked type: facade.PushSubscription
  final Object _delegate;
  PushSubscription._(this._delegate);

  /// The endpoint associated with the push subscription.
  dynamic get endpoint => _getProperty(_delegate, 'endpoint');

  /// Returns a ByteBuffer representing a client public key, which can then be
  /// sent to a server and used in encrypting push message data.
  ///
  /// See [PushSubscriptionKeys] for key names.
  ByteBuffer? getKey(String name) => _callMethod(_delegate, 'getKey', [name]);

  /// Similar to [getKey], it returns the client public keys, encoded as String.
  ///
  /// Returns an empty map if no keys are present.
  Map<String, String> getKeysAsString() {
    var map =
        json.decode(facade.jsonStringify(_delegate)) as Map<String, dynamic>;
    var keys = map['keys'];
    if (keys is Map) {
      return keys.cast<String, String>();
    }
    return {};
  }

  /// Resolves to a Boolean when the current subscription is successfully
  /// unsubscribed.
  Future<bool> unsubscribe() =>
      promiseToFuture(_callMethod(_delegate, 'unsubscribe', []));
}

/// Key values that may be stored in a PushSubscription.
abstract class PushSubscriptionKeys {
  static const String auth = 'auth';
  static const String p256dh = 'p256dh';
}

/// Extends the lifetime of the install and activate events dispatched on the
/// ServiceWorkerGlobalScope as part of the service worker lifecycle. This
/// ensures that any functional events (like FetchEvent) are not dispatched to
/// the ServiceWorker until it upgrades database schemas, deletes outdated cache
/// entries, etc.
class ExtendableEvent implements Event {
  // Masked type: facade.ExtendableEvent
  final Object _delegate;
  ExtendableEvent._(this._delegate);

  /// Extends the lifetime of the event.
  /// It is intended to be called in the install EventHandler for the
  /// installing worker and on the active EventHandler for the active worker.
  void waitUntil(Future<dynamic> future) {
    _callMethod(_delegate, 'waitUntil', [futureToPromise(future)]);
  }

  @override
  EventTarget? get target => _getProperty(_delegate, 'target');

  @override
  double? get timeStamp => _getProperty(_delegate, 'timeStamp');

  @override
  String get type => _getProperty(_delegate, 'type');

  @override
  bool? get bubbles => _getProperty(_delegate, 'bubbles');

  @override
  bool? get cancelable => _getProperty(_delegate, 'cancelable');

  @override
  EventTarget? get currentTarget => _getProperty(_delegate, 'currentTarget');

  @override
  bool get defaultPrevented => _getProperty(_delegate, 'defaultPrevented');

  @override
  int get eventPhase => _getProperty(_delegate, 'eventPhase');

  @override
  bool? get isTrusted => _getProperty(_delegate, 'isTrusted');

  @override
  Element get matchingTarget => _getProperty(_delegate, 'matchingTarget');

  @override
  List<EventTarget> get path => _getProperty(_delegate, 'path');

  @override
  void preventDefault() => _callMethod(_delegate, 'preventDefault', []);

  @override
  void stopImmediatePropagation() =>
      _callMethod(_delegate, 'stopImmediatePropagation', []);

  @override
  void stopPropagation() => _callMethod(_delegate, 'stopPropagation', []);

  @override
  bool? get composed => _getProperty(_delegate, 'composed');

  @override
  List<EventTarget> composedPath() =>
      (_callMethod(_delegate, 'composedPath', []) as List).cast<EventTarget>();
}

/// The parameter passed into the ServiceWorkerGlobalScope.onfetch handler,
/// FetchEvent represents a fetch action that is dispatched on the
/// ServiceWorkerGlobalScope of a ServiceWorker. It contains information about
/// the request and resulting response, and provides the FetchEvent.respondWith()
/// method, which allows us to provide an arbitrary response back to the
/// controlled page.
class FetchEvent implements Event {
  // Masked type: facade.FetchEvent
  final Object _delegate;
  Request? _request;
  ServiceWorkerClient? _client;
  FetchEvent._(this._delegate);

  /// Returns a Boolean that is true if the event was dispatched with the
  /// user's intention for the page to reload, and false otherwise. Typically,
  /// pressing the refresh button in a browser is a reload, while clicking a
  /// link and pressing the back button is not.
  bool? get isReload => _getProperty(_delegate, 'isReload');

  /// Returns the Request that triggered the event handler.
  Request get request =>
      _request ??= new Request._(_getProperty(_delegate, 'request'));

  /// Returns the Client that the current service worker is controlling.
  ServiceWorkerClient get client =>
      _client ??= new ServiceWorkerClient._(_getProperty(_delegate, 'client'));

  /// Returns the id of the client that the current service worker is controlling.
  String? get clientId => _getProperty(_delegate, 'clientId');

  void respondWith(Future<Response> response) {
    _callMethod(_delegate, 'respondWith',
        [futureToPromise(response, (Response r) => r._delegate)]);
  }

  @override
  EventTarget? get target => _getProperty(_delegate, 'target');

  @override
  double? get timeStamp => _getProperty(_delegate, 'timeStamp');

  @override
  String get type => _getProperty(_delegate, 'type');

  @override
  bool? get bubbles => _getProperty(_delegate, 'bubbles');

  @override
  bool? get cancelable => _getProperty(_delegate, 'cancelable');

  @override
  EventTarget? get currentTarget => _getProperty(_delegate, 'currentTarget');

  @override
  bool get defaultPrevented => _getProperty(_delegate, 'defaultPrevented');

  @override
  int get eventPhase => _getProperty(_delegate, 'eventPhase');

  @override
  bool? get isTrusted => _getProperty(_delegate, 'isTrusted');

  @override
  Element get matchingTarget => _getProperty(_delegate, 'matchingTarget');

  @override
  List<EventTarget> get path => _getProperty(_delegate, 'path');

  @override
  void preventDefault() => _callMethod(_delegate, 'preventDefault', []);

  @override
  void stopImmediatePropagation() =>
      _callMethod(_delegate, 'stopImmediatePropagation', []);

  @override
  void stopPropagation() => _callMethod(_delegate, 'stopPropagation', []);

  @override
  bool? get composed => _getProperty(_delegate, 'composed');

  @override
  List<EventTarget> composedPath() =>
      (_callMethod(_delegate, 'composedPath', []) as List).cast<EventTarget>();
}

/// The parameter passed into the oninstall handler, the InstallEvent interface
/// represents an install action that is dispatched on the
/// ServiceWorkerGlobalScope of a ServiceWorker. As a child of ExtendableEvent,
/// it ensures that functional events such as FetchEvent are not dispatched
/// during installation.
class InstallEvent extends ExtendableEvent {
  ServiceWorker? _activeWorker;
  // Masked type: facade.InstallEvent
  InstallEvent._(Object delegate) : super._(delegate);

  /// Returns the ServiceWorker that is currently actively controlling the page.
  ServiceWorker? get activeWorker => _activeWorker ??=
      ServiceWorker._fromDelegate(_getProperty(_delegate, 'activeWorker'));
}

/// Represents a service worker. Multiple browsing contexts (e.g. pages, workers,
/// etc.) can be associated with the same ServiceWorker object.
class ServiceWorker implements Worker {
  // Masked type: facade.ServiceWorker
  final Object _delegate;
  Stream<Event>? _onStateChange;
  Stream<ErrorEvent>? _onError;
  Stream<MessageEvent>? _onMessage;
  ServiceWorker._(this._delegate);

  static ServiceWorker? _fromDelegate(Object? delegate) {
    if (delegate == null) return null;
    return new ServiceWorker._(delegate);
  }

  /// Returns the ServiceWorker serialized script URL defined as part of
  /// ServiceWorkerRegistration. The URL must be on the same origin as the
  /// document that registers the ServiceWorker.
  String? get scriptURL => _getProperty(_delegate, 'scriptURL');

  /// Returns the state of the service worker. It returns one of the following
  /// values: installing, installed, activating, activated, or redundant.
  String? get state => _getProperty(_delegate, 'state');

  String? get id => _getProperty(_delegate, 'id');

  /// An EventListener property called whenever an event of type statechange
  /// is fired; it is basically fired anytime the ServiceWorker.state changes.
  Stream<Event> get onStateChange => _onStateChange ??=
      callbackToStream(_delegate, 'onstatechange', (Object j) => j as Event);

  @override
  void addEventListener(String type, EventListener? listener,
      [bool? useCapture]) {
    _callMethod(_delegate, 'addEventListener',
        [type, allowInterop(listener as Function), useCapture]);
  }

  @override
  bool dispatchEvent(Event event) =>
      _callMethod(_delegate, 'dispatchEvent', [event]);

  @override
  Events get on => _getProperty(_delegate, 'on');

  /// An event handler fired whenever an error event occurs in the associated
  /// service workers.
  @override
  Stream<ErrorEvent> get onError => _onError ??=
      callbackToStream(_delegate, 'onerror', (Object j) => j as ErrorEvent);

  /// An event handler fired whenever a message event occurs — when incoming
  /// messages are received to the ServiceWorkerContainer object (e.g. via a
  /// MessagePort.postMessage() call.)
  @override
  Stream<MessageEvent> get onMessage => _onMessage ??=
      callbackToStream(_delegate, 'onmessage', (Object j) => j as MessageEvent);

  @override
  void postMessage(dynamic message, [List<dynamic>? transfer]) {
    List args = [message];
    if (transfer != null) args.add(transfer);
    _callMethod(_delegate, 'postMessage', args);
  }

  @override
  void removeEventListener(String type, EventListener? listener,
          [bool? useCapture]) =>
      throw new UnimplementedError();

  @override
  void terminate() {
    _callMethod(_delegate, 'terminate', []);
  }
}

/// The ExtendableMessageEvent interface of the ServiceWorker API represents
/// the event object of a message event fired on
/// a service worker (when a channel message is received on
/// the ServiceWorkerGlobalScope from another context)
/// — extends the lifetime of such events.
class ExtendableMessageEvent extends ExtendableEvent {
  // Masked type: facade.ExtendableMessageEvent
  ExtendableMessageEvent._(Object delegate) : super._(delegate);

  /// Returns the event's data. It can be any data type.
  dynamic get data => _getProperty(_delegate, 'data');

  String? get origin => _getProperty(_delegate, 'origin');

  /// Represents, in server-sent events, the last event ID of the event source.
  String? get lastEventId => _getProperty(_delegate, 'lastEventId');

  /// Returns a reference to the service worker that sent the message.
  ServiceWorkerClient get source =>
      new ServiceWorkerClient._(_getProperty(_delegate, 'source'));

  /// Returns the array containing the MessagePort objects
  /// representing the ports of the associated message channel.
  List<MessagePort>? get ports => _getProperty(_delegate, 'ports');
}

/// The parameter passed into the onnotificationclick handler,
/// the NotificationEvent interface represents
/// a notification click event that is dispatched on
/// the ServiceWorkerGlobalScope of a ServiceWorker.
class NotificationEvent extends ExtendableEvent {
  // Masked type: facade.NotificationEvent
  NotificationEvent._(Object delegate) : super._(delegate);

  /// Returns a Notification object representing
  /// the notification that was clicked to fire the event.
  Notification? get notification => _getProperty(_delegate, 'notification');

  /// Returns the string ID of the notification button the user clicked.
  /// This value returns undefined if the user clicked
  /// the notification somewhere other than an action button,
  /// or the notification does not have a button.
  String? get action => _getProperty(_delegate, 'action');
}

/// The PushEvent interface of the Push API represents
/// a push message that has been received.
/// This event is sent to the global scope of a ServiceWorker.
/// It contains the information sent from an application server to a PushSubscription.
class PushEvent extends ExtendableEvent {
  // Masked type: facade.PushEvent
  PushEvent._(Object delegate) : super._(delegate);

  /// Returns a reference to a PushMessageData object containing
  /// data sent to the PushSubscription.
  PushMessageData get data =>
      new PushMessageData._(_getProperty(_delegate, 'data'));
}

/// The PushMessageData interface of the Push API provides
/// methods which let you retrieve the push data sent by a server in various formats.
class PushMessageData {
  // Masked type: facade.PushMessageData
  final Object _delegate;
  PushMessageData._(this._delegate);

  /// Extracts the data as a ByteBuffer object.
  ByteBuffer? arrayBuffer() => _callMethod(_delegate, 'arrayBuffer', []);

  /// Extracts the data as a Blob object.
  Blob? blob() => _callMethod(_delegate, 'blob', []);

  /// Extracts the data as a JSON object.
  T? json<T>() => _callMethod(_delegate, 'json', []);

  /// Extracts the data as a plain text string.
  String? text() => _callMethod(_delegate, 'text', []);
}

class Body {
  // Masked type: facade.Body
  final Object _delegate;
  Body._(this._delegate);

  /// indicates whether the body has been read yet
  bool get bodyUsed => _getProperty(_delegate, 'bodyUsed');

  /// Extracts the data as a ByteBuffer object.
  Future<ByteBuffer> arrayBuffer() =>
      promiseToFuture(_callMethod(_delegate, 'arrayBuffer', []));

  /// Extracts the data as a Blob object.
  Future<Blob> blob() => promiseToFuture(_callMethod(_delegate, 'blob', []));

  Future<FormData> formData() =>
      promiseToFuture(_callMethod(_delegate, 'formData', []));

  /// Extracts the data as a JSON object.
  Future<T> json<T>() => promiseToFuture(_callMethod(_delegate, 'json', []));

  /// Extracts the data as a plain text string.
  Future<String> text() => promiseToFuture(_callMethod(_delegate, 'text', []));
}

class Request extends Body {
  Headers? _headers;

  // Masked type: facade.Request
  Request._(Object delegate) : super._(delegate);

  String? get method => _getProperty(_delegate, 'method');
  String? get url => _getProperty(_delegate, 'url');

  Headers get headers =>
      _headers ??= new Headers._(_getProperty(_delegate, 'headers'));

  /// ''|'audio'|'font'|'image'|'script'|'style'|'track'|'video'
  String? get type => _getProperty(_delegate, 'type');

  /// ''|'document'|'embed'|'font'|'image'|'manifest'|'media'|'object'|'report'|'script'|'serviceworker'|'sharedworker'|'style'|'worker'|'xslt'
  String? get destination => _getProperty(_delegate, 'destination');

  String? get referrer => _getProperty(_delegate, 'referrer');

  /// ''|'no-referrer'|'no-referrer-when-downgrade'|'same-origin'|'origin'|'strict-origin'|'origin-when-cross-origin'|'strict-origin-when-cross-origin'|'unsafe-url'
  String? get referrerPolicy => _getProperty(_delegate, 'referrerPolicy');

  /// 'navigate'|'same-origin'|'no-cors'|'cors'
  String? get mode => _getProperty(_delegate, 'mode');

  /// 'omit'|'same-origin'|'include'
  String? get credentials => _getProperty(_delegate, 'credentials');

  /// 'default'|'no-store'|'reload'|'no-cache'|'force-cache'|'only-if-cached'
  String? get cache => _getProperty(_delegate, 'cache');

  /// 'follow'|'error'|'manual'
  String? get redirect => _getProperty(_delegate, 'redirect');

  String? get integrity => _getProperty(_delegate, 'integrity');

  Request clone() => new Request._(_callMethod(_delegate, 'clone', []));

  /// Creates a new [Request] instance with the same content and headers,
  /// appending the specified values from [headers] Map.
  Future<Request> cloneWith({Map<String, String>? headers}) async {
    return new Request._(new facade.Request(
      clone()._delegate,
      new facade.RequestInit(
          headers: this.headers.clone(headers: headers)._delegate),
    ));
  }
}

class Response extends Body {
  Headers? _headers;
  // Masked type: facade.Response
  Response._(Object delegate) : super._(delegate);

  factory Response.redirect(String url, [int? status]) =>
      new Response._(facade.Response.redirect(url, status));

  factory Response.error() => new Response._(facade.Response.error());

  /// 'basic'|'cors'|'default'|'error'|'opaque'|'opaqueredirect'
  String? get type => _getProperty(_delegate, 'type');

  String? get url => _getProperty(_delegate, 'url');

  bool? get redirected => _getProperty(_delegate, 'redirected');

  int? get status => _getProperty(_delegate, 'status');

  String? get statusText => _getProperty(_delegate, 'statusText');

  bool? get ok => _getProperty(_delegate, 'ok');

  Headers get headers =>
      _headers ??= new Headers._(_getProperty(_delegate, 'headers'));

  dynamic get body => _getProperty(_delegate, 'body');

  Response clone() => new Response._(_callMethod(_delegate, 'clone', []));

  /// Creates a new [Response] instance with the same content and headers,
  /// appending the specified values from [headers] Map.
  Future<Response> cloneWith({Map<String, String>? headers}) async {
    ByteBuffer buffer = await clone().arrayBuffer();
    return new Response._(new facade.Response(
      buffer,
      new facade.ResponseInit(
          status: status,
          statusText: statusText,
          headers: this.headers.clone(headers: headers)._delegate),
    ));
  }
}

class Headers {
  // Masked type: facade.Headers
  final Object _delegate;
  Headers._(this._delegate);

  void append(String name, String value) =>
      _callMethod(_delegate, 'append', [name, value]);

  void delete(String name) => _callMethod(_delegate, 'delete', [name]);

  String? operator [](String? name) => _callMethod(_delegate, 'get', [name]);
  void operator []=(String? name, String? value) =>
      _callMethod(_delegate, 'set', [name, value]);
  List<String> getAll(String name) =>
      (_callMethod(_delegate, 'getAll', [name]) as List).cast<String>();

  bool? has(String name) => _callMethod(_delegate, 'has', [name]);

  Iterable<String?> keys() =>
      iteratorToIterable(() => _callMethod(_delegate, 'keys', []));

  /// Create a new [Headers] instance that has the same header values, and on
  /// top of that, it appends the specified values from the [headers] Map.
  Headers clone({Map<String, String>? headers}) {
    Headers h = new Headers._(new facade.Headers());
    for (String? key in keys()) {
      h[key] = this[key];
    }
    headers?.forEach(h.append);
    return h;
  }
}

class WorkerLocation {
  Object _delegate;
  WorkerLocation(this._delegate);

  String? get href => _getProperty(_delegate, 'href');
  String? get protocol => _getProperty(_delegate, 'protocol');
  String? get host => _getProperty(_delegate, 'host');
  String? get hostname => _getProperty(_delegate, 'hostname');
  String? get origin => _getProperty(_delegate, 'origin');
  String? get port => _getProperty(_delegate, 'port');
  String? get pathname => _getProperty(_delegate, 'pathname');
  String? get search => _getProperty(_delegate, 'search');
  String? get hash => _getProperty(_delegate, 'hash');

  @override
  String toString() => href!;
}

// Utility method to mask the typed JS facade as JSObject
T _callMethod<T>(Object object, String method, List args) =>
    js_util.callMethod(object, method, args) as T;

// Utility method to mask the typed JS facade as JSObject
T _getProperty<T>(Object object, String name) =>
    js_util.getProperty(object, name) as T;

dynamic _wrapRequest(dynamic /*Request|String*/ request) {
  if (request == null) return null;
  if (request is String) return request;
  return (request as Request)._delegate;
}
