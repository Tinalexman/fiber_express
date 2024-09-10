import 'package:dio/dio.dart';

export 'dart:developer' show log;

export 'package:dio/dio.dart';

final Dio dio = Dio(BaseOptions(
  baseUrl: "",
  sendTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 30),
  connectTimeout: const Duration(seconds: 30),
));

class FiberResponse<T> {
  final String message;
  final T data;
  final bool success;

  const FiberResponse({
    required this.message,
    required this.data,
    required this.success,
  });
}
