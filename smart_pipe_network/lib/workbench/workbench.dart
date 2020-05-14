import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartpipenetwork/customwidget/gridview_page.dart';
import 'package:smartpipenetwork/models/login_model_entity.dart';
import 'package:smartpipenetwork/workbench/patrol_task.dart';
import 'package:smartpipenetwork/process_examine/process_exmine.dart';
import 'package:smartpipenetwork/base_commons/base_shared_preferences.dart';

class WorkBenchPage extends StatefulWidget {
  final LoginModelEntity loginModelEntity;

  const WorkBenchPage({Key key, this.loginModelEntity}) : super(key: key);

  @override
  _WorkBenchPageState createState() => _WorkBenchPageState();
}

class _WorkBenchPageState extends State<WorkBenchPage> {
  String tokenStr;

  final String headerImgUrl =
      'http://pages.ctrip.com/commerce/promote/20180718/yxzy/img/640sygd.jpg';
Map<String,AssetImage> data = {
  '巡查任务': AssetImage('images/xunjian@2x.png'),
  '病害工单': AssetImage('images/binghai@2x.png'),
  '流程审批': AssetImage('images/liucheng@2x.png'),
  '汛情巡查': AssetImage('images/xuncha@2x.png'),
  '汛情上报': AssetImage('images/shangbao@2x.png'),
  '汛情处理': AssetImage('images/chuli@2x.png')
};

   List<String> titles;
   List<AssetImage> iconDatas;
  Map<String, String> routeNames = {
    '巡查任务': 'patrolTask',
    '病害工单': 'ProcessExamine',
    '流程审批': 'ProcessExamine',
    '汛情巡查': 'ProcessExamine',
    '汛情上报': 'ProcessExamine',
    '汛情处理': 'ProcessExamine'
  };

  _getToken() async {
    var tempToken = await ShardPreferences.localGet('token');
    setState(() {
      tokenStr = tempToken;
    });
  }

  @override
  void initState() {
    super.initState();
    // 配置数据
    List<String> appPermissions = widget.loginModelEntity.result.appPermissions;
    List<String> tempTitles = [];
    List<AssetImage> tempIconDatas = [];
    appPermissions.forEach((element) {
      if(data.keys.contains(element)){
        tempTitles.add(element);
        tempIconDatas.add(data[element]);
      }
    });
    setState(() {
      titles = tempTitles;
      iconDatas = tempIconDatas;
    });
    _getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('工作台'),
      ),
      body: Column(
        children: <Widget>[
          Image(
            height: 180,
            width: double.infinity,
            image: AssetImage('images/banner.png'),
            fit: BoxFit.fill,
          ),
          titles.length > 0? GridViewPage(
              titles: titles, iconDatas: iconDatas, routeNames: routeNames): Text('数据获取中...')
        ],
      ),
    );
  }
}
