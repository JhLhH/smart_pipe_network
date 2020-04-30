import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smartpipenetwork/customwidget/dropdown_widget.dart';

enum SuffixIconStyle { normal, dropdown, location ,date}

class CustomTextField extends StatefulWidget {
  /// 占位文字
  final String hintText;

  /// 右侧说明文字
  final String prefixText;

  /// 是否可以编辑
  final bool enabled;

  // 日历选择点击
  final VoidCallback onPressed;

  final List<String> dropdownDataSources;

  /// 输入框内值发生变化的回调
  final ValueChanged onChanged;
  final SuffixIconStyle suffixIconStyle;

  CustomTextField(
      {@required this.hintText,
      @required this.prefixText,
      this.enabled = true,
      this.onChanged,
      this.suffixIconStyle = SuffixIconStyle.normal, this.onPressed, this.dropdownDataSources});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
       alignment: Alignment.center,
      children: [
        _getTextField(),
        Positioned(
          right: 5,
          child: Center(
            child: _getRightIconButton(context),
          ),
        )
      ],
    );
  }

  /// 获取输入框
  _getTextField() {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: TextFormField(
        controller: controller,
        enabled: widget.suffixIconStyle == SuffixIconStyle.normal? true:false,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: Container(
            width: 80,
            alignment: Alignment.center,
            child: Text(
              widget.prefixText,
            ),
          ),
          suffixIcon: Text(''),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffF0EEF9)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffF0EEF9)),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffF0EEF9)),
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return widget.hintText;
          }
          return null;
        },
        onChanged: widget.onChanged,
      ),
    );
  }

  _getRightIconButton(BuildContext context) {
    if (widget.suffixIconStyle == SuffixIconStyle.dropdown) {
      return CustomDropdownButton(
          dataSources: widget.dropdownDataSources,
          onChanged: (value) {
            setState(() {
              controller.text = value;
            });
          });
    }
    if (widget.suffixIconStyle == SuffixIconStyle.location) {
      return IconButton(
          icon: Icon(
            Icons.room,
            color: Colors.blue,
          ),
          onPressed: () {
            // 定位按钮点击事件
            setState(() {
              controller.text = '位置输入完成';
            });
          });
    }
    if(widget.suffixIconStyle == SuffixIconStyle.date){
      return IconButton(icon: Icon(Icons.date_range,color: Colors.blue,), onPressed:(){
        var nowTime = formatDate(DateTime.now(), [yyyy, "-", mm, "-", dd, " ", HH, ":", nn, ":", ss]);
        setState(() {
          controller.text = nowTime;
        });
      });
    }
    return Text('');
  }
}
