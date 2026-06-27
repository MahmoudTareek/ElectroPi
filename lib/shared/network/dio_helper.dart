import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://dummyjson.com/',

        receiveDataWhenStatusError: true,

        headers: {'Content-Type': 'application/json'},
      ),
    );
  }

  static Future<Response> postData({
    required String url,

    required Map<String, dynamic> data,
  }) async {
    return await dio.post(url, data: data);
  }

  static Future<Response> getData({required String url, String? token}) async {
    return await dio.get(
      url,

      options: Options(
        headers: {if (token != null) 'Authorization': 'Bearer $token'},
      ),
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
  }) async {
    return await dio.put(url, data: data, queryParameters: query);
  }
}
