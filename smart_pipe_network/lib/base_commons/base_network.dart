import 'package:dio/dio.dart';
import 'base_shared_preferences.dart';

class BaseUrl {
  // 配置默认请求地址
  static const String url = 'http://dev.hn.hadutech.com/94/zzxg_server';
}

class HTTPQuerery {
  /// get请求
  ///
  /// url 请求的url
  /// params 请求参数
  /// headers 请求头需要设置的参数
  static Future get(
    String url, {
    Map<String, dynamic> params,
    Map<String, dynamic> headers,
  }) async {
    // 数据拼接get请求需要将参数拼接在url后边
    if (params != null && params.isNotEmpty) {
      StringBuffer options = new StringBuffer('?');
      params.forEach((key, value) {
        options.write('${key}=${value}&');
      });
      String optionsStr = options.toString();
      optionsStr = optionsStr.substring(0, optionsStr.length - 1);
      url += optionsStr;
    }
    // 发送get请求
    await _senderRequest(url, 'get', headers: headers);
  }

  /// post请求
  ///
  /// url 请求的url
  /// params 请求参数
  /// headers 请求头需要设置的参数
  static Future post(String url,
      {Map<String, dynamic> params, Map<String, dynamic> headers}) async {
    // 发送post请求
    return await _senderRequest(url, 'post', params: params, headers: headers);
  }

  /// 请求处理
  ///
  /// url 请求的url地址
  /// method 请求方式
  /// params 请求参数（可选参数类型）
  /// headers 请求头（可选参数类型）
  static Future _senderRequest(String url, String method,
      {Map<String, dynamic> params, Map<String, dynamic> headers}) async {
//    int _code;
//    String _msg;
//    var _backData;

    // 获取本地的token
    var token = await ShardPreferences.localGet('token');

    // 检测请求地址是否是完整地址
    if (!url.startsWith('http')) {
      url = BaseUrl.url + url;
    }

    print('token==$token===');
    try {
      Map<String, dynamic> httpHeader = {
        'Authentication': token,
      };

      if (headers != null) {
        httpHeader.addAll(headers);
      }
      // 配置请求头、超时时长、接受发送类型等信息
      Response response;
      BaseOptions option = BaseOptions(
        connectTimeout: 10000,
        //服务器链接超时，毫秒
        receiveTimeout: 3000,
        // 响应流上前后两次接收到数据的间隔，毫秒
        headers: httpHeader,
        // 添加headers,如需设置统一的headers信息也可在此添加
        contentType: "application/x-www-form-urlencoded",
        responseType: ResponseType.plain,
      );
      print('请求方式:$method\n'
          '请求头header:${option.toString()}\n'
          '请求的URL:$url\n'
          '请求的参数:$params');
      Dio dio = Dio(option);
      if (method == 'get') {
        response = await dio.get(url);
      } else {
        response = await dio.post(url, data: params);
      }
      print('response===$response====');
      return response.data;
    } catch (exception) {
      return '数据请求错误' + exception.toString();
    }
  }
}