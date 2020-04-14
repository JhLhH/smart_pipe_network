import 'package:flutter/material.dart';

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
      '任务名称：2020.02.11巢湖路至护航路（含护航路）巡查',
      '周期：1周/次',
      '起始时间：2019-05-11 至 2019-12-30',
      '安排时间：2019-05-10 09:30',
      '派发人：李书长',
      '任务状态：进行中',
      '备注：无'
    ];
   bool _isTapStart = false;// 控制按钮颜色和文字变化
   bool _isTapEnd = false; // 控制按钮颜色和文字变化
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index){
        return _getListItemBuilder(index);
      }),
    );
  }

  /// 获取listView的每一个item
  _getListItemBuilder(int index){
    if (index == 0){
      // 顶部按钮
      return _getTopWidget();
    }else if(index == 1){
      // 中间的内容
      return _getBodyWidget();
    }
    // 点击按钮
    return GestureDetector(
        onTap: (){
          // 病害上报
          print('病害上报点击');
        },
      child: Container(
        margin: EdgeInsets.only(left: 20,right: 20,top: 40),
        height: 49,
        alignment: Alignment.center,
        child: Text('病害上报',style: TextStyle(color: Colors.white,fontSize: 18, fontWeight: FontWeight.w500),),
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.circular(24.5),
        ),
      ),
    );
  }

  /// 获取顶部两个按钮组件
  _getTopWidget(){
    return Container(
      child: Row(
        children: [
          _getTopButton(0, _isTapStart ? '正在巡查':'开始巡查', _isTapStart ? Colors.lightBlueAccent : Colors.greenAccent),
          _getTopButton(1, _isTapEnd ? '已完成':'完成结束', _isTapEnd ? Colors.grey : Colors.redAccent),
        ],
      ),
    );
  }

   /// 获取顶部的单个按钮
   ///
   /// index 0代表开始巡查 1代表完成结束按钮
   /// text 需要展示的文字
   /// color 背景颜色
  _getTopButton(int index ,String text, Color color){
    return Container(
      padding: EdgeInsets.all(50),
      child: GestureDetector(
        onTap: (){
          setState(() {
            if(index == 0){
              _isTapStart = !_isTapStart;
            }else if(index == 1){
              _isTapEnd = !_isTapEnd;
            }
          });
        },
        child: Container(
          width: 100,
          height: 100,
          child: Text(text,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: color,
              border: Border.all(color: Colors.white,width: 1),
              borderRadius: BorderRadius.circular(50)
          ),
        ),
      ),
    );
  }


  /// 中间body内容
  _getBodyWidget(){
    return  Column(
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
            children: _getBodyDetails(),
          ),
        )
      ],
    );
  }

  /// 返回一个组件数组中间的body使用column布局这里返回职位children需要的[widget]
  _getBodyDetails(){
    List<Widget> widgetItems = [];
    items.forEach((text) {
      // 统一添加样式一致的text
      widgetItems.add(_getBodyText(text));
    });

    // 插入到第一位置一个灰色文字
    widgetItems.insert(0, _getBodyText('任务编号：RW20191102001',color: Colors.grey));

    // 插入最后一行的可点击文字
    widgetItems.add(
      GestureDetector(
        onTap: (){
          print('巡查路径点击');
        },
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(10, 5, 30, 5),
          child: Text(
            '巡查路径',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.blue
            ),
          ),
        ),
      )
    );
    return widgetItems;
  }

  /// 中间body每一行文字
  _getBodyText(String text,{Color color = Colors.black}){
   return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 5, 30, 5),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: color
        ),
      ),
    );
  }

}