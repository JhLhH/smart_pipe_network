import 'package:flutter/material.dart';

/// 巡查任务
class PatrolTaskPage extends StatefulWidget {
  @override
  _PatrolTaskPageState createState() => _PatrolTaskPageState();
}

class _PatrolTaskPageState extends State<PatrolTaskPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  /// 未完成任务数据源
  List unFinishedData = [
    [
      '2020.02.11巢湖路至护航路（含护航路)巡查）',
      '周期：1周/次',
      '起始时间：2019-05-11 至 2019-12-30',
      '安排时间：2019-05-10 09:30',
      '备注：需反馈'
    ],
    [
      '2020.02.11巢湖路至护航路（含护航路)巡查）',
      '周期：1周/次',
      '起始时间：2019-05-11 至 2019-12-30',
      '安排时间：2019-05-10 09:30',
      '备注：需反馈'
    ],
    [
      '2020.02.11巢湖路至护航路（含护航路)巡查）',
      '周期：1周/次',
      '起始时间：2019-05-11 至 2019-12-30',
      '安排时间：2019-05-10 09:30',
      '备注：需反馈'
    ],
    [
      '2020.02.11巢湖路至护航路（含护航路)巡查）',
      '周期：1周/次',
      '起始时间：2019-05-11 至 2019-12-30',
      '安排时间：2019-05-10 09:30',
      '备注：需反馈'
    ],
    [
      '2020.02.11巢湖路至护航路（含护航路)巡查）',
      '周期：1周/次',
      '起始时间：2019-05-11 至 2019-12-30',
      '安排时间：2019-05-10 09:30',
      '备注：需反馈'
    ],
  ];

  /// 未完成任务数据源
  List finishedData = [
    [
      '任务名称：2020.02.11巢湖路至护航路（含护航路)巡查）2020.02.11巢湖路至护航路（含护航路)巡查）',
      '周期：1周/次',
      '起始时间：2019-05-11 至 2019-12-30',
      '生成时间：2019-05-10 09:30',
      '结束时间：2020-02-11 11：30'
    ],
    [
      '任务名称：2020.02.11巢湖路至护航路（含护航路)巡查）',
      '周期：1周/次',
      '起始时间：2019-05-11 至 2019-12-30',
      '生成时间：2019-05-10 09:30',
      '结束时间：2020-02-11 11：30'
    ],
    [
      '任务名称：2020.02.11巢湖路至护航路（含护航路)巡查）',
      '周期：1周/次',
      '起始时间：2019-05-11 至 2019-12-30',
      '生成时间：2019-05-10 09:30',
      '结束时间：2020-02-11 11：30'
    ],
    [
      '任务名称：2020.02.11巢湖路至护航路（含护航路)巡查）',
      '周期：1周/次',
      '起始时间：2019-05-11 至 2019-12-30',
      '生成时间：2019-05-10 09:30',
      '结束时间：2020-02-11 11：30'
    ],
    [
      '任务名称：2020.02.11巢湖路至护航路（含护航路)巡查）',
      '周期：1周/次',
      '起始时间：2019-05-11 至 2019-12-30',
      '生成时间：2019-05-10 09:30',
      '结束时间：2020-02-11 11：30'
    ],
  ];

  List<String> titleTabs = ['已完成'];

  @override
  void initState() {
    super.initState();
    titleTabs.insert(0, '未完成${unFinishedData.length}');
    _tabController = TabController(length: titleTabs.length, vsync: this);
    // 根据数据源来确定tab上的数字
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
        bottom: TabBar(
          tabs: titleTabs.map((text) => Tab(text: text)).toList(),
          controller: _tabController,
        ),
      ),
      body: TabBarView(controller: _tabController, children: <Widget>[
        _getUnfinishedWidget(),
        _getFinishedWidget(),
      ]),
    );
  }

  /// 未完成
  Widget _getUnfinishedWidget() {
    return ListView.builder(
        itemCount: unFinishedData.length,
        itemBuilder: (BuildContext context, int index) {
          return _getUnFinishedWidgets(unFinishedData[index]);
        });
  }

  /// 获取未完成每一个items
  Widget _getUnFinishedWidgets(List item) {
    return GestureDetector(
      onTap: () {
        // TODO: implement tap push otherWidget
        print('进如详情页面');
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
        itemCount: unFinishedData.length,
        itemBuilder: (BuildContext context, int index) {
          return _getFinishedWidgets(finishedData[index]);
        });
  }

  /// 获取已完成每一个items
  Widget _getFinishedWidgets(List item) {
    return GestureDetector(
      onTap: () {
        // TODO: implement tap push otherWidget
        print('进如详情页面');
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
      ),
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
        }
      },
      child: Column(
        children: [Icon(icon), Text(title)],
      ),
    );
  }
}
