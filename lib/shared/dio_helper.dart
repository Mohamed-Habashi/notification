import 'package:dio/dio.dart';



class DioHelper{
  static Dio ? dio;

  static init(){
    dio = Dio(
      BaseOptions(
        // baseUrl: 'https://api.weatherapi.com/v1/',
        //baseUrl: 'https://student.valuxapps.com/api/',
        baseUrl: 'https://fcm.googleapis.com/',
        receiveDataWhenStatusError: true,
      ),
    );
  }
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang='en',
    String ?token,
  })async{
    dio!.options.headers={
      'Content-Type':'application/json',
      'Authorization':token,
      'lang':lang,
    };
    return await dio!.get(url,queryParameters: query,);
  }

  static Future<Response> postData({
    required String url,
    Map<String,dynamic>? query,
    required Map<String,dynamic>? data,
    String lang='en',
    String? token,
  })async{
    dio!.options.headers={
      'Content-Type':'application/json',
      'Authorization':'key=AAAAkDUu1jk:APA91bG_79lEYBXL0qZQ5DPSIRe4dVQhlAFWSYoyVgdfNiKszeXd1_1y4L3bhW0rlYxcfWUYDJwjmCZN7FDmA-aeizBhaSjm1Z1uIMZFLrvWqvhP-341GTDNTp8mJf0jTDse-vlUr7ql',
      'lang':lang,
    };
    return await dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String,dynamic>? query,
    required Map<String,dynamic>? data,
    String lang='en',
    String? token,
  })async{
    dio!.options.headers={
      'Content-Type':'application/json',
      'Authorization':token??'',
      'lang':lang,
    };
    return await dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

}