import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartpipenetwork/customwidget/gridview_page.dart';

class WorkBenchPage extends StatefulWidget {
  @override
  _WorkBenchPageState createState() => _WorkBenchPageState();
}

class _WorkBenchPageState extends State<WorkBenchPage> {
  final String headerImgUrl =
      'http://pages.ctrip.com/commerce/promote/20180718/yxzy/img/640sygd.jpg';
  final List<String> titles = ['巡查任务', '病害工单', '流程审批', '汛情申报', '汛情上报', '汛情处理'];
  final List<IconData> iconDatas = [
    Icons.border_all,
    Icons.border_all,
    Icons.edit,
    Icons.border_all,
    Icons.border_all,
    Icons.edit
  ];
  final routeNames = {'巡查任务': 'patorlTask'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('工作台'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 180,
            width: double.infinity,
            child: Image.asset(
              'images/2.jpg',
              fit: BoxFit.fill,
            ),
          ),
          GridViewPage(
              titles: titles, iconDatas: iconDatas, routeNames: routeNames)
        ],
      ),
    );
  }
}
