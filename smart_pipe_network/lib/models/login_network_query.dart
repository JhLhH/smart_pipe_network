import 'package:smartpipenetwork/base_commons/base_network.dart';
import 'package:smartpipenetwork/base_commons/base_shared_preferences.dart';
import 'package:smartpipenetwork/base_commons/urls.dart';
import 'login_model_entity.dart';
import 'package:smartpipenetwork/generated/json/login_model_entity_helper.dart';
import 'dart:convert';

class LoginNetWorkQuery{
  static Future login(Map<String, dynamic>params)async{
    var data = await HTTPQuerery.post(loginUrl,params: params);
    try{
      // 解析json数据
      LoginModelEntity loginModel = loginModelEntityFromJson(LoginModelEntity(),json.decode(data));
      // 保存token
      ShardPreferences.localSave('token', loginModel.result.token);
      return loginModel;
    }catch(error){
      print('error------$error------');
      return null;
    }
  }
}