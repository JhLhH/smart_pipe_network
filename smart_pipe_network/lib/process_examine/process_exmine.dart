import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartpipenetwork/base_commons/base_shared_preferences.dart';

class ProcessExaminePage extends StatefulWidget {
  final String url;
  final String title;

  const ProcessExaminePage({Key key,this.url,this.title}):super(key:key);

  @override
  _ProcessExaminePage createState() => _ProcessExaminePage();

}

class _ProcessExaminePage extends State<ProcessExaminePage> {
  String tokenStr;

  _getToken() async {
    var tempToken = await ShardPreferences.localGet('token');
    setState(()  {
      tokenStr = tempToken;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getToken();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      url: widget.url + '?token=$tokenStr',
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
