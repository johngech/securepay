import 'package:dio/dio.dart';

abstract interface class HttpService<T> {
  Future<List<T>> getAll();
  Future<T> getById(int id);
  Future<T> create(Map<String, dynamic> data);
  Future<T> update(int id, Map<String, dynamic> data);
  Future<void> delete(int id);
}

class GenericHttpService<T> implements HttpService<T> {
  final Dio _dio;
  final String endpoint;
  final T Function(Map<String, dynamic>) fromJson;

  GenericHttpService({
    required Dio dio,
    required this.endpoint,
    required this.fromJson,
  }) : _dio = dio;

  @override
  Future<List<T>> getAll() async {
    try {
      final response = await _dio.get(endpoint);
      final List<dynamic> data = response.data;
      return data.map((item) => fromJson(item)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<T> getById(int id) async {
    try {
      final response = await _dio.get('$endpoint/$id');
      return fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<T> create(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<T> update(int id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('$endpoint/$id', data: data);
      return fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> delete(int id) async {
    try {
      await _dio.delete('$endpoint/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException e) {
    if (e.response != null) {
      // This catches  Error responses (400, 404, 500)
      return e.response?.data['message'] ??
          'Server Error: ${e.response?.statusCode}';
    }
    return 'Network Error: ${e.message}';
  }
}
