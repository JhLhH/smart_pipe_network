
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smartpipenetwork/customwidget/photos_gridview.dart';
/// 巡查任务未完成详情页面
class DiseaseReportPage extends StatefulWidget {
  // 导航栏标题传入上个界面传入
  final String taskNum;
  // 构造方法必须写，在_DiseaseReportPageState中使用方式widget.taskNum
  DiseaseReportPage({this.taskNum});

  @override
  _DiseaseReportPageState createState() => _DiseaseReportPageState();
}

class _DiseaseReportPageState extends State<DiseaseReportPage> {
  /// 病害上报输入框左侧固定文字
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

  /// 占位文字
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
    '',
  ];
  /// 新增病害存放记录输入框文字内容
  Map<String,TextEditingController> controllerMaps= {
    '请输入巡查人员姓名':TextEditingController(),
    '请选择时间':TextEditingController(),
    '请选择所属片区':TextEditingController(),
    '请选择巡查路段':TextEditingController(),
    '请选择病害种类':TextEditingController(),
    '请输入病害数量':TextEditingController(),
    '点击图标可自动获取定位':TextEditingController(),
    '请输入原因':TextEditingController(),
    '请输入整修措施':TextEditingController(),
  };

  /// 新增病害输入框左侧固定文字
  final List<String> newPrefixTitles = [
    '病害种类：',
    '病害数量：',
    '病害位置：',
    '原因分析：',
    '整修措施：',
    '上传图片：'
  ];
  /// 新增病害对应输入框占位文字
  List<String> newHintTexts = [
    '请选择病害种类',
    '请输入病害数量',
    '点击图标可自动获取定位',
    '请输入原因',
    '请输入整修措施',
    '',
  ];

  Map<String,TextEditingController> newControllerMaps= {
    '请选择病害种类':TextEditingController(),
    '请输入病害数量':TextEditingController(),
    '点击图标可自动获取定位':TextEditingController(),
    '请输入原因':TextEditingController(),
    '请输入整修措施':TextEditingController(),
  };

  // 统一验证输入框内容
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // 获取选择得到的照片
  final GlobalKey<PhotosGridViewState> _photoKey = GlobalKey<PhotosGridViewState>();
  bool _isAdd = false;

  _createData(){
    TextEditingController controller = TextEditingController();
    controller.text = widget.taskNum;
    controllerMaps.addAll({'任务名称':controller});
    hintTexts.insert(0, widget.taskNum);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    _createData();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('病害上报'),
        centerTitle: true,
        leading: BackButton(
          onPressed: (){
            Navigator.pop(context);
          },
        ),
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
                  child: Form(
                    key: _formKey,
                    child: ListView.builder(
                        itemCount: _isAdd ? 17 :12,
                        itemBuilder: (BuildContext context, int index) {
                          return _getListViewBuilderItems(context, index);
                        }),
                  ),
              )
              ),
              Positioned (
                  bottom: 0,
                  width: width,
                  height: 90,
                  child: Column(
                    children: [
                      Container(color: Color(0xffF0EEF9),height: 10,),
                      Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0),child: _getBottomWidget(context),)
                    ],
                  )
              )
            ],
          )),
    );
  }


  /// 没有点击新增的样式
  _normalListBuilderItems(BuildContext context, int index){
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
    }if(index == 11){
      return GestureDetector(
          onTap: (){
            setState(() {
              _isAdd = true;
            });
          },
          child:Column(
            children: [
              Container(
                height: 70,
                alignment: Alignment.center,
                child:  Text('新增病害', style: TextStyle(color: Colors.blue,fontSize: 18),),
              ),
              Container(
                height: 1,
                color: Color(0xffF0EEF9),
              )
            ],
          )
      );
    }
    String hintText = hintTexts[index];
    String prefixText = prefixTitles[index];
    TextEditingController controller = controllerMaps[hintText];
    return _getNormalListViewItem(context, index, controller, hintText, prefixText);
  }

  /// 点击了新增的样式
  _addListBuilderItems(BuildContext context, int index){
    if(index < 11){
      String hintText = hintTexts[index];
      String prefixText = prefixTitles[index];
      TextEditingController controller = controllerMaps[hintText];
      if (index == 10){
        return Column(
          children: [
            Container(padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              alignment: Alignment.centerLeft,
              child: Text(prefixText,),
            ),
            PhotosGridView(),
          ],
        );
      }
      return _getNormalListViewItem(context, index, controller, hintText, prefixText);
    }
    else{
      String hintText = newHintTexts[index-11];
      String prefixText = newPrefixTitles[index-11];
      TextEditingController controller = newControllerMaps[hintText];
      if (index == 16){
        return Column(
          children: [
            Container(padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              alignment: Alignment.centerLeft,
              child: Text(prefixText,),
            ),
            PhotosGridView(),
          ],
        );
      }
      return _getNormalListViewItem(context, index, controller, hintText, prefixText);
    }
  }

  /// 获取ListView
  _getListViewBuilderItems(BuildContext context, int index) {
    if(!_isAdd){
     return _normalListBuilderItems(context, index);
    }else{
     return _addListBuilderItems(context, index);
    }

  }

  /// 获取底部按钮
  _getBottomWidget(BuildContext context){
    return  GestureDetector(onTap: (){
      // 统一校验
      if(_formKey.currentState.validate()){
        // 校验通过后可以遍历controllerMaps中的value，
        // 他的值是controller中的text就是存放的目标字符串
        // _photoKey.currentState.images存放选择的图片
        if(_photoKey.currentState.images.isEmpty){
          Fluttertoast.showToast(msg: '缺少图片');
        }
      }
    },
      child: Container(
        height: 49,
        margin: EdgeInsets.only(left: 10,right: 10),
        alignment: Alignment.center,
        child: Text('提交',style: TextStyle(color: Colors.white),),
        decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(color: Colors.grey,width: 1),
            borderRadius: BorderRadius.circular(8)
        ),
      ),
    );
  }


  /// 控制哪一个输入框可以输入
 bool _getNormalListViewItemEnabled(int index){
    if(index == 0 ||index == 2 ||index == 3 ||index == 4 ||index == 5 || index == 7 || index == 13){
      return false;
    }
    return true;
  }

  /// 获取每一行的widget
  _getNormalListViewItem(BuildContext context, int index,TextEditingController controller,
      String hintText, String prefixText) {
      return Stack(
        alignment: Alignment.center ,
        children: [
          _getTextFieldItem(context, index, controller, hintText, prefixText),
          Positioned(
            right: 5,
            child: Center(child: _getRightIconButton(context, index),),)
        ],
      );
  }

  /// 获取输入框组件
  _getTextFieldItem(BuildContext context , int index,TextEditingController controller,
      String hintText, String prefixText){
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: TextFormField(
        controller: controller,
        enabled: _getNormalListViewItemEnabled(index),
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Container(
            width: 80,
            alignment: Alignment.center,
            child: Text(
              prefixText,
            ),
          ),
          suffixIcon: Text(''),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffF0EEF9)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffF0EEF9)),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffF0EEF9)),
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return hintText;
          }
          return null;
        },
        onChanged: (value){
        },
        onTap: (){
          print('点击了第$index个输入框');

        },
      ),
    );
  }

  /// 右侧按钮
  _getRightIconButton(BuildContext context, int index) {
    if(index == 2 || index == 3 || index == 4 || index == 5){
      List<String> listData = ['选择1','选择2','选择3','选择4','选择5','选择6','选择7'];
      return DropdownButtonHideUnderline(
        child: DropdownButton(
          // 这里选择菜单的下拉框内容根据index传入对应的内容需要一个数组listData
          items: dropdownItems(listData),
          onChanged: (value){
            // 按钮菜单选择回调
            print('点击了$value');
            setState(() {
              controllerMaps[hintTexts[index]].text = value;
            });
            // 需要显示在对应的输入框中显示选择的内容
          },
        ),
      );
    } else if (index == 7 || index == 13) {
      // 定位
      return IconButton(
          icon: Icon(
            Icons.room,
            color: Colors.blue,
          ),
          onPressed: () {
            // 定位按钮
            setState(() {
              controllerMaps[hintTexts[index]].text = '坐标位置定位';
            });
          });
    } else{
      return Text('');
    }
  }

  dropdownItems(List dropdownData) {
    List<DropdownMenuItem<String>> list = new List();
    dropdownData.forEach((value) {
      list.add(
        new DropdownMenuItem(
            child: new Container(
              color: Colors.white,
              child: new Text(value, style: TextStyle(color: Colors.black),),
            ), value: value
        ),
      );
    });
    return list;
  }

}


