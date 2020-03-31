@JS()
library isomorphic_fetch;

import 'dart:html' show Blob, FormData;
import 'dart:typed_data' show ByteBuffer;

import 'package:js/js.dart';

import 'promise.dart';

/// Type definitions for isomorphic-fetch 0.0
/// Project: https://github.com/matthew-andrews/isomorphic-fetch
/// Definitions by: Todd Lucas <https://github.com/toddlucas>
/// Definitions: https://github.com/DefinitelyTyped/DefinitelyTyped
/*type RequestType =
    '' | 'audio' | 'font' | 'image' | 'script' | 'style' | 'track' | 'video';*/
/*type RequestDestination = '' |
    'document' |
    'embed' |
    'font' |
    'image' |
    'manifest' |
    'media' |
    'object' |
    'report' |
    'script' |
    'serviceworker' |
    'sharedworker' |
    'style' |
    'worker' |
    'xslt';*/
/*type RequestMode = 'navigate' | 'same-origin' | 'no-cors' | 'cors';*/
/*type RequestCredentials = 'omit' | 'same-origin' | 'include';*/
/*type RequestCache = 'default' |
    'no-store' |
    'reload' |
    'no-cache' |
    'force-cache' |
    'only-if-cached';*/
/*type RequestRedirect = 'follow' | 'error' | 'manual';*/
/*type ResponseType =
    'basic' | 'cors' | 'default' | 'error' | 'opaque' | 'opaqueredirect';*/
/*type ReferrerPolicy = '' |
    'no-referrer' |
    'no-referrer-when-downgrade' |
    'same-origin' |
    'origin' |
    'strict-origin' |
    'origin-when-cross-origin' |
    'strict-origin-when-cross-origin' |
    'unsafe-url';*/
@anonymous
@JS()
abstract class HeadersInterface {
  external void append(String name, String value);
  external void delete(String name);
  external String /*String|Null*/ JS$get(String name);
  external List<String> getAll(String name);
  external bool has(String name);
  external void JS$set(String name, String value);

  /// TODO: iterable<string, string>;
  external void forEach(
      void callback(String value, num index, HeadersInterface headers),
      [dynamic thisArg]);
}

/*type HeadersInit = Headers | string[] | { [index: string]: string };*/
@JS()
class Headers implements HeadersInterface {
  external factory Headers(
      [dynamic /*Headers|List<String>|JSMap of <String,String>*/ init]);
  external void append(String name, String value);
  external void delete(String name);
  external String /*String|Null*/ JS$get(String name);
  external List<String> getAll(String name);
  external bool has(String name);
  external void JS$set(String name, String value);
  external void forEach(
      void callback(String value, num index, HeadersInterface headers),
      [dynamic thisArg]);
}

@anonymous
@JS()
abstract class BodyInterface {
  external bool get bodyUsed;
  external set bodyUsed(bool v);
  external Promise<ByteBuffer> arrayBuffer();
  external Promise<Blob> blob();
  external Promise<FormData> formData();
  external Promise<T> json<T>();
  external Promise<String> text();
}

@JS()
class Body implements BodyInterface {
  external bool get bodyUsed;
  external set bodyUsed(bool v);
  external Promise<ByteBuffer> arrayBuffer();
  external Promise<Blob> blob();
  external Promise<FormData> formData();
  external Promise<T> json<T>();
  external Promise<String> text();
}

@anonymous
@JS()
abstract class RequestInterface implements BodyInterface {
  external String get method;
  external set method(String v);
  external String get url;
  external set url(String v);
  external HeadersInterface get headers;
  external set headers(HeadersInterface v);
  external String /*''|'audio'|'font'|'image'|'script'|'style'|'track'|'video'*/ get type;
  external set type(
      String /*''|'audio'|'font'|'image'|'script'|'style'|'track'|'video'*/ v);
  external String /*''|'document'|'embed'|'font'|'image'|'manifest'|'media'|'object'|'report'|'script'|'serviceworker'|'sharedworker'|'style'|'worker'|'xslt'*/ get destination;
  external set destination(
      String /*''|'document'|'embed'|'font'|'image'|'manifest'|'media'|'object'|'report'|'script'|'serviceworker'|'sharedworker'|'style'|'worker'|'xslt'*/ v);
  external String get referrer;
  external set referrer(String v);
  external String /*''|'no-referrer'|'no-referrer-when-downgrade'|'same-origin'|'origin'|'strict-origin'|'origin-when-cross-origin'|'strict-origin-when-cross-origin'|'unsafe-url'*/ get referrerPolicy;
  external set referrerPolicy(
      String /*''|'no-referrer'|'no-referrer-when-downgrade'|'same-origin'|'origin'|'strict-origin'|'origin-when-cross-origin'|'strict-origin-when-cross-origin'|'unsafe-url'*/ v);
  external String /*'navigate'|'same-origin'|'no-cors'|'cors'*/ get mode;
  external set mode(String /*'navigate'|'same-origin'|'no-cors'|'cors'*/ v);
  external String /*'omit'|'same-origin'|'include'*/ get credentials;
  external set credentials(String /*'omit'|'same-origin'|'include'*/ v);
  external String /*'default'|'no-store'|'reload'|'no-cache'|'force-cache'|'only-if-cached'*/ get cache;
  external set cache(
      String /*'default'|'no-store'|'reload'|'no-cache'|'force-cache'|'only-if-cached'*/ v);
  external String /*'follow'|'error'|'manual'*/ get redirect;
  external set redirect(String /*'follow'|'error'|'manual'*/ v);
  external String get integrity;
  external set integrity(String v);
  external RequestInterface clone();
}

