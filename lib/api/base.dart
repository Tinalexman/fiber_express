import 'dart:convert';

import 'package:dio/dio.dart';

export 'dart:developer' show log;

export 'package:dio/dio.dart';

const String frontEndClientUsername = "Frontend_Client";
const String frontEndClientPassword = "ejgM1l7S3jRCoqQqsrtdoVYsL8Vy7M";

final Dio dio = Dio(BaseOptions(
  baseUrl: "https://staging.broadbased.net/billingPlatform",
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

String btoa(String username, String password) {
  return base64Encode(utf8.encode('$username:$password'));
}
