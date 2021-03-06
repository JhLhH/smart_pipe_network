import 'package:flutter/material.dart';
import 'package:smartpipenetwork/models/finished_task_model_entity_entity.dart';
import 'package:smartpipenetwork/models/task_network_query.dart';
import 'package:smartpipenetwork/models/undone_task_model_entity.dart';
import 'package:smartpipenetwork/workbench/disease_report_details.dart';
import 'package:smartpipenetwork/workbench/patrol_task_details.dart';
import 'package:smartpipenetwork/process_examine/process_exmine.dart';
import 'package:smartpipenetwork/base_commons/base_shared_preferences.dart';

/// 巡查任务
class PatrolTaskPage extends StatefulWidget {
  @override
  _PatrolTaskPageState createState() => _PatrolTaskPageState();
}

class _PatrolTaskPageState extends State<PatrolTaskPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> titleTabs;

  List<UndoneTaskModelResult> undoneDataSources;
  List<FinishedTaskModelEntityResult> finishedDataSources;

 Future _getTaskDataSources() async {
    UndoneTaskModelEntity tempUnDoneModel = await TaskNetWorkQuery.unDoneTask();
    FinishedTaskModelEntityEntity tempFinishedModel = await TaskNetWorkQuery.finishedTask();
    setState(() {
      if(undoneDataSources != null){
        undoneDataSources.clear();
      }if(finishedDataSources != null){
        finishedDataSources.clear();
      }
      undoneDataSources = tempUnDoneModel.result;
      finishedDataSources = tempFinishedModel.result;
      titleTabs = ['未完成(${undoneDataSources.length})', '已完成(${finishedDataSources.length})'];
      _tabController = TabController(length: 2, vsync: this);
    });
  }



  @override
  void initState() {
    super.initState();
    _getTaskDataSources();
    _getToken();

  }
  String tokenStr;

  _getToken() async {
    var tempToken = await ShardPreferences.localGet('token');
    setState(()  {
      tokenStr = tempToken;
    });
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
        _getUnfinishedWidget(context),
        _getFinishedWidget(context),
      ])
          : Center(
        child: Text('正在加载中...'),
      ),
    );
  }

  /// 未完成
  Widget _getUnfinishedWidget(BuildContext context) {
    return ListView.builder(
        itemCount: undoneDataSources != null ? undoneDataSources.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return _getUnFinishedWidgets(undoneDataSources[index]);
        });
  }

  /// 获取未完成每一个items
  Widget _getUnFinishedWidgets(UndoneTaskModelResult undoneTaskModelResult) {
    // 对返回数据做处理
    List<String> item = [
      undoneTaskModelResult.name,
      '周期：${undoneTaskModelResult.taskPeriod}',
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
        })).then((data){
            _getTaskDataSources();
        });
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
  _getFinishedWidget(BuildContext context) {
    return ListView.builder(
        itemCount: finishedDataSources != null ? finishedDataSources.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return _getFinishedWidgets(finishedDataSources[index]);
        });
  }

  /// 获取已完成每一个items
  Widget _getFinishedWidgets(FinishedTaskModelEntityResult model) {
    _getToken();

    List<String> item = [
      model.name,
      '周期：${model.taskPeriod}',
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
              _getFinishedRightButton(0, '轨迹查看', Icons.share,model.rummagerId),
//              Padding(
//                padding: EdgeInsets.only(top: 10),
//                child: _getFinishedRightButton(1, '病害详情', Icons.business),
//              ),
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
  _getFinishedRightButton(int index, String title, IconData icon,String idStr) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          _pushParameterWidgetPage(
              context, 'http://117.159.24.4:30445/roadMap/index.html?id=$idStr&status=0&token=$tokenStr#/', '轨迹查看');          // 轨迹查看
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
  /// push出一个包含参数的widget
  _pushParameterWidgetPage(BuildContext context, String url, String title) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProcessExaminePage(url: url, title: title);
    }));
  }
}
