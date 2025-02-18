import 'dart:io';

import 'package:delivery_app/src/core/constant/api.dart';
import 'package:delivery_app/src/core/network_services/dev_utils.dart';
import 'package:delivery_app/src/core/utiils_lib/common_utils.dart';
import 'package:delivery_app/src/core/utiils_lib/shared_pref_utils.dart';
import 'package:dio/dio.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Dio class wrapper for sending api request to the network
class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    _dio
      ..options.baseUrl = APIURL.BASE_URL
      ..options.connectTimeout = const Duration(seconds: 30)
      ..options.receiveTimeout = const Duration(seconds: 30)
      ..options.responseType = ResponseType.json
      ..options.contentType = Headers.jsonContentType
      ..interceptors.add(
          PrettyDioLogger(requestBody: true, compact: true, request: true));
  }

  /// Send GET request
  Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress,
      bool hideSoftKeyboard = true,
      required data}) async 
      {
    if (hideSoftKeyboard) 
    {
      // hideKeyBoard();
    }

    print("post request Bearer token: ${await SharedPrefUtils.getToken()}");

    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options ??
            Options(headers: 
            {
              "authorization": "Bearer ${await SharedPrefUtils.getToken()}"
            }),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Send POST request
  Future<Response> post(String url,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool hideSoftKeyboard = true}) async { 
    if (hideSoftKeyboard) {
      hideKeyBoard();
    }
    debugLog(" post request Bearer token: ${await SharedPrefUtils.getToken()}");
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options ??
            Options(headers: {
              "authorization": "Bearer ${await SharedPrefUtils.getToken()}"
            }),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Send PUT request
  Future<Response> patch(String url,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool hideSoftKeyboard = true}) async {
    if (hideSoftKeyboard) {
      hideKeyBoard();
    }
    debugLog("Put Bearer token: ${await SharedPrefUtils.getToken()}");
    try {
      final Response response = await _dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options ??
            Options(headers: {
              "authorization": "Bearer ${await SharedPrefUtils.getToken()}"
            }),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Send DELETE request
  Future<dynamic> delete(String url,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool hideSoftKeyboard = true}) async {
    if (hideSoftKeyboard) {
      hideKeyBoard();
    }
    debugLog("delete Bearer token: ${await SharedPrefUtils.getToken()}");
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options ??
            Options(headers: {
              "authorization": "Bearer ${await SharedPrefUtils.getToken()}"
            }),
        cancelToken: cancelToken,
      );
      return response;

      /// return response.data
    } catch (e) {
      rethrow;
    }
  }

  //Download:--------------------------------------------------------------------
  Future<dynamic> download(
    String url,
    dynamic savePath, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    hideKeyBoard();
    debugLog("Bearer ${await SharedPrefUtils.getToken()}");
    try {
      final Response response = await _dio.download(
        url,
        savePath,
        queryParameters: queryParameters,
        options: options ??
            Options(
                headers: {"authorization": await SharedPrefUtils.getToken()}),
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> uploadImage(String url, File imageFile,
      {Map<String, dynamic>? additionalFields,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool hideSoftKeyboard = true}) async {
    if (hideSoftKeyboard) {
      hideKeyBoard();
    }

    debugLog("UPLOAD IMAGE Bearer token: ${await SharedPrefUtils.getToken()}");

    try {
      String fileName = imageFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        "image":
            await MultipartFile.fromFile(imageFile.path, filename: fileName),
        ...?additionalFields,
      });

      final Response response = await _dio.post(
        url,
        data: formData,
        options: options ??
            Options(headers: {
              "authorization": "Bearer ${await SharedPrefUtils.getToken()}"
            }),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
