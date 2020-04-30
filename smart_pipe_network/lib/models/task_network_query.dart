import 'package:fluttertoast/fluttertoast.dart';
import 'package:smartpipenetwork/base_commons/base_network.dart';
import 'package:smartpipenetwork/base_commons/urls.dart';
import 'package:smartpipenetwork/models/finished_task_model_entity_entity.dart';
import 'package:smartpipenetwork/models/undone_task_model_entity.dart';
import 'package:smartpipenetwork/generated/json/undone_task_model_entity_helper.dart';
import 'package:smartpipenetwork/generated/json/finished_task_model_entity_entity_helper.dart';
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
}
