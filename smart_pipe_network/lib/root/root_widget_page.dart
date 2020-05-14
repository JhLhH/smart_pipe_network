import 'package:flutter/material.dart';
import 'package:smartpipenetwork/electronicmap/home_map.dart';
import 'package:smartpipenetwork/models/login_model_entity.dart';
import 'package:smartpipenetwork/process_examine/process_exmine.dart';
import 'package:smartpipenetwork/systemsetting/system_setting.dart';
import 'package:smartpipenetwork/workbench/patrol_task.dart';
import 'package:smartpipenetwork/workbench/workbench.dart';
import 'package:smartpipenetwork/workbench/patrol_task_details.dart';
import 'package:smartpipenetwork/workbench/disease_report.dart';
import 'package:smartpipenetwork/workbench/disease_report_details.dart';
import 'package:smartpipenetwork/login/login.dart';


class RootWidgetPage extends StatefulWidget {
  final LoginModelEntity loginModelEntity;

  const RootWidgetPage({Key key, this.loginModelEntity}) : super(key: key);
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
    'patrolTask':(context)=>PatrolTaskPage(),//这里注册路由才能跳转,patrolTask是路由名字
    'PatrolTaskDetailsPage': (context) => PatrolTaskDetailsPage(),
    'ProcessExamine':(context) => ProcessExaminePage(),
    'DiseaseReportPage': (context) => DiseaseReportPage(),
    'DiseaseDetailsPage':(context) => DiseaseDetailsPage(),
    'LoginPage':(context) => LoginPage(),
  };// 这里没写路由

  changeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        body: _getBody(),
      ),
      routes: routes,
    );
  }

  _getBody(){
    if(_currentIndex == 0){
      return HomeMapPage();
    } if(_currentIndex == 1){
      return WorkBenchPage(loginModelEntity: widget.loginModelEntity,);
    }
    return SystemSettingPage();
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
