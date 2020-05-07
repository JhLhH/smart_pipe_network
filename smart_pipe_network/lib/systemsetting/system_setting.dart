import 'package:flutter/material.dart';
import 'package:smartpipenetwork/base_commons/base_shared_preferences.dart';

class SystemSettingPage extends StatefulWidget {
  @override
  _SystemSettingPageState createState() => _SystemSettingPageState();
}

class _SystemSettingPageState extends State<SystemSettingPage> {
  String _account = ''; // 账号
  String _deptName = ''; // 部门
  String _mobile = ''; // 电话
  String _roleName = ''; // 姓名

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserInfo();
  }

  _getUserInfo() async {
    String account = await ShardPreferences.localGet('account');
    String deptName = await ShardPreferences.localGet('deptName');
    String mobile = await ShardPreferences.localGet('mobile');
    String roleName = await ShardPreferences.localGet('userName');
    setState(() {
      _account = account != null ? account:'';
      _deptName = deptName != null ? deptName:'';
      _mobile = mobile != null ? mobile:'';
      _roleName = roleName != null ? roleName:'';
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('系统设置'),
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20,left: 10,right: 10),
            width: width,
            height: height,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start ,
              children: [
                Icon(
                  Icons.person,
                  size: 100,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10,right: 5),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _getText('账号：$_account'),
                      _getText('部门：$_deptName'),
                      _getText('电话：$_mobile'),
                      _getText('姓名：$_roleName'),
                    ],
                  ),
                )
              ],
            ),
            color: Colors.white,
          ),
          Positioned(
            bottom: bottomPadding,
            width: width,
            height: 59,
            child: _getBottomButton(context),
          )
        ],
      ),
    );
  }

  _getText(String text){
    return Container(
      height: 30,
      alignment: Alignment.bottomLeft,
      child: Text(text,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
    );
  }

  _getBottomButton(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 49,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        alignment: Alignment.center,
        child: Text(
          '退出登录',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
