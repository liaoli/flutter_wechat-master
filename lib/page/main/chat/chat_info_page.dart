import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wechat/core.dart';
import 'package:wechat/page/main/chat/widget/label_row.dart';

import '../../../language/strings.dart';
import '../../../widget/base_scaffold.dart';
import 'widget/chat_mamber.dart';


class ChatInfoPage extends StatefulWidget {
  static const String routeName = '/ChatInfoPage';

  final String id;

  ChatInfoPage({ this.id = ""});

  @override
  _ChatInfoPageState createState() => _ChatInfoPageState();
}

class _ChatInfoPageState extends State<ChatInfoPage> {
  var model;

  bool isRemind = false;
  bool isTop = false;
  bool isDoNotDisturb = true;

  Widget buildSwitch(item) {
    return  LabelRow(
      label: item['label'],
      labelWidth: 0,
      margin:   EdgeInsets.only(top: 10.0),
      isLine: item['label'] != '强提醒',
      isRight: false,
      rightW:  SizedBox(
        height: 25.0,
        child:  CupertinoSwitch(
          value: item['value'],
          onChanged: (v) {},
        ),
      ),
      onPressed: () {},
    );
  }

  List<Widget> body() {
    List switchItems = [
      {"label": '消息免打扰', 'value': isDoNotDisturb},
      {"label": '置顶聊天', 'value': isTop},
      {"label": '强提醒', 'value': isRemind},
    ];

    return [
       ChatMamBer(model: model),
       LabelRow(
        label: '查找聊天记录',
        margin: EdgeInsets.only(top: 10.0),
        onPressed: (){
          //TODO:
        },
      ),
       Column(
        children: switchItems.map(buildSwitch).toList(),
      ),
       LabelRow(
        label: '设置当前聊天背景',
        margin: EdgeInsets.only(top: 10.0),
        onPressed: (){
          //TODO:
        },
      ),
       LabelRow(
        label: '清空聊天记录',
        margin: EdgeInsets.only(top: 10.0),
        onPressed: () {
          // confirmAlert(
          //   context,
          //   (isOK) {
          //     if (isOK) showToast(context, '敬请期待');
          //   },
          //   tips: '确定删除群的聊天记录吗？',
          //   okBtn: '清空',
          // );
        },
      ),
       LabelRow(
        label: '投诉',
        margin: EdgeInsets.only(top: 10.0),
        onPressed: (){
          //TODO:
        },
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    getInfo();
  }

  getInfo() async {
    // final info = await getUsersProfile([widget.id]);
    // List infoList = json.decode(info);
    // setState(() {
    //   if (Platform.isIOS) {
    //     model = IPersonInfoEntity.fromJson(infoList[0]);
    //   } else {
    //     model = PersonInfoEntity.fromJson(infoList[0]);
    //   }
    // });


  }

  @override
  Widget build(BuildContext context) {
    return  MyScaffold(
      title: Ids.chat_info.str(),
      body:  SingleChildScrollView(
        child:  Column(children: body()),
      ),
    );
  }
}
