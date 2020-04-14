import 'package:flutter/material.dart';

/// 巡查任务未完成详情页面
class PatrolTaskDetailsPage extends StatefulWidget {
  final String title;

  PatrolTaskDetailsPage({this.title});

  @override
  _PatrolTaskDetailsPageState createState() => _PatrolTaskDetailsPageState();
}

class _PatrolTaskDetailsPageState extends State<PatrolTaskDetailsPage> {

   bool _isTapStart = false;
   bool _isTapEnd = false;
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

  _getListItemBuilder(int index){
    if (index == 0){
      return _getTopWidget();
    }
    return Center(child: Text('暂无数据'),);
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

}
