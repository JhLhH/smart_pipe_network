import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tableview/tableview.dart';
import 'package:smartpipenetwork/customwidget/custom_textfield.dart';
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
  /// 头部数据
  final List<String> headerPrefixTitles = [
    '任务名称：',
    '巡查人员：',
    '发现时间：',
    '所属片区：',
    '巡查路段：'
  ];

  /// 头部数据
  List<String> headerHintTexts = [
    '请输入巡查人员姓名',
    '请选择时间',
    '请选择所属片区',
    '请选择巡查路段',
  ];

  /// 病害上报输入框左侧固定文字
  final List<String> prefixTitles = [
    '病害种类：',
    '病害数量：',
    '病害位置：',
    '原因分析：',
    '整修措施：',
    '上传图片：'
  ];

  /// 占位文字
  List<String> hintTexts = [
    '请选择病害种类',
    '请输入病害数量',
    '点击图标可自动获取定位',
    '请输入原因',
    '请输入整修措施',
    '',
  ];

  // 统一验证输入框内容
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // 获取选择得到的照片
  final GlobalKey<PhotosGridViewState> _photoKey =
  GlobalKey<PhotosGridViewState>();
  int _sectionCount = 1;



  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    if(headerHintTexts[0] != widget.taskNum){
      headerHintTexts.insert(0, widget.taskNum);
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('病害上报'),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Stack(
            children: [
              Container(
                width: width,
                height: height,
                color: Colors.white,
              ),
              _getBodyContentWidget(),
              Positioned(
                  bottom: bottomPadding,
                  width: width,
                  height: 59,
                  child: _getBottomWidget(context))
            ],
          )),
    );
  }

  /// 获取内容主题的listView
  _getBodyContentWidget() {
    return Positioned(
        left: 0,
        right: 0,
        top: 0,
        bottom: 60,
        child: Container(
          child: Form(
            key: _formKey,
            child: TableView(
              tableHeaderView: _getHeaderView(context),
              tableFooterView: _getFootView(),
              sectionNumber: _sectionCount,
              numberRowOfSection: (BuildContext context, int index) {
                return prefixTitles.length;
              },
              rowView: (BuildContext context, int section, int row) {
                return cell(context, section, row);
              },
              sectionHeaderView: (BuildContext context, int index) {
                return Container(
                  height: 10,
                  color: Color(0xffF0EEF9),
                );
              },
            ),
          ),
        ));
  }

  /// 获取底部按钮
  _getBottomWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 统一校验
        if (_formKey.currentState.validate()) {
          // 校验通过后可以遍历controllerMaps中的value，
          // 他的值是controller中的text就是存放的目标字符串
          // _photoKey.currentState.images存放选择的图片
          if (_photoKey.currentState.images.isEmpty) {
            Fluttertoast.showToast(msg: '缺少图片');
          }
        }
      },
      child: Container(
        height: 49,
        margin: EdgeInsets.only(left: 10, right: 10,top: 5,bottom: 5),
        alignment: Alignment.center,
        child: Text(
          '提交',
          style: TextStyle(color: Colors.white,fontSize: 18),
        ),
        decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  /// 获取cell
  Widget cell(BuildContext context, int section, int row) {
    return row == 5
        ? _getAddPhotoWidget()
        : CustomTextField(
      hintText: hintTexts[row],
      prefixText: prefixTitles[row],
      suffixIconStyle: _getSuffixIconStyle(row),
      onChanged: (value) {
        print('第$section组第$row行输入$value');
      },
    );
  }

  /// 获取输入框的样式
  _getSuffixIconStyle(int row) {
    if (row == 0) {
      return SuffixIconStyle.dropdown;
    }
    if (row == 2) {
      return SuffixIconStyle.location;
    }
    return SuffixIconStyle.normal;
  }

  /// 获取上传图片的widget
  _getAddPhotoWidget() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          alignment: Alignment.centerLeft,
          child: Text(
            "上传图片",
          ),
        ),
        PhotosGridView(),
      ],
    );
  }

  /// 获取tableView的头部视图
  _getHeaderView(BuildContext context) {
    return Column(
      children: _headerCell(context),
    );
  }

  /// 获取HeaderCell
  _headerCell(BuildContext context) {
    List<Widget> items = [];
    for(int i = 0; i < headerPrefixTitles.length;i++){
      items.add( CustomTextField(
        hintText: headerHintTexts[i],
        prefixText: headerPrefixTitles[i],
        suffixIconStyle: _getHeaderSuffixIconStyle(i),
        onChanged: (value) {
          print('TableViewHeader第$i行输入$value');
        },
      ));
    }
    return items;
  }

  /// 获取输入框的样式
  _getHeaderSuffixIconStyle(int row) {
    if (row == 0 || row == 1) {
      return SuffixIconStyle.normal;
    }
    return SuffixIconStyle.dropdown;
  }

  _getFootView() {
    return InkWell(
      onTap: () {
        setState(() {
          _sectionCount++;
        });
      },
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 49,
            child: Text(
              '新增病害',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18
              ),
            ),
          ),
          Container(
            height: 1,
            color: Color(0xffF0EEF9),
          )
        ],
      ),
    );
  }
}
