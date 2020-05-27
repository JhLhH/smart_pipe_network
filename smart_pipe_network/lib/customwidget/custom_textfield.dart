import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smartpipenetwork/customwidget/dropdown_widget.dart';
import 'package:amap_location/amap_location.dart';
import 'package:smartpipenetwork/models/disease_report_network_query.dart';
import 'package:smartpipenetwork/models/location_model_entity.dart';

enum SuffixIconStyle { normal, dropdown, location, date }

/// 当输入框值发生变化的时候回调
///
/// hintText 左侧的固定文字用来判断是哪一个输入框
/// value 输入的值
typedef CustomTextFieldOnChanged = void Function(
    String prefixText, String value);

/// 获取位置回调
typedef CustomTextFieldLocation = void Function(
    String prefixText, String locValue);

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

  final CustomTextFieldOnChanged customTextFieldOnChanged;

  final CustomTextFieldLocation customTextFieldLocation;

  /// 默认值
  final String defaultText;

  CustomTextField(
      {@required this.hintText,
      @required this.prefixText,
      this.enabled = true,
      this.onChanged,
      this.suffixIconStyle = SuffixIconStyle.normal,
      this.onPressed,
      this.dropdownDataSources,
      this.customTextFieldOnChanged,
      this.defaultText,
      this.customTextFieldLocation});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController controller = TextEditingController();
  AMapLocation _loc; // 定位返回数据
  LocationModelEntity locationModel;

  @override
  void initState() {
    if (widget.defaultText != null) {
      setState(() {
        controller.text = widget.defaultText;
      });
    }
    super.initState();
    controller.addListener(() {
      if(widget.prefixText == '病害位置：'){
        Map<String, String> map = {
          'name': locationModel.regeocode.addressComponent.township,
          'point': '[${_loc.longitude},${_loc.latitude}]'
        };
        widget.customTextFieldLocation(widget.prefixText,json.encode(map));
      }else {
        widget.customTextFieldOnChanged(widget.prefixText, controller.text);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
        enabled:
            widget.suffixIconStyle == SuffixIconStyle.normal ? widget.enabled : false,
        textAlign:
            controller.text.length == 0 ? TextAlign.right : TextAlign.left,
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
            String text ;
            // 判断是整修措施需要
            if(widget.prefixText == '整修措施：'){
              if(widget.defaultText != null){
                if(widget.defaultText.contains(value)){
                  text = widget.defaultText;
                }else {
                  text = widget.defaultText + ',$value';
                }
              }else{
                text = value;
              }
            }else{
              text = value;
            }
            setState(() {
              controller.text = text;
            });
          });
    }
    if (widget.suffixIconStyle == SuffixIconStyle.location) {
      return IconButton(
          icon: Icon(
            Icons.room,
            color: Colors.blue,
          ),
          onPressed: () async {
           AMapLocation location = await _getLocation();
           LocationModelEntity tempModel =
           await DiseaseReportNetWorkQuery.getLocation(
               '${location.longitude},${location.latitude}');
           String text  = tempModel.regeocode.formattedAddress;
           setState(() {
              locationModel = tempModel;
              _loc = location;
              controller.text = text;
            });
          });
    }
    if (widget.suffixIconStyle == SuffixIconStyle.date) {
      return IconButton(
          icon: Icon(
            Icons.date_range,
            color: Colors.blue,
          ),
          onPressed: () {
            var nowTime = formatDate(DateTime.now(),
                [yyyy, "-", mm, "-", dd, " ", HH, ":", nn, ":", ss]);
            setState(() {
              controller.text = nowTime;
            });
          });
    }
    return Text('');
  }

  _getLocation() async {
    //先启动一下
    await AMapLocationClient.startup(new AMapLocationOption(
        desiredAccuracy: CLLocationAccuracy.kCLLocationAccuracyHundredMeters));
    //直接获取定位
    AMapLocation location = await AMapLocationClient.getLocation(true);
    if (location != null) {
     return location;
    }
    return null;
  }
}
