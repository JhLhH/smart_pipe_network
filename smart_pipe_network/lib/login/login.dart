import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smartpipenetwork/root/root_widget_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 用户名
  String userName;

  // 密码
  String password;

  // 警告信息
  String waringInfo;

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  /// 用户名密码不能为空
  bool _checkLoginInfo(BuildContext context) {
    if (userName != null && password != null) {
      return true;
    } else {
      if (userName == null || password == null) {
        setState(() {
          waringInfo = '用户名密码不能为空';
          showCenterShortToast();
        });
      }
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          waringInfo = null;
        });
      });
      return false;
    }
  }

  /// 提示
  void showCenterShortToast() {
    Fluttertoast.showToast(
        msg: waringInfo,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode()); // 取消键盘
          },
          child: Container(
            width: width,
            height: height,
            color: Colors.white,
            child: SafeArea(
                child: Column(
              children: [
                _getRichText(),
                _getUserNameTextField(),
                _getPasswordTextField(),
                _getButton('登  录', Colors.blue), // 获取登录按钮
              ],
            )),
          ),
        ),
      ),
    );
  }

  /// 获取顶部富文本文字
  _getRichText() {
    return Padding(
      padding: EdgeInsets.only(top: 100),
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: '郑州航空港经济综合实验区智慧城管',
              style: TextStyle(color: Colors.black, fontSize: 18.0),
              children: <TextSpan>[
                TextSpan(
                  text: '\n 智慧管网移动端应用',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500),
                ),
                TextSpan(text: 'v1.0', style: TextStyle(fontSize: 14))
              ])),
    );
  }

  /// 获取按钮
  _getButton(String title, Color color) {
    return GestureDetector(
      onTap: () {
        if (_checkLoginInfo(context)) {
          runApp(RootWidgetPage());
        }
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 40, right: 40, top: 40),
        height: 49,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(24.5),
        ),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  /// 账户输入框
  _getUserNameTextField() {
    return Container(
      padding: EdgeInsets.only(top: 100),
      margin: EdgeInsets.only(
        left: 40,
        right: 40,
      ),
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
        child: TextField(
          controller: _userNameController,
          onChanged: (value) {
            setState(() {
              userName = value;
            });
          },
          style: TextStyle(
              fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.w300),
          // 输入文本样式
          decoration: InputDecoration(
              border: InputBorder.none, //去除下划线
              hintText: '输入账号',
              hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
              prefixIcon: Icon(
                Icons.person,
                size: 30,
                color: Colors.grey,
              )),
        ),
      ),
    );
  }

  /// 密码输入框
  _getPasswordTextField() {
    return Container(
        padding: EdgeInsets.only(top: 20),
        margin: EdgeInsets.only(
          left: 40,
          right: 40,
        ),
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
          child: TextField(
            controller: _passwordController,
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
            style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                fontWeight: FontWeight.w300),
            // 输入文本样式
            decoration: InputDecoration(
                border: InputBorder.none, //去除下划线
                hintText: '输入密码',
                hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                prefixIcon: Icon(
                  Icons.lock_outline,
                  size: 30,
                  color: Colors.grey,
                )),
          ),
        ));
  }
}
