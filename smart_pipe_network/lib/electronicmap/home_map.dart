import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class HomeMapPage extends StatefulWidget {
  @override
  _HomeMapPageState createState() => _HomeMapPageState();
}

class _HomeMapPageState extends State<HomeMapPage> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text('电子地图'),
      ),

      url: 'http://117.159.24.4:30082/mainMap/index.html#/',
      // 显示环形进度条如果设置了initialChild将不显示进度条
      hidden: true,
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
