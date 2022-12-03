
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wechat/color/colors.dart';
import 'package:wechat/ext/screen_util_ext.dart';

import '../../../../widget/avatar_widget.dart';


class ChatMamBer extends StatefulWidget {
  final dynamic model;

  ChatMamBer({this.model});

  @override
  _ChatMamBerState createState() => _ChatMamBerState();
}

class _ChatMamBerState extends State<ChatMamBer> {

  String name ="谭俊杰...";
  String avatar = "https://goerp.oss-cn-hongkong.aliyuncs.com/apk/erp/18200000002.jpeg";

  @override
  Widget build(BuildContext context) {
    // String face =
    //     Platform.isIOS ? widget.model?.faceURL : widget.model?.faceUrl;
    // String name =
    //     Platform.isIOS ? widget.model?.nickname : widget.model?.nickName;

    List<Widget> wrap = [];

    wrap.add(
      Wrap(
        spacing: (ScreenUtilExt.getWidth() - 315.w) / 5,
        runSpacing: 10.w,
        children: [0].map((item) {
          return InkWell(
            child: Container(

              child: Column(
                children: <Widget>[
                  AvatarWidget(
                    avatar: avatar,
                    weightWidth: 80.w,
                  ),
                  SizedBox(height: 5.w,),
                  Text(
                     name ,
                    style: TextStyle(color: Colours.c_FFE8E8E8,fontSize: 20.sp),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            onTap: (){

            },
          );
        }).toList(),
      ),
    );

    wrap.add(
      InkWell(
        child: Container(
          width: 80.w,
          height: 80.w,
          decoration:
              BoxDecoration(border: Border.all(color: Colours.c_FFE8E8E8, width: 0.2.w)),
          child: Image.asset('assets/images/icon_add_pic.jpg',
              width: 55.w, height: 55.w, fit: BoxFit.cover),
        ),
        onTap: (){
          
        },
      ),
    );

    return Container(
      color: Colors.white,
      width: ScreenUtilExt.getWidth(),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Wrap(
        spacing: (ScreenUtilExt.getWidth() - 315.w) / 5,
        runSpacing: 10.w,
        children: wrap,
      ),
    );
  }
}
