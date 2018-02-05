# Changelog

## 0.1.2-dev

- Style cleanup: preferring single quotes.
- Removed generic type comments.

## 0.1.1

- Remove `package:func` dependency.

## 0.1.0

- Upgraded dependencies.

## 0.0.16

- Remove 'implements' from JS facade methods, as it seems to break with dart2js.

## 0.0.15

- Implement new methods for classes that implement `Event`.

## 0.0.14

- Don't return `ServiceWorker` instances when the underlying JS object is null.
- Mask types from JS facade, to prevent type check errors in Dartium.

## 0.0.13

- expose `Notification.close()`
- expose `ServiceWorkerClientsMatchOptions`

## 0.0.12

- expose keys in `PushSubscription`

## 0.0.11

- expose `ServiceWorkerRegistration.jsObject`
- fix a few typing bug

## 0.0.10

- export ShowNotificationAction

## 0.0.9

- `PushManager.hasPermission()` is a deprecated API and it doesn't work in Chrome
  anymore, clients should use `permissionState()` instead.

## 0.0.8

- ServiceWorkerClient.postMessage() to use List as transfer objects parameter. 
- ServiceWorker.postMessage(): any Transferable object can be set, not only MessagePorts.

## 0.0.7

- removed Worker interface from JS facade, solves Dartium issue

## 0.0.1 - 0.0.6

### 0.0.6

- fixed Cache.keys()

### 0.0.5

- add support for WorkerLocation

### 0.0.4

- fetch() with RequestInit
- support for Headers cloning

### 0.0.3

- fix Cache.put() signature

### 0.0.2

- top-level fields and methods
