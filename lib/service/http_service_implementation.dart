import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:news_app_getx/constants.dart';
import 'package:news_app_getx/service/http_service.dart';

class HttpServiceImpl implements HttpService{

  Dio _dio;

  @override
  Future<Response> getRequest({String url}) async{
    // TODO: implement getRequest
    Response response;
    try {
       response = await _dio.get(url);
    } on DioError catch (e) {
      // TODO
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  initializeInterceptos(){
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (error){
        print("error at interceptor $error");
      },
        onRequest:  (request){
        print("request at interceptor ${request.method} | ${request.path}");
        },
      onResponse: (response){
        print("Response at interceptor ${response.statusCode} | ${response.statusMessage} | ${response.data}");
      }

    ));
  }

  @override
  void init() {
    // TODO: implement init
    _dio = Dio(BaseOptions(
      baseUrl: BASE_URL,
      headers: {"Authorization" : "Bearer $API_KEY"}
    ));

    initializeInterceptos();
  }

}