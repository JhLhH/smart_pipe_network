import 'package:flutter/material.dart';
import 'package:smartpipenetwork/customwidget/photos_gridview.dart';
import 'package:tableview/tableview.dart';

/// 巡查任务未完成详情页面
class DiseaseDetailsPage extends StatefulWidget {

  @override
  _DiseaseDetailsPageState createState() => _DiseaseDetailsPageState();
}

class _DiseaseDetailsPageState extends State<DiseaseDetailsPage> {
  /// 头部数据
  final List<String> headerPrefixTitles = [
    '编号：  WX20191102001',
    '巡查人员：  王晓峰',
    '发现时间：  2019-11-17 14:20',
    '所属片区：  北部片区',
    '巡查路段：  遵大路（银港大道至雍州路）'
  ];

  /// 病害上报输入框左侧固定文字
  final List<String> prefixTitles = [
    '病害种类：  人行道砖破损、缺失(m²)',
    '病害数量：  2.5',
    '病害位置：  遵大路与雍州路南北交200米处',
    '原因分析：  碾压造成',
    '整修措施：  派第三方施工队进行维修',
  ];

  /// 现场照片
 final List<String> images = ['http://qiniu.xingheaoyou.com/5.jpg',
   'http://qiniu.xingheaoyou.com/2.jpg',
   'http://qiniu.xingheaoyou.com/3.jpg',
   'http://qiniu.xingheaoyou.com/2.jpg'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('病害详情'),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(child: _getBodyContentWidget(context)),
    );
  }

  /// 获取内容主题的listView
  _getBodyContentWidget(BuildContext context) {
    return  TableView(
              tableHeaderView: _getHeaderView(context),
              sectionNumber: 2,
              numberRowOfSection: (BuildContext context, int index) {
                return prefixTitles.length + 1;
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
            );
  }

  /// 获取cell
  Widget cell(BuildContext context, int section, int row) {
    return row == 5
        ? _getAddPhotoWidget()
        : _getCellItem(context, row, prefixTitles);
  }
  /// 获取单个item
  _getCellItem(BuildContext context, int index, List data){
    return Container(
      height: 70,
      child: Column(
        children: [
          Container(
            height: 69,
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            alignment: Alignment.centerLeft,
            child: Text(data[index],style: TextStyle(fontSize: 18),),
          ),
          Container(
            height: 1,
            color: Color(0xffF0EEF9),
          )
        ],
      ),
    );
  }

  /// 获取上传图片的widget
  _getAddPhotoWidget() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          alignment: Alignment.centerLeft,
          child: Text(
            "现场照片:",
            style: TextStyle(fontSize: 18),
          ),
        ),
        PhotosGridView(imageUrls: images,photosType: PhotosType.show,),
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
        items.add(_getCellItem(context, i, headerPrefixTitles));
    }
    return items;
  }
}
