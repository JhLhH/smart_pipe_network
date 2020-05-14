import 'package:flutter/material.dart';
import 'package:smartpipenetwork/process_examine/process_exmine.dart';
// ignore: must_be_immutable
class GridViewPage extends StatefulWidget {
  /// 标题名字
  List<String> titles = [];

  /// 每个Item要展示的Icon
  List<AssetImage> iconDatas = [];

  /// 路由名字每一个Item对应跳转的界面路由
  /// key值为titles中的元素，value为路由名字
  Map<String, String> routeNames;

  GridViewPage(
      {@required this.titles,
      @required this.iconDatas,
      @required this.routeNames});

  @override
  _GridViewPageState createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      crossAxisSpacing: 5.0,
      mainAxisSpacing: 5.0,
      children: _getWidgetList(context),
    );
  }

  List<Widget> _getWidgetList(BuildContext context) {
    List<Widget> items = [];
    for (int i = 0; i < widget.titles.length; i++) {
      items.add(
          _getItemContainer(context, widget.titles[i], widget.iconDatas[i]));
    }
    return items;
  }

  Widget _getItemContainer(BuildContext context, String title, AssetImage icon) {
    return GestureDetector(
      onTap: () {
        if (widget.routeNames != null && widget.routeNames[title] != null) {
          print('当前点击$title Item');
          if (title == '病害工单') {
            _pushParameterWidgetPage(
              //http://117.159.24.4:30082/spList/index.html#/
              //http://dev.hn.hadutech.com/94
                context, 'http://117.159.24.4:30082/desease/index.html#/', title);
          } else if (title == '流程审批') {
            _pushParameterWidgetPage(
                context, 'http://117.159.24.4:30082/spList/index.html#/', title);
          } else if (title == '汛情巡查') {
            _pushParameterWidgetPage(
                context, 'http://117.159.24.4:30082/floodInspection/index.html#/', title);
          } else if (title == '汛情上报') {
            _pushParameterWidgetPage(
                context, 'http://117.159.24.4:30082/floodTask/index.html#/', title);
          } else if (title == '汛情处理') {
            _pushParameterWidgetPage(context,
                'http://117.159.24.4:30082/floodManage/index.html#/', title);
          } else if (title == '病害查看') {
            _pushParameterWidgetPage(context,
                'http://117.159.24.4:30082/deseaseList/index.html#/', title);
          } else {
            Navigator.pushNamed(context, widget.routeNames[title]);
          }
        } else {
          print('未查找到该路由$title');
        }
      },
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: icon,
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                title,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
        color: Colors.white,
      ),
    );
  }

  /// push出一个包含参数的widget
  _pushParameterWidgetPage(BuildContext context, String url, String title) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProcessExaminePage(url: url, title: title);
    }));
  }
}
