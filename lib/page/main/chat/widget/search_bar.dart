
import 'package:flutter/material.dart';
import 'package:wechat/ext/screen_util_ext.dart';

import '../../../../color/colors.dart';
import '../../../../utils/utils.dart';

class SearchBar extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  const SearchBar({this.onChanged});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _editingController = TextEditingController();
  bool _showClose = false;
  void _onChange(text) {
    if (null != widget.onChanged) {
      widget.onChanged!(text);
    }
    setState(() {
      _showClose = ((text as String).length > 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      // color: Colours.white,
      child: Column(
        children: [
          SizedBox(height: 40.w,), //上半部分留空
          Container(
            height: 88.w,
            margin: EdgeInsets.only(left: 30.w,right: 30.w),
            child: Row(
              children: [
               Expanded(child: Container(
                 height: 68.w,
                 margin: EdgeInsets.only(left: 5.w, right: 10.w),
                 padding: EdgeInsets.only(left: 5.w, right: 5.w),
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(6.0),
                 ),
                 child: Row(
                   children: [
                     Image(image: AssetImage(Utils.getImgPath('icon_search', dir: 'icon')), width: 40.w,height: 40.w, color: Colors.grey,), //放大镜
                     Expanded(child: TextField(
                       controller: _editingController,
                       onChanged: _onChange,
                       autofocus: true,
                       cursorColor: Colors.green,
                       style: TextStyle(
                         fontSize: 32.sp,
                         color: Colors.black87,
                         fontWeight: FontWeight.w400,
                       ),
                       decoration: InputDecoration(
                         contentPadding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 12.w,),
                         border: InputBorder.none,
                         hintText: '搜索',
                         hintStyle: TextStyle(
                           fontSize: 32.sp,
                           color: Colors.grey,
                           fontWeight: FontWeight.w400,
                         ),
                       ),
                     ),),
                     if (_showClose) GestureDetector(
                       onTap: () {
                         //清空搜索框
                         _editingController.clear();
                         setState(() {
                           _onChange('');
                         });
                       },
                       child: Icon(
                         Icons.cancel,
                         color: Colors.grey,
                         size: 36.w,
                       ),
                     ),
                   ],
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 ),
               )) , //左边白色背景
                GestureDetector (
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text('取消',style: TextStyle(
                    color: Colours.c_FF6073FF,
                    fontSize: 32.sp,
                  ),),
                ), //右边取消按钮
              ],
            ),
          ), //搜索条部分
        ],
      ),
    );
  }
}