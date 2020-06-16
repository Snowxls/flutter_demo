//import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class HttpManager {
  static final Dio dio = Dio();

  static Future request(String url,
      {String method = 'get',
      Map<String, String> headers,
      Map<String, dynamic> queryParameters,
      int timeOut}) {
    //创建配置
    final options =
        Options(method: method, headers: headers, receiveTimeout: timeOut);
    //发网络请求
    return dio.request(url, queryParameters: queryParameters, options: options);
  }
}

Future<Response> get(url,
    {Map<String, String> headers,
    Map<String, dynamic> queryParameters,
    int timeOut}) {
  final dio = Dio();
  final options = Options(headers: headers);

  return HttpManager.request(url,
      queryParameters: queryParameters,
      headers: headers,
      method: 'get',
      timeOut: timeOut);
}
