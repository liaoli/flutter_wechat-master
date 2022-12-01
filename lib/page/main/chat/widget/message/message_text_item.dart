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
    if (message.text!.contains("通话时长") || message.text!.contains("对方已取消")) {

       double w = 320.w;

       if(message.text!.contains("对方已取消")){
         w = 260.w;
       }

      return Container(
        constraints: BoxConstraints(maxWidth: w),
        padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 10.w),
        decoration:
            (message.isSend ? Colours.c_98E165 : Colours.white).boxDecoration(),
        child: videoPhoneItem(),
      );
    }

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
    if (!message.isSend) {
      return Row(
        children: [
          Image.asset(
            Utils.getChatImgPath("phone"),
            width: 40.w,
            height: 40.w,
          ),
          SizedBox(width: 20.w,),
          Text(
            message.text ?? "",
            style: TextStyle(color: Colours.black, fontSize: 32.sp),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          message.text ?? "",
          style: TextStyle(color: Colours.black, fontSize: 32.sp),
        ),
        Image.asset(
          Utils.getChatImgPath("phone"),
          width: 40.w,
          height: 40.w,
        ),
      ],
    );
  }
}
