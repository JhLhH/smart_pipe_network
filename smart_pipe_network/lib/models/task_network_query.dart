import 'package:fluttertoast/fluttertoast.dart';
import 'package:smartpipenetwork/base_commons/base_network.dart';
import 'package:smartpipenetwork/base_commons/urls.dart';
import 'package:smartpipenetwork/models/describe_detail_entity.dart';
import 'package:smartpipenetwork/models/detailes_images_entity.dart';
import 'package:smartpipenetwork/models/finished_task_model_entity_entity.dart';
import 'package:smartpipenetwork/models/undone_task_model_entity.dart';
import 'package:smartpipenetwork/generated/json/undone_task_model_entity_helper.dart';
import 'package:smartpipenetwork/generated/json/finished_task_model_entity_entity_helper.dart';
import 'package:smartpipenetwork/generated/json/describe_detail_entity_helper.dart';
import 'package:smartpipenetwork/generated/json/detailes_images_entity_helper.dart';
import 'dart:convert';

class TaskNetWorkQuery {
  static Future unDoneTask() async {
    var data = await HTTPQuerery.get(undoneTaskUrl);
    try {
      // 解析json数据
      UndoneTaskModelEntity undoneModel = undoneTaskModelEntityFromJson(
          UndoneTaskModelEntity(), json.decode(data));
      return undoneModel;
    } catch (error) {
      print('error------$error------');
      Fluttertoast.showToast(msg: '解析出错');
      return null;
    }
  }

  static Future finishedTask() async {
    var data = await HTTPQuerery.get(finishedTaskUrl);
    try {
      // 解析json数据
      FinishedTaskModelEntityEntity finishedModel =
          finishedTaskModelEntityEntityFromJson(
              FinishedTaskModelEntityEntity(), json.decode(data));
      return finishedModel;
    } catch (error) {
      print('error------$error------');
      Fluttertoast.showToast(msg: '解析出错');
      return null;
    }
  }
  /// 根据病害id获取病害详情
  static Future describeDetail(Map<String,String>params) async {
    var data = await HTTPQuerery.get(describeDetailUrl,params: params);
    try {
      // 解析json数据
      DescribeDetailEntity describeDetailEntity =
      describeDetailEntityFromJson(
              DescribeDetailEntity(), json.decode(data));
      return describeDetailEntity;
    } catch (error) {
      print('error------$error------');
      Fluttertoast.showToast(msg: '解析出错');
      return null;
    }
  }

  /// 根据病害ID获取图片
  static Future describeDetailImages(Map<String,String>params) async {
    var data = await HTTPQuerery.get(describeDetailImageUrl,params: params);
    try {
      // 解析json数据
      DetailesImagesEntity detailesImagesEntity =
      detailesImagesEntityFromJson(
              DetailesImagesEntity(), json.decode(data));
      return detailesImagesEntity;
    } catch (error) {
      print('error------$error------');
      Fluttertoast.showToast(msg: '解析出错');
      return null;
    }
  }




}
