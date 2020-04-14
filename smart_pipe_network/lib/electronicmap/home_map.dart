import 'package:flutter/material.dart';

class HomeMapPage extends StatefulWidget {
  @override
  _HomeMapPageState createState() => _HomeMapPageState();
}

class _HomeMapPageState extends State<HomeMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '电子地图',
          style: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.w400, fontSize: 18),
        ),
      ),
    );
  }
}
