library service_worker.window;

import 'src/service_worker_api.dart';

export 'src/service_worker_api.dart'
    show
        ExtendableEvent,
        NotificationEvent,
        PushManager,
        PushSubscription,
        PushSubscriptionOptions,
        ServiceWorkerContainer,
        ServiceWorkerRegisterOptions,
        ServiceWorkerRegistration,
        ServiceWorker,
        ShowNotificationOptions;

/// API entry point for web apps (window.navigator.serviceWorker).
final ServiceWorkerContainer serviceWorker =
    ServiceWorkerContainer.navigatorContainer;
