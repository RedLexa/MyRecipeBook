
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';


class ApiService {
  late final Dio _dio;

  //static const String localIp = '192.168.1.246'; // <-- CHANGE THIS TO YOUR COMPUTER'S IP
  static const String localIp = '192.168.0.31';

  static Future<String> getBaseUrl() async {
    String url;
    if (kIsWeb) {
      url = 'http://localhost:3002/api/v1';
    } else if (Platform.isAndroid || Platform.isIOS) {
      final deviceInfo = DeviceInfoPlugin();
      bool isEmulator = false;
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        isEmulator = !androidInfo.isPhysicalDevice;
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        isEmulator = !iosInfo.isPhysicalDevice;
      }
      if (isEmulator) {
        url = Platform.isAndroid
            ? 'http://10.0.2.2:3002/api/v1'
            : 'http://localhost:3002/api/v1';
      } else {
        url = 'http://$localIp:3002/api/v1';
      }
    } else {
      url = 'http://$localIp:3002/api/v1';
    }
    debugPrint('[ApiService] Using baseUrl: $url');
    return url;
  }

  ApiService({Dio? dio}) {
    // _dio must be initialized asynchronously now
    _initDio(dio);
  }

  Future<void> _initDio(Dio? dio) async {
    final baseUrl = await getBaseUrl();
    _dio = dio ?? _createDio(baseUrl);
  }

  Dio _createDio(String baseUrl) {
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Add logging in debug mode
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
      ));
    }

    return dio;
  }

  Future<void> ensureDioReady() async {
    if (_dio == null) {
      final baseUrl = await getBaseUrl();
      _dio = _createDio(baseUrl);
    }
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}) async {
    await ensureDioReady();
    try {
      final response = await _dio.get<dynamic>(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.unknown ||
          e.type == DioExceptionType.connectionError) {
        if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
          throw Exception(
              'Network error: Could not connect to the API.\n\nIf you are running on a physical device, make sure the IP address in ApiService (localIp) matches your computer\'s IP address and that your device is on the same Wi-Fi network.');
        } else {
          throw Exception('Network error: Could not connect to the API. Please check your network connection and API server.');
        }
      }
      rethrow;
    }
  }

  Future<dynamic> post(String path, {dynamic data}) async {
    await ensureDioReady();
    try {
      final response = await _dio.post<dynamic>(path, data: data);
      return response.data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.unknown ||
          e.type == DioExceptionType.connectionError) {
        if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
          throw Exception(
              'Network error: Could not connect to the API.\n\nIf you are running on a physical device, make sure the IP address in ApiService (localIp) matches your computer\'s IP address and that your device is on the same Wi-Fi network.');
        } else {
          throw Exception('Network error: Could not connect to the API. Please check your network connection and API server.');
        }
      }
      rethrow;
    }
  }

  Future<dynamic> delete(String path, {Map<String, dynamic>? queryParameters}) async {
    await ensureDioReady();
    try {
      final response = await _dio.delete<dynamic>(
          path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.unknown ||
          e.type == DioExceptionType.connectionError) {
        if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
          throw Exception(
              'Network error: Could not connect to the API.\n\nIf you are running on a physical device, make sure the IP address in ApiService (localIp) matches your computer\'s IP address and that your device is on the same Wi-Fi network.');
        } else {
          throw Exception('Network error: Could not connect to the API. Please check your network connection and API server.');
        }
      }
      rethrow;
    }
  }
}