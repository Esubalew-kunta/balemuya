import 'package:blaemuya/core/api/endpoints.dart';
import 'package:blaemuya/core/storage/token_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioClient {
  final Dio dio;
  final TokenStorage tokenStorage;

  DioClient({required this.dio, required this.tokenStorage}) {
    dio.options = BaseOptions(
      baseUrl: 'https://balemuya-project.vercel.app/',
      contentType: 'application/json',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );

    // logging requests and responses
    dio.interceptors.add(LogInterceptor(
      request: true, 
      requestHeader: true, 
      requestBody: true, 
      responseHeader: true,
      responseBody: true, 
      error: true, 
      logPrint: (log) {
        debugPrint(log.toString());
      },
    ));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onError: _onError,
      ),
    );
  }

  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await tokenStorage.getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options);
  }

  Future<void> _onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      try {
        final newToken = await _refreshToken();
        final request = err.requestOptions;
        request.headers['Authorization'] = 'Bearer $newToken';
        return handler.resolve(await dio.fetch(request));
      } catch (refreshError) {
        await tokenStorage.deleteAllTokens();
        handler.reject(err);
      }
    }
    handler.next(err);
  }

  Future<String> _refreshToken() async {
    final refreshToken = await tokenStorage.getRefreshToken();
    if (refreshToken == null) throw Exception('No refresh token available');
    
    final response = await dio.post(
      Endpoints.refreshToken,
      data: {'refresh': refreshToken},
    );
    
    final newAccessToken = response.data['access'];
    await tokenStorage.saveAccessToken(newAccessToken);
    return newAccessToken;
  }
}