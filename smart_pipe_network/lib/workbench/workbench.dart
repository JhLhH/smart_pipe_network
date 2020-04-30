import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartpipenetwork/customwidget/gridview_page.dart';
import 'package:smartpipenetwork/workbench/patrol_task.dart';
import 'package:smartpipenetwork/process_examine/process_exmine.dart';

class WorkBenchPage extends StatefulWidget {
  @override
  _WorkBenchPageState createState() => _WorkBenchPageState();
}

class _WorkBenchPageState extends State<WorkBenchPage> {
  final String headerImgUrl =
      'http://pages.ctrip.com/commerce/promote/20180718/yxzy/img/640sygd.jpg';
  final List<String> titles = [
    '巡查任务',
    '病害工单',
    '流程审批',
    '汛情巡查',
    '汛情上报',
    '汛情处理',
    '病毒查看'
  ];
  final List<IconData> iconDatas = [
    Icons.border_all,
    Icons.border_all,
    Icons.edit,
    Icons.border_all,
    Icons.border_all,
    Icons.edit,
    Icons.edit
  ];
  final routeNames = {
    '巡查任务': 'patrolTask',
    '病害工单': 'ProcessExamine',
    '流程审批': 'ProcessExamine',
    '汛情巡查': 'ProcessExamine',
    '汛情上报': 'ProcessExamine',
    '汛情处理': 'ProcessExamine',
    '病毒查看': 'ProcessExamine'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Image(
            height: 244,
            width: double.infinity,
            image: AssetImage('images/banner.png'),
            fit: BoxFit.fill,
          ),
          GridViewPage(
              titles: titles, iconDatas: iconDatas, routeNames: routeNames)
        ],
      ),
    );
  }
}
