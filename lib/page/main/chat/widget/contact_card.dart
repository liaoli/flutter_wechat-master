import 'package:flutter/material.dart';
import 'package:wechat/core.dart';

import '../../../../color/colors.dart';
import '../../../../widget/avatar_widget.dart';

class ContactCard extends StatelessWidget {
  final String img, title, nickName, id, area;
  final bool isBorder;
  final double lineWidth;

  ContactCard({
    this.img = "https://goerp.oss-cn-hongkong.aliyuncs.com/apk/erp/18200000002.jpeg",
    this.title="谭俊杰买湖景3-920",
    this.id="T-0329JunJie",
    this.nickName="Tang",
    this.area="广东 东莞",
    this.isBorder = false,
    this.lineWidth = 0.5,
  }) : assert(id != null);

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = TextStyle(fontSize: 14, color: Colours.c_FFE8E8E8);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: isBorder
            ? Border(
                bottom: BorderSide(color: Colours.line_color, width: lineWidth),
              )
            : null,
      ),
      width: ScreenUtilExt.getWidth(),
      padding: EdgeInsets.only(right: 15.0, left: 15.0, bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            child: AvatarWidget(
              avatar: img,
              weightWidth: 100.w,
            ),
            onTap: () {},
          ),
          SizedBox(width: 20.w,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    title ?? '未知',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                 SizedBox(width: 5.w,),
                  Image.asset('assets/images/Contact_Male.webp',
                      width: 20.0, fit: BoxFit.fill),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 3.0),
                child: Text("昵称：" + nickName ?? '', style: labelStyle),
              ),
              Text("微信号：" + id ?? '', style: labelStyle),
              Text("地区：" + area ?? '', style: labelStyle),
            ],
          )
        ],
      ),
    );
  }
}
