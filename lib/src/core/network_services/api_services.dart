
import 'package:delivery_app/src/core/network_services/dio_client.dart';
import 'package:delivery_app/src/core/network_services/service_locator.dart';
import 'package:flutter/material.dart';



/// Base api service
abstract class ApiService {
  // Dio client object
  @protected
  final api = getIt<DioClient>();
}
