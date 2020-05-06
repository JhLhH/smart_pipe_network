import 'package:fluttertoast/fluttertoast.dart';
import 'package:smartpipenetwork/base_commons/base_network.dart';
import 'package:smartpipenetwork/base_commons/urls.dart';
import 'dart:convert';

import 'package:smartpipenetwork/models/disease_way_model_entity_entity.dart';
import 'package:smartpipenetwork/generated/json/disease_way_model_entity_entity_helper.dart';
class DiseaseReportNetWorkQuery {
  static Future disease({Map<String, dynamic>params}) async {
    var data = await HTTPQuerery.post(diseaseUrl,params: params);
    try {
      // 解析json数据
      Map<String,dynamic> response = json.decode(data);
      Map<String,dynamic> result = response['result'];
      // 返回病害id
      return result['id'];
    } catch (error) {
      print('error------$error------');
      Fluttertoast.showToast(msg: '上传数据出错');
      return null;
    }
  }

  static Future diseaseDescribe({Map<String, dynamic>params}) async {
    var data = await HTTPQuerery.post(describeUrl,params: params);
    try {
      // 解析json数据
      Map<String,dynamic> response = json.decode(data);
      Map<String,dynamic> result = response['result'];
      // 返回病害id
      return result['id'];
    } catch (error) {
      print('error------$error------');
      Fluttertoast.showToast(msg: '上传数据出错');
      return null;
    }
  }
  static Future diseaseWay() async {
    var data = await HTTPQuerery.get(diseaseWayUrl);
    try {
      // 解析json数据
      DiseaseWayModelEntityEntity model = diseaseWayModelEntityEntityFromJson(DiseaseWayModelEntityEntity(),jsonDecode(data));
      // 返回道路信息
      return model;
    } catch (error) {
      print('error------$error------');
      Fluttertoast.showToast(msg: '上传数据出错');
      return null;
    }
  }



}