/*type BodyInit = Blob |
    ArrayBufferView |
    ArrayBuffer |
    FormData /* | URLSearchParams */ |
    string;*/
@anonymous
@JS()
abstract class RequestInit {
  external String get method;
  external set method(String v);
  external dynamic /*Headers|List<String>|JSMap of <String,String>*/ get headers;
  external set headers(
      dynamic /*Headers|List<String>|JSMap of <String,String>*/ v);
  external dynamic /*Blob|TypedData|ByteBuffer|FormData|String*/ get body;
  external set body(dynamic /*Blob|TypedData|ByteBuffer|FormData|String*/ v);
  external String get referrer;
  external set referrer(String v);
  external String /*''|'no-referrer'|'no-referrer-when-downgrade'|'same-origin'|'origin'|'strict-origin'|'origin-when-cross-origin'|'strict-origin-when-cross-origin'|'unsafe-url'*/ get referrerPolicy;
  external set referrerPolicy(
      String /*''|'no-referrer'|'no-referrer-when-downgrade'|'same-origin'|'origin'|'strict-origin'|'origin-when-cross-origin'|'strict-origin-when-cross-origin'|'unsafe-url'*/ v);
  external String /*'navigate'|'same-origin'|'no-cors'|'cors'*/ get mode;
  external set mode(String /*'navigate'|'same-origin'|'no-cors'|'cors'*/ v);
  external String /*'omit'|'same-origin'|'include'*/ get credentials;
  external set credentials(String /*'omit'|'same-origin'|'include'*/ v);
  external String /*'default'|'no-store'|'reload'|'no-cache'|'force-cache'|'only-if-cached'*/ get cache;
  external set cache(
      String /*'default'|'no-store'|'reload'|'no-cache'|'force-cache'|'only-if-cached'*/ v);
  external String /*'follow'|'error'|'manual'*/ get redirect;
  external set redirect(String /*'follow'|'error'|'manual'*/ v);
  external String get integrity;
  external set integrity(String v);
  external dynamic get window;
  external set window(dynamic v);
  external factory RequestInit(
      {String method,
      dynamic /*Headers|List<String>|JSMap of <String,String>*/ headers,
      dynamic /*Blob|TypedData|ByteBuffer|FormData|String*/ body,
      String referrer,
      String /*''|'no-referrer'|'no-referrer-when-downgrade'|'same-origin'|'origin'|'strict-origin'|'origin-when-cross-origin'|'strict-origin-when-cross-origin'|'unsafe-url'*/ referrerPolicy,
      String /*'navigate'|'same-origin'|'no-cors'|'cors'*/ mode,
      String /*'omit'|'same-origin'|'include'*/ credentials,
      String /*'default'|'no-store'|'reload'|'no-cache'|'force-cache'|'only-if-cached'*/ cache,
      String /*'follow'|'error'|'manual'*/ redirect,
      String integrity,
      dynamic window});
}

