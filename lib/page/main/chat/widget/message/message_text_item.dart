import 'package:flutter/material.dart';
import 'package:leancloud_official_plugin/leancloud_plugin.dart';
import 'package:wechat/color/colors.dart';
import 'package:wechat/core.dart';

import '../../../../../utils/pattern_util.dart';
import '../../../../../utils/utils.dart';

class MessageTextItem extends StatelessWidget {
  TextMessage message;

  MessageTextItem({required this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 200.w),
      padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 10.w),
      decoration:
          (message.isSend ? Colours.c_98E165 : Colours.white).boxDecoration(),
      child:  videoPhoneItem(),
    );

    return Container(
      constraints: BoxConstraints(maxWidth: 400.w),
      padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 10.w),
      decoration:
          (message.isSend ? Colours.c_98E165 : Colours.white).boxDecoration(),
      child: PatternUtil.transformEmoji(
        message.text ?? '',
        TextStyle(color: Colours.black, fontSize: 32.sp),
      ),
    );
  }

  Widget videoPhoneItem() {
    return Row(
      children: [
        Text("视频通话 12:26",style: TextStyle(color: Colours.black,fontSize: 32.sp),),
        Image.asset(
          Utils.getChatImgPath("vedio_left"),
          width: 60.w,
          height: 60.w,
        ),
      ],
    );
  }
}
