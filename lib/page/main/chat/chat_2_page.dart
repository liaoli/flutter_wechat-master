import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:leancloud_official_plugin/leancloud_plugin.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:wechat/core.dart';
import 'package:wechat/page/main/chat/chat_info_page.dart';
import 'package:wechat/page/main/chat/widget/chat_input_widget.dart';
import 'package:wechat/page/main/chat/widget/message/message_item.dart';
import 'package:wechat/page/main/chat/widget/record_preview_widget.dart';

import '../../../color/colors.dart';
import '../../../utils/utils.dart';
import '../../../widget/base_scaffold.dart';
import '../../../widget/refresh/refresh_widget.dart';
import '../../../widget/tap_widget.dart';

class Chat2Page extends StatefulWidget {
  final List<Message> message;
  final String title;
  final int index;

  const Chat2Page(
      {Key? key, this.message = const [], this.title = "", this.index = -1})
      : super(key: key);

  @override
  State<Chat2Page> createState() => _Chat2PageState();
}

class _Chat2PageState extends State<Chat2Page> {
  final AutoScrollController listScrollerController =
      AutoScrollController(keepScrollOffset: false);

  bool show = true;
  List<Message> message = [];

  void initState() {
    message = widget.message.sublist(0, widget.index + 1);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      //build完成后的回调
      scrollController.jumpTo(
        scrollController.position.maxScrollExtent * 2, //滚动到底部
      );
      // listScrollerController.scrollToIndex(widget.index);
      Future.delayed(Duration(milliseconds: 2000), () {
        List<Message> _msg = widget.message.sublist(widget.index + 1);
        message.addAll(_msg);
        setState(() {});
      });
    });
    super.initState();
  }

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: widget.title,
      body: _buildBody(context),
      actions: [
        TapWidget(
            onTap: () async {
              Get.to(() => ChatInfoPage(
                    message: widget.message,
                  ));
            },
            child: Image.asset(
              Utils.getImgPath(
                'ic_more_black',
                dir: Utils.DIR_ICON,
              ),
              width: 40.w,
              height: 40.w,
            ))
      ],
    );
  }

  _buildBody(BuildContext context) {
    return Column(
      children: [
        _buildContent(),
        const ChatInputWidget(),
      ],
    );
  }

  _buildContent() {
    return Expanded(
        child: Stack(
      children: [
        Container(
          color: Colours.c_EEEEEE,

          ///聊天列表需要反转，方便滚动到底部
          child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemBuilder: (context, index) {
              return MessageItem(
                message: message[index],
                lastMessage: safetyItem(index + 1),
              );
              // return AutoScrollTag(
              //     controller: listScrollerController,
              //     index: index,
              //     key: ValueKey(index),
              //     child: MessageItem(
              //       message: widget.message[index],
              //       lastMessage: safetyItem(index + 1),
              //     ));
            },
            itemCount: message.length,
            controller: scrollController,
            reverse: true,
          ),
        ),
        RecordPreviewWidget(),
      ],
    ));
  }

  Message? safetyItem(int index) {
    if (index < 0 || index > message.length - 1) {
      return null;
    }
    return message[index];
  }
}
