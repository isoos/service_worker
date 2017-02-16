library service_worker;

import 'src/service_worker_api.dart';
export 'src/service_worker_api.dart' hide ServiceWorkerContainer;

/// API entry point for ServiceWorkers.
final ServiceWorkerGlobalScope globalScope = ServiceWorkerGlobalScope.self;
