import 'package:flutter/material.dart';
class CustomDropdownButton extends StatefulWidget {
  /// 下拉框内的内容
  final List<String> dataSources;
  /// 选中下拉框内的某一个内容
  final ValueChanged onChanged;
  CustomDropdownButton({@required this.dataSources,@required this.onChanged});
  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        // 这里选择菜单的下拉框内容根据index传入对应的内容需要一个数组listData
        items: dropdownItems(widget.dataSources),
        onChanged: widget.onChanged,
      ),
    );
  }

  dropdownItems(List dropdownData) {
    List<DropdownMenuItem<String>> list = new List();
    dropdownData.forEach((value) {
      list.add(
        new DropdownMenuItem(
            child: new Container(
              color: Colors.white,
              child: new Text(value, style: TextStyle(color: Colors.black),),
            ), value: value
        ),
      );
    });
    return list;
  }
}
