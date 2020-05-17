import 'package:amap_location/amap_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smartpipenetwork/models/disease_report_network_query.dart';
import 'package:smartpipenetwork/models/disease_way_model_entity_entity.dart';
import 'package:smartpipenetwork/models/undone_task_model_entity.dart';
import 'disease_report.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tableview/tableview.dart';
import 'package:smartpipenetwork/base_commons/base_network.dart';

/// 巡查任务未完成详情页面
class PatrolTaskDetailsPage extends StatefulWidget {
  // 导航栏标题传入
  final UndoneTaskModelResult modelResult;

  PatrolTaskDetailsPage({@required this.modelResult});

  @override
  _PatrolTaskDetailsPageState createState() => _PatrolTaskDetailsPageState();
}

class _PatrolTaskDetailsPageState extends State<PatrolTaskDetailsPage> {
  List<String> items;
  bool _isTapStart = false; // 控制按钮颜色和文字变化
  String startTitle;
  String startTime;

  String wyaName = '';
  String locationString;

  /// 获取道路名字
  _getDiseaseWayModel() async {
    DiseaseWayModelEntityEntity tempModel = await DiseaseReportNetWorkQuery.diseaseWay(widget.modelResult.id);
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 判断状态显示标题
    if (widget.modelResult.status == 0) {
      startTitle = '开始巡查';
    } else if (widget.modelResult.status == 2) {
      startTitle = '正在巡查';
    } else if (widget.modelResult.status == 3) {
      startTitle = '暂停中';
    }
    items = [
      '任务名称：${widget.modelResult.plantName}',
      '周期：${widget.modelResult.taskPeriod}',
      '起始时间：${widget.modelResult.startTime} 至 ${widget.modelResult.endTime}',
      '安排时间：${widget.modelResult.generateTime}',
      '任务状态：$startTitle',
//      '备注：无',
      '巡查路径'
    ];
//    _getDiseaseWayModel();
//    _postLocation();
  }

  Future _postLocation()async{
    String location = await _getLocation();
    await DiseaseReportNetWorkQuery.submitLocationPoint(params: {'refTaskId':widget.modelResult.id,'coordinate':location});
  }

  Future<String> _getLocation() async {
    //先启动一下
    await AMapLocationClient.startup(new AMapLocationOption(
        desiredAccuracy: CLLocationAccuracy.kCLLocationAccuracyHundredMeters));
    //直接获取定位
    AMapLocation location = await AMapLocationClient.getLocation(true);
    if (location != null) {
      return '${location.longitude},${location.latitude}';
    }
    return null;
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
//    _getDiseaseWayModel();
  _postLocation();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.modelResult.name),
          centerTitle: true,
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context, '');
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
        if (startTitle == '正在巡查') {
          // 病害上报路由跳转DiseaseReportPage中需要先声明变量taskNum
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return DiseaseReportPage(
              plantId: widget.modelResult.plantId,
              wyaName: wyaName,
            );
          }));
        }
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
            color: startTitle == '正在巡查' ? Colors.blue : Colors.grey,
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  /// 获取cell
  _getCell(BuildContext context, int row) {
    if (row == items.length - 1) {
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
      return _getBodyText(items[row],
          color: row == 1 ? Colors.black : Colors.grey);
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
          _getStartButton(context),
          _getEndButton(context),
        ],
      ),
    );
  }

  /// 获取顶部的单个按钮
  ///
  /// index 0代表开始巡查 1代表完成结束按钮
  /// text 需要展示的文字
  /// color 背景颜色
  _getStartButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: GestureDetector(
        onTap: () async {
          setState(() {
            _isTapStart = !_isTapStart;
            if (startTitle == '开始巡查') {
              startTitle = '正在巡查';
            } else if (startTitle == '正在巡查') {
              startTitle = '暂停中';
            } else if (startTitle == '暂停中') {
              startTitle = '正在巡查';
            }
          });
          bool isSuccess = await HTTPQuerery.startOrEnd(
              widget.modelResult.id, {'status': _getStatues()});
        },
        child: Container(
          width: 100,
          height: 40,
          child: Text(
            startTitle,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: startTitle == '正在巡查' ? Colors.grey : Colors.lightBlue,
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  _getStatues() {
    if (startTitle == '正在巡查') {
      return 2;
    }
    if (startTitle == '暂停中') {
      return 3;
    } else {
      return 0;
    }
  }

  _getEndButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: GestureDetector(
        onTap: () async {
          bool isSuccess = await HTTPQuerery.startOrEnd(
              widget.modelResult.id, {'status': 1});
          if (isSuccess) {
            Navigator.pop(context);
          }
        },
        child: Container(
          width: 100,
          height: 40,
          child: Text(
            '完成结束',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.red,
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
