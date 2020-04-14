import 'package:flutter/material.dart';

class SystemSettingPage extends StatefulWidget {
  @override
  _SystemSettingPageState createState() => _SystemSettingPageState();
}

class _SystemSettingPageState extends State<SystemSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('系统设置'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('系统设置',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w400, fontSize: 18)),
      ),
    );
  }
}
