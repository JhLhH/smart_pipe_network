import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smartpipenetwork/base_commons/base_network.dart';
import 'package:smartpipenetwork/models/disease_report_network_query.dart';
import 'package:smartpipenetwork/models/disease_way_model_entity_entity.dart';
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
  final List<String> headerPrefixTitles = ['发现时间：', '巡查路段：'];

  /// 病害id
  String _diseaseId;

  DiseaseWayModelEntityEntity model;
  List<String> ways = [];
  List<String> diseaseType = [
    '沥青路面破损、缺失（m²）',
    '沥青路面裂痕（m）',
    '小便石破损、缺失（m²）',
    '侧石破损、缺失（块）',
    '平石破损、缺失（块）',
    '人行道砖破损、缺失（m²）',
    '盲道砖破损、缺失（m²）',
    '雨污水井井盖病害（套）',
    '雨水收水井周病害（处）',
    '检查井缺销子（个）',
    '检查井防坠网（套）'
  ];

  Map<String, String> inputHeaderValueMaps = {};

  /// 分组
  Map<int, Map<String, String>> sectionMaps = {};
  Map<int, Map<String, List<String>>> sectionImgMaps = {};

  _getDiseaseWayModel() async {
    DiseaseWayModelEntityEntity tempModel =
        await DiseaseReportNetWorkQuery.diseaseWay();
    setState(() {
      model = tempModel;
      tempModel.result.forEach((res) {
        ways.add(res.name);
      });
    });
  }

  /// 头部数据
  List<String> headerHintTexts = [
    '请选择时间',
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
  void initState() {
    super.initState();
    _getDiseaseWayModel();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
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
          // 调用上报接口获取病害id
          _submitDisease();
          // id获取后上传病害描述关联id
          // 有图片就上传图片
        }
      },
      child: Container(
        height: 49,
        margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        alignment: Alignment.center,
        child: Text(
          '提交',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  _getCellDefaultText(BuildContext context, int section, int row) {
    if (sectionMaps.keys.contains(section)) {
      Map<String, String> tempMap = sectionMaps[section];
      return tempMap[prefixTitles[row]];
    }
    return null;
  }

  /// 获取cell
  Widget cell(BuildContext context, int section, int row) {
    return row == 5
        ? _getAddPhotoWidget(section)
        : CustomTextField(
            hintText: hintTexts[row],
            defaultText: _getCellDefaultText(context, section, row),
            prefixText: prefixTitles[row],
            suffixIconStyle: _getSuffixIconStyle(row),
            dropdownDataSources: row == 0 ? diseaseType : [],
            customTextFieldOnChanged: (prefixText, value) {
              // 是否包含该key值，使用section分组来标识唯一的分组值
              // 若包含该key值就去更新，不存在就去新建
              if (sectionMaps.keys.contains(section)) {
                // 存储输入值的Map
                Map<String, String> tempMap = sectionMaps[section];
                // 判断是否存在该key值
                if (tempMap.keys.contains(prefixText)) {
                  // 存在去更新
                  tempMap[prefixText] = value;
                } else {
                  // 不存在去创建
                  tempMap.addAll({prefixText: value});
                }
                // 创建完毕或更新完毕去替换原本的值
                setState(() {
                  sectionMaps[section] = tempMap;
                });
              } else {
                setState(() {
                  sectionMaps.addAll({
                    section: {prefixText: value}
                  });
                });
              }
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
  _getAddPhotoWidget(int section) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          alignment: Alignment.centerLeft,
          child: Text(
            "上传图片",
          ),
        ),
        PhotosGridView(
          // 这里存放的是图片id的数组
          photosOnChanged: (prefixText, imageIDs) {
            if (sectionImgMaps.keys.contains(section)) {
              // 存储输入值的Map
              Map<String, List<String>> tempMap = sectionImgMaps[section];
              // 判断是否存在该key值
              if (tempMap.keys.contains(prefixText)) {
                // 存在去更新
                tempMap[prefixText] = imageIDs;
              } else {
                // 不存在去创建
                tempMap.addAll({prefixText: imageIDs});
              }
              // 创建完毕或更新完毕去替换原本的值
              setState(() {
                sectionImgMaps[section] = tempMap;
              });
            } else {
              setState(() {
                sectionImgMaps.addAll({
                  section: {prefixText: imageIDs}
                });
              });
            }
          },
        ),
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
    for (int i = 0; i < headerPrefixTitles.length; i++) {
      items.add(CustomTextField(
        hintText: headerHintTexts[i],
        defaultText: inputHeaderValueMaps.keys.contains(headerPrefixTitles[i])
            ? inputHeaderValueMaps[headerPrefixTitles[i]]
            : null,
        prefixText: headerPrefixTitles[i],
        suffixIconStyle:
            i == 0 ? SuffixIconStyle.date : SuffixIconStyle.dropdown,
        dropdownDataSources: i == 1 ? ways : [],
        customTextFieldOnChanged: (prefixText, value) {
          // 如果key值存在就去更新value值，不存在就去创建字典并添加
          if (inputHeaderValueMaps.keys.contains(headerHintTexts[i])) {
            setState(() {
              inputHeaderValueMaps[prefixText] = value;
            });
          } else {
            setState(() {
              inputHeaderValueMaps.addAll({prefixText: value});
            });
          }
        },
      ));
    }
    return items;
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
              style: TextStyle(color: Colors.blue, fontSize: 18),
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

  /// 网络请求模块

  _submitDisease() async {
    // 获取道路id
    String wayName = inputHeaderValueMaps['巡查路段：'];
    String wayId;
    for (int i = 0; i < model.result.length; i++) {
      DiseaseWayModelEntityResult res = model.result[i];
      if (res.name == wayName) {
        wayId = res.id;
        break;
      }
    }
    Map<String, dynamic> params = {
      'discoveryTime': inputHeaderValueMaps['发现时间：'],
      'wayId': wayId,
      'memo': ' '
    };
    String tempId = await DiseaseReportNetWorkQuery.disease(params: params);
    setState(() {
      _diseaseId = tempId;
    });
    print('返回的病害id:$_diseaseId');
    // 获取到id请求病害详情接口
    if (tempId.isNotEmpty) {
      // 获取到id去根据病害描述总数调用对用次数的接口
      int successCount = 0; // 调用成功次数
      int failCount = 0; // 调用失败次数
      for (int i = 0; i < _sectionCount; i++) {
        Map<String, String> tempMap = sectionMaps[i];
        bool isSuccess = await _submitDescribe(tempId, tempMap);
        if(sectionImgMaps.keys.length > 0) {
          Map<String, List<String>> imgMap = sectionImgMaps[i];
          bool isSuccessImg = await _submitDescribeImg(tempId, imgMap);
        }
        if (isSuccess) {
          successCount++;
        } else {
          failCount++;
          Fluttertoast.showToast(msg: '第$i组病害描述上传失败');
        }
      }

      if (successCount == _sectionCount) {
        Fluttertoast.showToast(msg: '提交成功');
          Future.delayed(Duration(seconds: 2), () {
            Navigator.pop(context);
          });
      }
    }
  }

  _submitDescribe(String diseaseId, Map<String, String> describeMap) async {
    Map<String, dynamic> params = {
      'refDisease': diseaseId, // 病害关联ID
      'type': describeMap['病害种类：'],
      'number': num.parse(describeMap['病害数量：']),
      'address': describeMap['病害位置：'],
      'reasonAnalysis': describeMap['原因分析：'],
      'renovationMeasures': describeMap['整修措施：'],
      'memo': ' ',
    };
    // 上传病害描述
    String describeId =
        await DiseaseReportNetWorkQuery.diseaseDescribe(params: params);
    if (describeId.isNotEmpty) {
      return true;
    }
    return false;
  }

  _submitDescribeImg(
      String diseaseId, Map<String, List<String>> imgMaps) async {
    // 获取图片id
    List<String> imageIds = imgMaps['上传图片'];
    // 拼接图片id
    String ids = '';
    imageIds.forEach((value) {
      if(ids == ''){
        ids = '$value';
      }else{
        ids = '$ids,$value';
      }
    });
    bool result = await HTTPQuerery.upDateImage(
        {'refBizId': diseaseId, 'ids': ids});
    return result;
  }
}
