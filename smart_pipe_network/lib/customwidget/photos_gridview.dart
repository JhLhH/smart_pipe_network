import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
enum PhotosType { edit, show }

// ignore: must_be_immutable
class PhotosGridView extends StatefulWidget {
  List<String> imageUrls;
  PhotosType photosType;

  PhotosGridView({this.imageUrls, this.photosType = PhotosType.edit});

  @override
  _PhotosGridViewState createState() => _PhotosGridViewState();
}

class _PhotosGridViewState extends State<PhotosGridView> {
  final List<String> sheetTitles = ['拍照','从手机相机选择','取消'];
  List _images;
  var _image;
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      crossAxisSpacing: 5.0,
      mainAxisSpacing: 5.0,
      children: _getWidgetList(context),
    );
  }

  /// 自动换行的布局每张图片都可以添加
  List<Widget> _getWidgetList(BuildContext context) {
    List<Widget> items = [];
    if (_image != null) {
      if(_images == null){
        _images = [];
      }
      if (!_images.contains(_image)) {
        _images.add(_image);
        _image = null;
      }
    }

    if (widget.photosType == PhotosType.edit) {
      items.add(_getDefaultListItem(context));
    }
   if(_images != null){
     _images.forEach((image) {
       items.add(_getItemContainer(context, image));
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
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: Image.file(image,),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(icon: Icon(Icons.clear,size: 20,), onPressed: (){
              setState(() {
                _images.remove(image);
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
      child:
        ListView.builder(physics: NeverScrollableScrollPhysics(),itemCount: 3,itemBuilder: (BuildContext context, int index){
          return _getAlertSheetItem(context, index);
        })
    );
  }
  /// 底部弹框的每一行widget
  _getAlertSheetItem(BuildContext context, int index,) {
    double width = MediaQuery.of(context).size.width;
    return RaisedButton(onPressed: (){
      if (index == 2) {
          Navigator.pop(context);
        }
        if(index == 1){
          // 打开相册
          getImage(ImageSource.gallery);
        }else if(index == 0){
          // 打开相机
          getImage(ImageSource.camera);
        }
    },
    child: Text(sheetTitles[index]),
    );
  }

  /// 获取图片相机/相册
  Future getImage(ImageSource source) async{
    var image = await ImagePicker.pickImage(source: source);
    setState(() {
      Navigator.pop(context);
      _image = image;
    });
  }

}
