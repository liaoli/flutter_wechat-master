import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:wechat/color/colors.dart';
import 'package:wechat/page/main/chat/widget/button_row.dart';
import 'package:wechat/page/main/chat/widget/contact_card.dart';
import 'package:wechat/page/main/chat/widget/label_row.dart';

import '../../../utils/navigator_utils.dart';
import '../../../widget/base_scaffold.dart';
import 'chat_page.dart';

class ContactsDetailsPage extends StatefulWidget {
  final String avatar, title, id;

  ContactsDetailsPage({this.avatar = "", this.title = "", this.id =""});

  @override
  _ContactsDetailsPageState createState() => _ContactsDetailsPageState();
}

class _ContactsDetailsPageState extends State<ContactsDetailsPage> {
  List<Widget> body(bool isSelf) {
    return [
      ContactCard(
        isBorder: true,
      ),
      Visibility(
        visible: true,
        child: LabelRow(
          label: '设置备注和标签',
          onPressed: () {},
        ),
      ),
      LabelRow(
        label: '朋友权限',
        isLine: true,
        lineWidth: 0.3,
        onPressed: () {},
      ),
      SizedBox(
        height: 10,
      ),
      LabelRow(
        label: '朋友圈',
        isLine: true,
        lineWidth: 0.3,
        onPressed: () {},
      ),
      LabelRow(
        label: '更多信息',
        onPressed: () {},
      ),
      ButtonRow(
        margin: EdgeInsets.only(top: 10.0),
        text: '发消息',
        isBorder: true,
        onPressed: () {
          NavigatorUtils.toNamed(ChatPage.routeName,arguments: {"id":"62d6797b4fbbaa8db413b7235","index":-1});
        },
      ),
      Visibility(
        visible: true,
        child: ButtonRow(
          text: '音视频通话',
          onPressed: () {},
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appbarColor: Colours.white,
      body: SingleChildScrollView(
        child: Column(children: body(true)),
      ),
    );
  }
}
