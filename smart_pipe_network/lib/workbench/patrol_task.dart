import 'package:flutter/material.dart';

//import 'package:smartpipenetwork/customview/unfinished.dart';
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

  List<String> titleTabs = ['未完成（5）', '已完成'];

  @override
  void initState() {
    super.initState();
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
        Center(
          child: Text('未完成'),
        ),
      ]),
    );
  }

  Widget _getUnfinishedWidget() {
    return ListView.builder(
        itemCount: unFinishedData.length,
        itemBuilder: (BuildContext context, int index) {
          return _getUnFinishedWidgets(unFinishedData[index]);
        });
  }

  /// 获取每一个items
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
// 添加阴影暂时用不到
//                  boxShadow: [BoxShadow(color: Color(0xFFf7f7f7),
//                      offset: Offset(5.0, 5.0),
//                      blurRadius: 10.0, spreadRadius: 2.0),
//                    BoxShadow(color: Color(0xFFf7f7f7), offset: Offset(1.0, 1.0)),
//                    BoxShadow(color: Color(0xFFf7f7f7))],
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
}
