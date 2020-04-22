import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartpipenetwork/customwidget/photos_gridview.dart';
/// 巡查任务未完成详情页面
class DiseaseReportPage extends StatefulWidget {
  // 导航栏标题传入
  final String taskNum;

  DiseaseReportPage({this.taskNum});

  @override
  _DiseaseReportPageState createState() => _DiseaseReportPageState();
}

class _DiseaseReportPageState extends State<DiseaseReportPage> {
  final List<String> prefixTitles = [
    '任务名称：',
    '巡查人员：',
    '发现时间：',
    '所属片区：',
    '巡查路段：',
    '病害种类：',
    '病害数量：',
    '病害位置：',
    '原因分析：',
    '整修措施：',
    '上传图片：'
  ];

  List<String> hintTexts = [
    '请输入巡查人员姓名',
    '请选择时间',
    '请选择所属片区',
    '请选择巡查路段',
    '请选择病害种类',
    '请输入病害数量',
    '点击图标可自动获取定位',
    '请输入原因',
    '请输入整修措施',
  ];

//  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    hintTexts.insert(0, widget.taskNum);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print('高度$height');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('病害上报'),
        centerTitle: true,
      ),
      body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child:  Stack(
            children: [
              Container(
                width: width,
                height: height,
                color: Colors.white,
              ),
              Positioned(
                  left: 0,right: 0,top: 0,bottom: 70,
                  child: Container(
                  child: ListView.builder(
                    itemCount: prefixTitles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _getListViewBuilderItems(context, index);
                    }),
              )),
              Positioned(
                  bottom: 0,
                  width: width,
                  height: 70,
                  child: Column(
                    children: [
                      Container(color: Colors.grey,height: 10,),
                      Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0),child: _getBottomWidget(context),)
                    ],
                  )
              )
            ],
          )),
    );
  }

  /// 获取底部按钮
  _getBottomWidget(BuildContext context){
    double width = MediaQuery.of(context).size.width;
    return  Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(onTap: (){

          },
            child: Container(
              height: 40,
              width: width/2-50,
              alignment: Alignment.center,
              child: Text('取消'),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,width: 1),
                  borderRadius: BorderRadius.circular(8)
              ),
            ),
          ),GestureDetector(onTap: (){

          },
            child: Container(
              height: 40,
              width: width/2-50,
              alignment: Alignment.center,
              child: Text('提交',style: TextStyle(color: Colors.white),),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(color: Colors.grey,width: 1),
                  borderRadius: BorderRadius.circular(8)
              ),
            ),
          ),
        ],
    );
  }

  _getListViewBuilderItems(BuildContext context, int index) {
    if (index == 10){
      return Column(
        children: [
          Container(padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          alignment: Alignment.centerLeft,
          child: Text(prefixTitles[index],),
          ),
          PhotosGridView(),
        ],
      );
    }
    return _getNormalListViewItem(context, index);
  }

  /// 获取每一行的widget
  _getNormalListViewItem(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: TextFormField(
        enabled: index == 0? false:true,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: hintTexts[index],
          prefixIcon: Container(
            width: 80,
            alignment: Alignment.center,
            child: Text(
              prefixTitles[index],
            ),
          ),
          suffixIcon: _getRightIconButton(context, index),
          enabledBorder: new UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: new UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return hintTexts[index];
          }
          return null;
        },
      ),
    );
  }

  /// 右侧按钮
  _getRightIconButton(BuildContext context, int index) {
    if (index == 0 || index == 1 || index == 6 || index == 8 || index == 9) {
      return Text('');
    } else if (index == 7) {
      // 定位
      return IconButton(
          icon: Icon(
            Icons.room,
            color: Colors.blue,
          ),
          onPressed: () {
            // 定位按钮
          });
    } else {
      return IconButton(
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey,
          ),
          onPressed: () {
            // 下拉框根据index来判断是哪一个
          });
    }
  }
}
