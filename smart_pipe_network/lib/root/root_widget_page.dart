import 'package:flutter/material.dart';
import 'package:smartpipenetwork/electronicmap/home_map.dart';
import 'package:smartpipenetwork/systemsetting/system_setting.dart';
import 'package:smartpipenetwork/workbench/disease_report.dart';
import 'package:smartpipenetwork/workbench/disease_report_details.dart';
import 'package:smartpipenetwork/workbench/patrol_task.dart';
import 'package:smartpipenetwork/workbench/patrol_task_details.dart';
import 'package:smartpipenetwork/workbench/workbench.dart';

class RootWidgetPage extends StatefulWidget {
  @override
  _RootWidgetPageState createState() => _RootWidgetPageState();
}

class _RootWidgetPageState extends State<RootWidgetPage> {
  int _currentIndex = 0;
  var _body;

  List<String> bottomBarTitles = ['电子地图', '工作台', '系统设置'];
  List<Icon> bottomSelectImages = [
    Icon(Icons.map),
    Icon(Icons.dashboard),
    Icon(Icons.settings)
  ];
  List<Icon> bottomUnselectImages = [
    Icon(Icons.map),
    Icon(Icons.dashboard),
    Icon(Icons.settings)
  ];

  /// 路由表
  Map<String, WidgetBuilder> routes = {
    'patorlTask': (context) => PatrolTaskPage(),
    'PatrolTaskDetailsPage': (context) => PatrolTaskDetailsPage(),
    'DiseaseReportPage': (context) => DiseaseReportPage(),
    'DiseaseDetailsPage':(context) =>DiseaseDetailsPage(),
  };

  changeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  initData() {
    _body = IndexedStack(
      children: <Widget>[HomeMapPage(), WorkBenchPage(), SystemSettingPage()],
      index: _currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: _getBottomNavigatorItems(),
          onTap: changeIndex,
          currentIndex: _currentIndex,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
        ),
        body: _body,
      ),
      routes: routes,
    );
  }

  List<BottomNavigationBarItem> _getBottomNavigatorItems() {
    List<BottomNavigationBarItem> items = [];
    for (int i = 0; i < bottomBarTitles.length; i++) {
      items.add(_getBottomNavigatorItem(
          bottomBarTitles[i], bottomSelectImages[i], bottomUnselectImages[i]));
    }
    return items;
  }

  BottomNavigationBarItem _getBottomNavigatorItem(
      String title, Icon selectIcon, Icon unSelectIcon) {
    return BottomNavigationBarItem(
      icon: selectIcon,
//      activeIcon: unSelectIcon,
      title: Text(title),
    );
  }
}
