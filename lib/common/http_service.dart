import 'package:securepay/common/services/services.dart';
import 'package:dio/dio.dart';

GenericHttpService<T> createHttpService<T>({
  required Dio dio,
  required String endpoint,
  required T Function(Map<String, dynamic>) fromJson,
}) {
  return GenericHttpService<T>(
    dio: dio,
    endpoint: endpoint,
    fromJson: fromJson,
  );
}
