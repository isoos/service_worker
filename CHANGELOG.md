# Changelog

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
