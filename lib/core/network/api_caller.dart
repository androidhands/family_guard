import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/network/model/api_response.dart';
import 'package:family_guard/core/network/model/error_message.dart';

import '../services/dependency_injection_service.dart';

const String attachmentBaseUrl = '';

// const String baseUrl = "http://test.uturnsoftware.com/";
//const String baseUrl = "http://uturnsoftware.com/";
const String baseUrl = "https://development.uturnsoftware.com/";
const int defaultAppTenant = 1;

const String basicAuth =
    "YWJkZWxoYW1pZC5haG1lZC5hYmRvQGdtYWlsLmNvbTpBYmRvQEJvb2R5QDI1MjkwMA==";

class ApiCaller {
  Dio dio = Dio();

  Future<T> requestGet<T>(String url,
          {T Function(dynamic data)? builder,
          Map<String, dynamic>? headers,
          Map<String, dynamic>? queryParameters,
          String? token,
          int? tenantId,
          ResponseType? responseType,
          Function(ErrorMessage errorMessage)? onFailure}) =>
      _handleRequest<T>(
        _adjustRequestParameter(
          url,
          headers,
          dio.get,
          queryParameters: queryParameters,
          token: token,
          tenantId: tenantId,
          responseType: responseType,
        ),
        builder,
        onFailure,
      );

  Future<T> requestPost<T>(String url, T Function(dynamic data) builder,
          {dynamic body,
          Map<String, dynamic>? headers,
          String? token,
          int? tenantId,
          Function(ErrorMessage errorMessage)? onFailure}) =>
      _handleRequest<T>(
        _adjustRequestParameter(
          url,
          headers,
          dio.post,
          body: body,
          token: token,
          tenantId: tenantId,
        ),
        builder,
        onFailure,
      );

  Future<T?>? requestPatch<T>(String url, T Function(dynamic data) builder,
          {dynamic body,
          Map<String, dynamic>? headers,
          String? token,
          int? tenantId,
          Function(ErrorMessage errorMessage)? onFailure}) =>
      _handleRequest<T>(
        _adjustRequestParameter(
          url,
          headers,
          dio.patch,
          body: body,
          token: token,
          tenantId: tenantId,
        ),
        builder,
        onFailure,
      );

  Future<T?>? requestPut<T>(String url, T Function(dynamic data) builder,
          {dynamic body,
          Map<String, dynamic>? headers,
          String? token,
          int? tenantId,
          Function(ErrorMessage errorMessage)? onFailure}) =>
      _handleRequest<T>(
          _adjustRequestParameter(
            url,
            headers,
            dio.put,
            body: body,
            token: token,
            tenantId: tenantId,
          ),
          builder,
          onFailure);

  Future<T?>? requestDelete<T>(String url, T Function(dynamic data) builder,
          {dynamic body,
          Map<String, dynamic>? headers,
          String? token,
          int? tenantId,
          Function(ErrorMessage errorMessage)? onFailure}) =>
      _handleRequest<T>(
        _adjustRequestParameter(
          url,
          headers,
          dio.delete,
          body: body,
          token: token,
          tenantId: tenantId,
        ),
        builder,
        onFailure,
      );

  Map<String, dynamic> _getHeader(
      Map<String, dynamic>? headers, bool isMultiPartFile,
      {String? token, int? tenantId}) {
    return {
      'Content-Type': isMultiPartFile
          ? 'multipart/form-data'
          : 'application/json-patch+json',
      'accept': 'text/plain',
      'Abp.TenantId': tenantId,

      ///TODO Check if tenant id is null use the global tenant... global tenant should be set in signIn
      'Authorization': 'Basic $basicAuth',
      'auth-token': token
    }
      ..addAll(
        headers ?? {},
      )
      ..removeWhere((key, value) => value == null);
  }

  Function _adjustRequestParameter(
    String url,
    Map<String, dynamic>? headers,
    Function f, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    String? token,
    int? tenantId,
    ResponseType? responseType,
  }) {
    String uri = '${baseUrl}api$url';
    log(uri);
    //log(jsonEncode(body)); ///Warning this line must be commented in production or even if not used
    return () {
      bool isMultiPartFile = body is List
          ? false
          : body?.values.firstWhere(
                (element) {
                  return element.runtimeType.toString() == 'MultipartFile';
                },
                orElse: () => null,
              ) !=
              null;
      return (body == null)
          ? f(uri,
              options: Options(
                headers: _getHeader(headers, isMultiPartFile,
                    token: token, tenantId: tenantId),
                followRedirects: false,
                responseType: responseType,
                validateStatus: (status) {
                  log('$url Response code : $status');
                  return true;
                },
              ),
              queryParameters: (queryParameters ?? <String, dynamic>{})
                ..addAll(<String, dynamic>{
                  "culture": sl<BaseAppLocalizations>().getLanguageCode()
                }))
          : f(uri,
              options: Options(
                headers: _getHeader(headers, isMultiPartFile,
                    token: token, tenantId: tenantId),
                followRedirects: false,
                validateStatus: (status) {
                  log('$url Response code : $status');
                  return true;
                },
              ),
              data: isMultiPartFile ? FormData.fromMap(body) : jsonEncode(body),
              queryParameters: (queryParameters ?? <String, dynamic>{})
                ..addAll(<String, dynamic>{
                  "culture": sl<BaseAppLocalizations>().getLanguageCode()
                }));
    };
  }

  Future<T> _handleRequest<T>(
      Function requestMethod, Function? builder, Function? onFailure) async {
    if (builder == null) return Future.value();
    DateTime beforeRequestDate = DateTime.now();
    Response response = await requestMethod();
    log(response.data.toString());
    APIResponse data = APIResponse<T>.fromJson(response.data, builder);
    Duration requestTime = DateTime.now().difference(beforeRequestDate);
    log('Request took ${requestTime.inMilliseconds.toString()} ms');
    if (data.success) {
      return data.data;
    } else {
      log('Failure occurred : ${data.message}');
      // showServerErrorDialog(data.message!.message);
      if (onFailure != null) onFailure(data.message);
    }
    return Future.value();
  }
}

// Future<Stream> streamRequest(String url, [Map<String, dynamic>? query]) async {
//   http.Client client = http.Client();
//   http.Request request = http.Request("GET", Uri.http(baseUrl, '/api/$url' , query));
//   request.headers["Accept"] = "text/event-stream";
//   request.headers["Cache-Control"] = "no-cache";
//   http.StreamedResponse response = await client.send(request);
//   // log("URL _ " + url);
//   return response.stream.map((value) {
//     final parsedData = utf8.decode(value);
//     // log("this is ${parsedData}");
//     final realParsedData = json.decode(parsedData); //.split("data:")[1]
//     // log(realParsedData);
//
//     return realParsedData;
//   });
// }