/*type RequestInfo = RequestInterface | string;*/
@JS()
class Request extends Body implements RequestInterface {
  external factory Request(dynamic /*RequestInterface|String*/ input,
      [RequestInit init]);
  external String get method;
  external set method(String v);
  external String get url;
  external set url(String v);
  external HeadersInterface get headers;
  external set headers(HeadersInterface v);
  external String /*''|'audio'|'font'|'image'|'script'|'style'|'track'|'video'*/ get type;
  external set type(
      String /*''|'audio'|'font'|'image'|'script'|'style'|'track'|'video'*/ v);
  external String /*''|'document'|'embed'|'font'|'image'|'manifest'|'media'|'object'|'report'|'script'|'serviceworker'|'sharedworker'|'style'|'worker'|'xslt'*/ get destination;
  external set destination(
      String /*''|'document'|'embed'|'font'|'image'|'manifest'|'media'|'object'|'report'|'script'|'serviceworker'|'sharedworker'|'style'|'worker'|'xslt'*/ v);
  external String get referrer;
  external set referrer(String v);
  external String /*''|'no-referrer'|'no-referrer-when-downgrade'|'same-origin'|'origin'|'strict-origin'|'origin-when-cross-origin'|'strict-origin-when-cross-origin'|'unsafe-url'*/ get referrerPolicy;
  external set referrerPolicy(
      String /*''|'no-referrer'|'no-referrer-when-downgrade'|'same-origin'|'origin'|'strict-origin'|'origin-when-cross-origin'|'strict-origin-when-cross-origin'|'unsafe-url'*/ v);
  external String /*'navigate'|'same-origin'|'no-cors'|'cors'*/ get mode;
  external set mode(String /*'navigate'|'same-origin'|'no-cors'|'cors'*/ v);
  external String /*'omit'|'same-origin'|'include'*/ get credentials;
  external set credentials(String /*'omit'|'same-origin'|'include'*/ v);
  external String /*'default'|'no-store'|'reload'|'no-cache'|'force-cache'|'only-if-cached'*/ get cache;
  external set cache(
      String /*'default'|'no-store'|'reload'|'no-cache'|'force-cache'|'only-if-cached'*/ v);
  external String /*'follow'|'error'|'manual'*/ get redirect;
  external set redirect(String /*'follow'|'error'|'manual'*/ v);
  external String get integrity;
  external set integrity(String v);
  external RequestInterface clone();
}

@anonymous
@JS()
abstract class ResponseInterface implements BodyInterface {
  external String /*'basic'|'cors'|'default'|'error'|'opaque'|'opaqueredirect'*/ get type;
  external set type(
      String /*'basic'|'cors'|'default'|'error'|'opaque'|'opaqueredirect'*/ v);
  external String get url;
  external set url(String v);
  external bool get redirected;
  external set redirected(bool v);
  external num get status;
  external set status(num v);
  external String get statusText;
  external set statusText(String v);
  external bool get ok;
  external set ok(bool v);
  external HeadersInterface get headers;
  external set headers(HeadersInterface v);

  /// size: number;
  /// timeout: number;
  external dynamic get body;
  external set body(dynamic v);
  external Promise<HeadersInterface> get trailer;
  external set trailer(Promise<HeadersInterface> v);
  external ResponseInterface clone();
}

/*type ResponseBodyInit = BodyInit;*/
@anonymous
@JS()
abstract class ResponseInit {
  external num get status;
  external set status(num v);
  external String get statusText;
  external set statusText(String v);
  external dynamic /*Headers|List<String>|JSMap of <String,String>*/ get headers;
  external set headers(
      dynamic /*Headers|List<String>|JSMap of <String,String>*/ v);
  external factory ResponseInit(
      {num status,
      String statusText,
      dynamic /*Headers|List<String>|JSMap of <String,String>*/ headers});
}

@JS()
class Response extends Body implements ResponseInterface {
  external factory Response(
      [dynamic /*Blob|TypedData|ByteBuffer|FormData|String*/ body,
      ResponseInit init]);
  external static ResponseInterface redirect(String url, [num status]);
  external static ResponseInterface error();
  external String /*'basic'|'cors'|'default'|'error'|'opaque'|'opaqueredirect'*/ get type;
  external set type(
      String /*'basic'|'cors'|'default'|'error'|'opaque'|'opaqueredirect'*/ v);
  external String get url;
  external set url(String v);
  external bool get redirected;
  external set redirected(bool v);
  external num get status;
  external set status(num v);
  external String get statusText;
  external set statusText(String v);
  external bool get ok;
  external set ok(bool v);
  external HeadersInterface get headers;
  external set headers(HeadersInterface v);
  external dynamic get body;
  external set body(dynamic v);
  external Promise<HeadersInterface> get trailer;
  external set trailer(Promise<HeadersInterface> v);
  external ResponseInterface clone();
}

/* Skipping class Window*/
@JS()
external dynamic get fetch;
@JS()
external set fetch(dynamic v);
// Module isomorphic-fetch
/* WARNING: export assignment not yet supported. */

// End module isomorphic-fetch
