import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smartpipenetwork/base_commons/base_network.dart';
import 'package:smartpipenetwork/base_commons/base_shared_preferences.dart';
import 'package:amap_location/amap_location.dart';
import 'package:smartpipenetwork/models/location_model_entity.dart';
import 'package:dio/dio.dart';
class ProcessExaminePage extends StatefulWidget {
  final String url;
  final String title;

  const ProcessExaminePage({Key key,this.url,this.title}):super(key:key);

  @override
  _ProcessExaminePage createState() => _ProcessExaminePage();

}

class _ProcessExaminePage extends State<ProcessExaminePage> {

  String tokenStr;
  String str=null;

  _getToken() async {
    var tempToken = await ShardPreferences.localGet('token');
    setState(()  {
      tokenStr = tempToken;
    });
  }

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  //js 调用flutter
  JavascriptChannel _alertJavascriptChannel (BuildContext context)  {
    return JavascriptChannel(
        name: 'Toast',
        onMessageReceived: (JavascriptMessage message) {
          _getlocalstr();
          Future.delayed(Duration(seconds: 2), (){
            _putLocation(message.message);
            print('延时1s执行');
          });

        });
  }

  _putLocation(String id) async{
    // 配置请求头、超时时长、接受发送类型等信息
    Response response;
    var token = await ShardPreferences.localGet('token');
    Map<String, dynamic> httpHeader = {
      'Authentication': token,
    };
    BaseOptions option = BaseOptions(
      connectTimeout: 10000,
      //服务器链接超时，毫秒
      receiveTimeout: 3000,
      // 响应流上前后两次接收到数据的间隔，毫秒
      headers: httpHeader,
      // 添加headers,如需设置统一的headers信息也可在此添加
      contentType: 'application/json',
      responseType: ResponseType.plain,
    );
    Dio dio = Dio(option);
    Map<String, dynamic> m={
      "waterPosition":str,
    };
    response = await dio.put(BaseUrl.url+'/ftask/location/'+id, data: m);
    /// 拿到最初的数据用以判断请求是否成功以及失败的msg提示
    Map<String, dynamic> tempResponse = json.decode(response.data);
    print('response===${json.decode(response.data)}====');
  }

  _getlocalstr() async{
    AMapLocation location = await _getLocation();
    LocationModelEntity l;
  }



  /// 提示
  void showCenterShortToast(String s) {
    Fluttertoast.showToast(
        msg: s,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1);
  }
  _getLocation() async {
    //先启动一下
    await AMapLocationClient.startup(new AMapLocationOption(
        desiredAccuracy: CLLocationAccuracy.kCLLocationAccuracyHundredMeters));
    //直接获取定位
    AMapLocation location = await AMapLocationClient.getLocation(true);
    if (location != null) {
      str='${location.longitude},${location.latitude}';
      return location;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    _getToken();
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      url: widget.url + '?token=$tokenStr',
      javascriptChannels: <JavascriptChannel>[ //javascriptChannels这个是api提供的互调的方法，
        _alertJavascriptChannel(context),
      ].toSet(),
      // 显示环形进度条如果设置了initialChild将不显示进度条
      hidden: true,
      withJavascript: true,
      // 在等待页面加载时显示其他内容可以放其他的widget
      initialChild: Container(
        color: Colors.white,
        child: Center(
          child: Text('页面加载中...'),
        ),
      ),
    );
  }
}
