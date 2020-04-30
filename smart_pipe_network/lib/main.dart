import 'package:flutter/material.dart';
import 'package:smartpipenetwork/root/root_widget_page.dart';
import 'package:smartpipenetwork/login/login.dart';

void main() {

  runApp(MyApp());
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