import 'package:flutter/material.dart';
import 'package:smartpipenetwork/customwidget/photos_gridview.dart';
import 'package:smartpipenetwork/models/describe_detail_entity.dart';
import 'package:smartpipenetwork/models/detailes_images_entity.dart';
import 'package:smartpipenetwork/models/task_network_query.dart';
import 'package:tableview/tableview.dart';

/// 巡查任务未完成详情页面
class DiseaseDetailsPage extends StatefulWidget {
  String diseaseId;

  DiseaseDetailsPage({@required this.diseaseId});

  @override
  _DiseaseDetailsPageState createState() => _DiseaseDetailsPageState();
}

class _DiseaseDetailsPageState extends State<DiseaseDetailsPage> {
  /// 现场照片
  List<String> images;

  DescribeDetailEntity model;

  @override
  void initState() {
    super.initState();
//    _getDetails();
  }

//  _getDetails() async {
//    DescribeDetailEntity tempModel =
//    await TaskNetWorkQuery.describeDetail({'id': widget.diseaseId});
//    DetailesImagesEntity imagesEntity =
//    await TaskNetWorkQuery.describeDetailImages(
//        {'refBizId': widget.diseaseId});
//    setState(() {
//      model = tempModel;
//      imagesEntity.result.forEach((res) {
//        if (res.url.isNotEmpty) {
//          images.add(res.url);
//        }
//      });
//    });
//  }

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
    return TableView(
      tableHeaderView: _getHeaderView(context),
      sectionNumber: model != null ? model.result.describes.length : 0,
      numberRowOfSection: (BuildContext context, int index) {
        return images == null ? 5 : 6;
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
        : _getCellItem(context, row, model.result.describes[section]);
  }

  /// 获取单个item
  _getCellItem(
      BuildContext context, int index, DescribeDetailResultDescribe model) {
    List<String> data = [
      '病害种类：  ${model.type}',
      '病害数量：  ${model.number.toString()}',
      '病害位置：  ${model.address}',
      '原因分析：  ${model.reasonAnalysis}',
      '整修措施：  ${model.renovationMeasures}',
    ];
    return Container(
      height: 70,
      child: Column(
        children: [
          Container(
            height: 69,
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            alignment: Alignment.centerLeft,
            child: Text(
              data[index],
              style: TextStyle(fontSize: 18),
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

  /// 获取上传图片的widget
  _getAddPhotoWidget() {
    return images != null
        ? Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          alignment: Alignment.centerLeft,
          child: Text(
            "现场照片:",
            style: TextStyle(fontSize: 18),
          ),
        ),
        PhotosGridView(
          imageUrls: images,
          photosType: PhotosType.show,
        ),
      ],
    )
        : Text('');
  }

  /// 获取tableView的头部视图
  _getHeaderView(BuildContext context) {
    return model != null
        ? Column(
      children: _headerCell(context),
    )
        : Text('');
  }

  /// 获取HeaderCell
  _headerCell(BuildContext context) {
    List<String> headerPrefixTitles = [
      '发现时间： ${model.result.discoveryTime}',
      '巡查路段：  ${model.result.wayId}'
    ];
    List<Widget> items = [];
    for (int i = 0; i < headerPrefixTitles.length; i++) {
      items.add(Container(
        height: 70,
        child: Column(
          children: [
            Container(
              height: 69,
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.centerLeft,
              child: Text(
                headerPrefixTitles[i],
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              height: 1,
              color: Color(0xffF0EEF9),
            )
          ],
        ),
      ));
    }
    return items;
  }
}
