import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tableview/tableview.dart';

import 'disease_report.dart';

/// 巡查任务未完成详情页面
class PatrolTaskDetailsPage extends StatefulWidget {
  // 导航栏标题传入
  final String title;

  PatrolTaskDetailsPage({this.title});

  @override
  _PatrolTaskDetailsPageState createState() => _PatrolTaskDetailsPageState();
}

class _PatrolTaskDetailsPageState extends State<PatrolTaskDetailsPage> {
  final List<String> items = [
    '任务编号：RW202000414001',
    '任务名称：2020.02.11巢湖路至护航路（含护航路）巡查',
    '周期：1周/次',
    '起始时间：2019-05-11 至 2019-12-30',
    '安排时间：2019-05-10 09:30',
    '派发人：李书长',
    '任务状态：进行中',
    '备注：无',
    '巡查路径'
  ];
  bool _isTapStart = false; // 控制按钮颜色和文字变化
  bool _isTapEnd = false; // 控制按钮颜色和文字变化
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Stack(
          children: [
            Container(
              width: width,
              height: height,
              color: Colors.white,
            ),
            TableView(
              tableHeaderView: _getHeaderView(context),
              sectionNumber: 1,
              numberRowOfSection: (BuildContext context, int index) {
                return items.length;
              },
              rowView: (BuildContext context, int section, int row) {
                return _getCell(context, row);
              },
              sectionHeaderView: (BuildContext context, int index) {
                return Container(
                  height: 10,
                  color: Color(0xffF0EEF9),
                );
              },
            ),
            Positioned(
                bottom: bottomPadding,
                width: width,
                height: 69,
                child: Column(
                  children: [
                    Container(
                      height: 10,
                      color: Color(0xffF0EEF9),
                    ),
                    _getBottomButton(context)
                  ],
                ))
          ],
        ));
  }

  /// 底部按钮点击
  _getBottomButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 病害上报路由跳转DiseaseReportPage中需要先声明变量taskNum
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return DiseaseReportPage(
            taskNum: 'RW20191102001',
          );
        }));
      },
      child: Container(
        height: 49,
        margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        alignment: Alignment.center,
        child: Text(
          '病害上报',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  /// 获取cell
  _getCell(BuildContext context, int row) {
    if (row == items.length-1) {
      // 最后一个放置按钮
      return GestureDetector(
        onTap: () {
          print('巡查路径点击');
          Fluttertoast.showToast(msg: '巡查路径点击');
        },
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(10, 5, 30, 5),
          child: Text(
            '巡查路径',
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.blue),
          ),
        ),
      );
    } else {
      return _getBodyText(items[row],color: row == 1? Colors.black:Colors.grey);
    }
  }

  /// 获取顶部两个按钮组件
  _getHeaderView(BuildContext context) {
    return Container(
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _getTopButton(
              0,
              _isTapStart ? '正在巡查' : '开始巡查',
              _isTapStart ? Colors.green : Colors.lightBlue,
              context),
          _getTopButton(1, _isTapEnd ? '已完成' : '完成结束',
              _isTapEnd ? Colors.grey : Colors.red, context),
        ],
      ),
    );
  }

  /// 获取顶部的单个按钮
  ///
  /// index 0代表开始巡查 1代表完成结束按钮
  /// text 需要展示的文字
  /// color 背景颜色
  _getTopButton(int index, String text, Color color, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (index == 0) {
              _isTapStart = !_isTapStart;
            } else if (index == 1) {
              _isTapEnd = !_isTapEnd;
            }
          });
        },
        child: Container(
          width: 100,
          height: 40,
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: color,
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  /// 中间body每一行文字
  _getBodyText(String text, {Color color = Colors.black}) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 5, 30, 5),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(color: color),
      ),
    );
  }
}
