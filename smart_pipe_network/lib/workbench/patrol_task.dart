import 'package:flutter/material.dart';
import 'package:smartpipenetwork/models/finished_task_model_entity_entity.dart';
import 'package:smartpipenetwork/models/task_network_query.dart';
import 'package:smartpipenetwork/models/undone_task_model_entity.dart';
import 'package:smartpipenetwork/workbench/disease_report_details.dart';
import 'package:smartpipenetwork/workbench/patrol_task_details.dart';

/// 巡查任务
class PatrolTaskPage extends StatefulWidget {
  @override
  _PatrolTaskPageState createState() => _PatrolTaskPageState();
}

class _PatrolTaskPageState extends State<PatrolTaskPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  UndoneTaskModelEntity undoneModel;

  FinishedTaskModelEntityEntity finishedModel;

  _getTaskDataSources() async {
    var tempUnDoneModel = await TaskNetWorkQuery.unDoneTask();
    var tempFinishedModel = await TaskNetWorkQuery.finishedTask();
    setState(() {
      undoneModel = tempUnDoneModel;
      finishedModel = tempFinishedModel;
      titleTabs = ['未完成(${undoneModel.result.length})', '已完成'];
      _tabController = TabController(length: 2, vsync: this);
    });
  }

  List<String> titleTabs;

  @override
  void initState() {
    super.initState();
    _getTaskDataSources();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf7f7f7),
      appBar: AppBar(
        title: Text('巡查任务'),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: titleTabs != null
            ? TabBar(
                tabs: titleTabs.map((text) => Tab(text: text)).toList(),
                controller: _tabController,
              )
            : null,
      ),
      body: titleTabs != null
          ? TabBarView(controller: _tabController, children: <Widget>[
              _getUnfinishedWidget(),
              _getFinishedWidget(),
            ])
          : Center(
              child: Text('正在加载中...'),
            ),
    );
  }

  /// 未完成
  Widget _getUnfinishedWidget() {
    return ListView.builder(
        itemCount: undoneModel != null ? undoneModel.result.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return _getUnFinishedWidgets(undoneModel.result[index]);
        });
  }

  /// 获取未完成每一个items
  Widget _getUnFinishedWidgets(UndoneTaskModelResult undoneTaskModelResult) {
    // 对返回数据做处理
    List<String> item = [
      undoneTaskModelResult.plantName,
      '周期：无',
      '起始时间：${undoneTaskModelResult.startTime}至${undoneTaskModelResult.endTime}',
      '安排时间：${undoneTaskModelResult.generateTime}',
      '备注:${undoneTaskModelResult.memo}'
    ];
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return PatrolTaskDetailsPage(
            modelResult: undoneTaskModelResult,
            // 传入id
          );
        }));
      },
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          // 左侧的纯文字
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: item
                      .map((text) => Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.fromLTRB(10, 5, 25, 5),
                            child: Text(
                              text,
                              textAlign: TextAlign.left,
                            ),
                          ))
                      .toList(),
                ),
              )
            ],
          ),
          // 右侧图标
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 20,
            ),
          )
        ],
      ),
    );
  }

  /// 已完成界面的widget获取
  _getFinishedWidget() {
    return ListView.builder(
        itemCount: finishedModel != null ? finishedModel.result.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return _getFinishedWidgets(finishedModel.result[index]);
        });
  }

  /// 获取已完成每一个items
  Widget _getFinishedWidgets(FinishedTaskModelEntityResult model) {
    List<String> item = [
      model.plantName,
      '周期：无',
      '起始时间：${model.startTime}至${model.endTime}',
      '生成时间：${model.generateTime}',
      '结束时间:${model.endTime}'
    ];
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        // 左侧的纯文字
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: item
                    .map((text) => Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.fromLTRB(10, 5, 30, 5),
                          child: Text(
                            text,
                            textAlign: TextAlign.left,
                          ),
                        ))
                    .toList(),
              ),
            )
          ],
        ),
        // 右侧图标
        Container(
          margin: EdgeInsets.only(right: 20),
          child: Column(
            children: [
              _getFinishedRightButton(0, '轨迹查看', Icons.share),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: _getFinishedRightButton(1, '病害详情', Icons.business),
              ),
            ],
          ),
        )
      ],
    );
  }

  /// 获取已完成界面右侧的按钮
  ///
  /// index 点击的标识判断 0标识轨迹查看 1病害详情
  /// title 按钮标题
  /// icon图标
  /// 后续可能需要传入一个点击到下个页面请求用到的参数，参数名和类型目前无法确定
  _getFinishedRightButton(int index, String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          // 轨迹查看
        } else if (index == 1) {
          // 病害详情
//          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//            return DiseaseDetailsPage(
//              diseaseId: finishedModel.result[index].id,
//            );
//          }));
        }
      },
      child: Column(
        children: [Icon(icon), Text(title)],
      ),
    );
  }
}
