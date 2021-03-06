import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smartpipenetwork/models/login_network_query.dart';
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
      return false;
    }
  }

  /// 登录
  void goLogin(BuildContext context) async {
    var pass = _checkLoginInfo(context);
    if (pass == false) return;
    Map<String, dynamic> params = {'username': userName, 'password': password};
    var model = await LoginNetWorkQuery.login(params);
    if (model != null) {
      // 登录成功
      runApp(RootWidgetPage(loginModelEntity: model,));
    }
  }

  /// 登录提示
  Future showLoginProgress(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.only(top: 26.0),
                child: Text("正在登录，请稍后..."),
              )
            ],
          ),
        );
      },
    );
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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/login-bg@2x.png"), // 把图片换掉
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
                child: Column(
                  children: [
                    _getRichText(),
                    _getUserNameTextField(),
                    _getPasswordTextField(),
                    _getButton(context, '登  录', Colors.blue), // 获取登录按钮
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
              style: TextStyle(color: Colors.white, fontSize: 18.0),
              children: <TextSpan>[
                TextSpan(
                  text: '\n 智慧管网移动端应用',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500),
                ),
                TextSpan(text: 'v1.0', style: TextStyle(fontSize: 14))
              ])),
    );
  }

  /// 获取按钮
  _getButton(BuildContext context, String title, Color color) {
    return GestureDetector(
      onTap: () {
        goLogin(context);
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 40, right: 40, top: 40),
        height: 49,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.transparent, width: 1),
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
        BoxDecoration(border: Border.all(color: Colors.white, width: 1),borderRadius: BorderRadius.circular(20)),
        child: TextField(
          controller: _userNameController,
          onChanged: (value) {
            setState(() {
              userName = value;
            });
          },
          style: TextStyle(
              fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w500),
          // 输入文本样式
          decoration: InputDecoration(
              border: InputBorder.none, //去除下划线
              hintText: '输入账号',
              hintStyle: TextStyle(fontSize: 15, color: Colors.white,fontWeight: FontWeight.w500),
              prefixIcon: Icon(
                Icons.person,
                size: 30,
                color: Colors.white,
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
          BoxDecoration(border: Border.all(color: Colors.white, width: 1),borderRadius: BorderRadius.circular(20)),
          child: TextField(
            controller: _passwordController,
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
            obscureText: true,
            style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
                fontWeight: FontWeight.w500),
            // 输入文本样式
            decoration: InputDecoration(
                border: InputBorder.none, //去除下划线
                hintText: '输入密码',
                hintStyle: TextStyle(fontSize: 15, color: Colors.white,fontWeight: FontWeight.w500),
                prefixIcon: Icon(
                  Icons.lock_outline,
                  size: 30,
                  color: Colors.white,
                )),
          ),
        ));
  }
}
