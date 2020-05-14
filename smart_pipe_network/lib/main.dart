import 'package:flutter/material.dart';
import 'package:amap_location/amap_location.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smartpipenetwork/login/login.dart';

void main() async{
  AMapLocationClient.setApiKey("0ed9fc7ab6d9002526fda12a13166b6d");
  runApp(MyApp());
  /// 申请定位权限,有权限直接定位
  bool hasPermission = false;
  PermissionStatus statues1 = await PermissionHandler()
      .checkPermissionStatus(PermissionGroup.locationWhenInUse);
  PermissionStatus statues2 = await PermissionHandler()
      .checkPermissionStatus(PermissionGroup.locationAlways);
  if (statues1 == PermissionStatus.granted) {
    hasPermission = true;
  }
  if (statues2 == PermissionStatus.granted) {
    hasPermission = true;
  }
  if (!hasPermission) {
    Fluttertoast.showToast(msg: "权限未开启请打开设置开启定位");
  }
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}