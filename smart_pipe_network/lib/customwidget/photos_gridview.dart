import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartpipenetwork/base_commons/base_network.dart';

enum PhotosType { edit, show }

typedef PhotosOnChanged = void Function(String prefixText, List<String> imgIds);

class PhotosGridView extends StatefulWidget {
  final List<String> imageUrls;
  final PhotosType photosType;
  final PhotosOnChanged photosOnChanged;

  PhotosGridView(
      {this.imageUrls,
      this.photosType = PhotosType.edit,
      this.photosOnChanged});

  @override
  PhotosGridViewState createState() => PhotosGridViewState();
}

class PhotosGridViewState extends State<PhotosGridView> {
  final List<String> sheetTitles = ['拍照', '从手机相机选择', '取消'];
  List images;
  List<String> imageIds = [];
  var _image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 3,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
            children: _getWidgetList(context),
          ),
        ),
        Container(
          height: 1,
          color: Color(0xffF0EEF9),
        )
      ],
    );
  }

  /// 自动换行的布局每张图片都可以添加
  List<Widget> _getWidgetList(BuildContext context) {
    List<Widget> items = [];
    if (_image != null) {
      if (images == null) {
        images = [];
      }
      if (!images.contains(_image)) {
        images.add(_image);
        _image = null;
      }
    }
    if (widget.photosType == PhotosType.edit) {
      items.add(_getDefaultListItem(context));
    }
    if (widget.photosType == PhotosType.edit) {
      if (images != null) {
        images.forEach((image) {
          items.add(_getItemContainer(context, image));
        });
      }
    } else {
      widget.imageUrls.forEach((imageUrl) {
        items.add(_getShowItemContainer(context, imageUrl));
      });
    }
    return items;
  }

  /// 添加大+按钮
  _getDefaultListItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 选择照片或拍照
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return _bottomSheetBody(context);
            });
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(8)),
        child: Icon(
          Icons.add,
          color: Colors.grey,
          size: 50,
        ),
      ),
    );
  }

  /// 返回的纯展示照片的widget
  Widget _getShowItemContainer(BuildContext context, String imageUrl) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(8)),
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }

  /// 返回的照片展示的widget
  Widget _getItemContainer(BuildContext context, image) {
    return GestureDetector(
      onTap: () {
        // 跳转到预览图
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                image,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
                icon: Icon(
                  Icons.clear,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    images.remove(image);
                  });
                }),
          )
        ],
      ),
    );
  }

  /// 底部弹框
  Widget _bottomSheetBody(BuildContext context) {
    return Container(
        height: 140.0,
        margin: EdgeInsets.all(10),
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return _getAlertSheetItem(context, index);
            }));
  }

  /// 底部弹框的每一行widget
  _getAlertSheetItem(
    BuildContext context,
    int index,
  ) {
    double width = MediaQuery.of(context).size.width;
    return RaisedButton(
      onPressed: () {
        if (index == 2) {
          Navigator.pop(context);
        }
        if (index == 1) {
          // 打开相册
          getImage(ImageSource.gallery);
        } else if (index == 0) {
          // 打开相机
          getImage(ImageSource.camera);
        }
      },
      child: Text(sheetTitles[index]),
    );
  }

  /// 获取图片相机/相册
  Future getImage(ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    String id = await HTTPQuerery.upload(image);
    setState(() {
      Navigator.pop(context);
      if (id.isNotEmpty) {
        imageIds.add(id);
        widget.photosOnChanged('上传图片',imageIds);
      }
      _image = image;
    });
  }
}
