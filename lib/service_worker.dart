/// Deprecated, import worker.dart instead.
/// ignore: annotation_with_non_class
@Deprecated('import work.dart instead')
library service_worker;

import 'src/service_worker_api.dart';

export 'src/service_worker_api.dart' hide ServiceWorkerContainer;

/// API entry point for ServiceWorkers.
/// Deprecated, import worker.dart instead.
@Deprecated('import work.dart instead')
final ServiceWorkerGlobalScope globalScope = ServiceWorkerGlobalScope.self;
