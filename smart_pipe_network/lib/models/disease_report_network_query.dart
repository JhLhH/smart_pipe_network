import 'package:fluttertoast/fluttertoast.dart';
import 'package:smartpipenetwork/base_commons/base_network.dart';
import 'package:smartpipenetwork/base_commons/urls.dart';
import 'package:smartpipenetwork/generated/json/location_model_entity_helper.dart';
import 'dart:convert';

import 'package:smartpipenetwork/models/disease_way_model_entity_entity.dart';
import 'package:smartpipenetwork/generated/json/disease_way_model_entity_entity_helper.dart';
import 'package:smartpipenetwork/models/location_model_entity.dart';

class DiseaseReportNetWorkQuery {
  static Future<bool> disease({Map<String, dynamic> params}) async {
    var data = await HTTPQuerery.post(diseaseUrl, params: params);
    try {
      // 解析json数据
      Map<String, dynamic> response = json.decode(data);
      // 返回病害id
      return true;
    } catch (error) {
      print('error------$error------');
      Fluttertoast.showToast(msg: '上传数据出错');
      return false;
    }
  }

  /// 病害描述(弃用)
//  static Future diseaseDescribe({Map<String, dynamic>params}) async {
//    var data = await HTTPQuerery.post(describeUrl,params: params);
//    try {
//      // 解析json数据
//      Map<String,dynamic> response = json.decode(data);
//      Map<String,dynamic> result = response['result'];
//      // 返回病害id
//      return result['id'];
//    } catch (error) {
//      print('error------$error------');
//      Fluttertoast.showToast(msg: '上传数据出错');
//      return null;
//    }
//  }

  /// 获取道路信息
  static Future<DiseaseWayModelEntityEntity> diseaseRooadList() async {
    var data = await HTTPQuerery.get(diseaseRoadUrl);
    try {
      // 解析json数据
      DiseaseWayModelEntityEntity diseaseWayModelEntityEntity =
          diseaseWayModelEntityEntityFromJson(
              DiseaseWayModelEntityEntity(), jsonDecode(data));
      // 返回道路信息
      return diseaseWayModelEntityEntity;
    } catch (error) {
      print('error------$error------');
      Fluttertoast.showToast(msg: '道路数据获取失败');
      return null;
    }
  }

  /// 获取道路信息
  static Future<String> diseaseWay(String plantId) async {
    var data = await HTTPQuerery.get(diseaseWayUrl + plantId);
    try {
      // 解析json数据
      Map<String, dynamic> respones = json.decode(data);
      String wyaName = respones['result'];
      // 返回道路信息
      return wyaName;
    } catch (error) {
      print('error------$error------');
      Fluttertoast.showToast(msg: '道路数据获取失败');
      return null;
    }
  }

  /// 获取道路信息
  static Future<String> diseaseRead(String plantId) async {
    var data = await HTTPQuerery.get(diseaseRoadUrl);
    try {
      // 解析json数据
      Map<String, dynamic> respones = json.decode(data);
      String wyaName = respones['result'];
      // 返回道路信息
      return wyaName;
    } catch (error) {
      print('error------$error------');
      Fluttertoast.showToast(msg: '道路数据获取失败');
      return null;
    }
  }

  /// 获取位置
  static Future getLocation(String location) async {
    var data = await HTTPQuerery.getLocationRequest(location);
    try {
      // 解析json数据
      LocationModelEntity model =
          locationModelEntityFromJson(LocationModelEntity(), jsonDecode(data));
      // 返回地理坐标信息
      return model;
    } catch (error) {
      print('error------$error------');
      Fluttertoast.showToast(msg: '位置获取出错');
      return null;
    }
  }

  /// 巡查任务时上报坐标点
  static Future<bool> submitLocationPoint({Map<String, dynamic> params}) async {
    var data = await HTTPQuerery.post(trajectoryUrl, params: params);
    try {
      // 解析json数据
      Map<String, dynamic> response = json.decode(data);
      bool result = response['result'];
      // 返回病害id
      return result;
    } catch (error) {
      print('error------$error------');
      Fluttertoast.showToast(msg: '位置上传出错${error.toString()}');
      return null;
    }
  }
}
