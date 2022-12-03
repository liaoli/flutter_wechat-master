import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:wechat/core.dart';
import 'package:wechat/page/main/chat/chat_page.dart';
import 'package:wechat/page/main/chat/model/search_friend_model.dart';
import 'package:wechat/page/main/contacts/friend_detail_page.dart';
import 'package:wechat/widget/tap_widget.dart';

import '../../../../color/colors.dart';
import '../../../../utils/navigator_utils.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/avatar_widget.dart';

class FriendItem extends StatelessWidget {
  String searchText;
  SearchFriendModel friend;
  int? selectType;

  ///0未选中 1选中 -1 不可选中
  ValueChanged<SearchFriendModel>? onTap;

  FriendItem(
      {required this.friend,
      this.selectType,
      this.onTap,
      required this.searchText,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TapWidget(
      onTap: () {
        if (onTap != null) {
          if (selectType != -1) {
            onTap?.call(friend);
          }
        } else {
          NavigatorUtils.toNamed(ChatPage.routeName,arguments: {"id":"62d6797b4fbbaa8db413b7235","index":0});
        }
      },
      child: Column(
        children: [
          Container(
            height: 100.w,
            color: Colours.white,
            margin: EdgeInsets.only(bottom: 1.w),
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AvatarWidget(
                  avatar: friend.avatar,
                  weightWidth: 80.w,
                ),
                20.sizedBoxW,
                Expanded(
                    // child: Text(friend.nikeName??'name',style: TextStyle(color: Colours.black,fontSize: 32.sp),),
                    child: _text(friend.nikeName)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _normalStyle = TextStyle(
    fontSize: 32.sp,
    color: Colors.black,
  );
  TextStyle _hightlightedStyle = TextStyle(
    fontSize: 32.sp,
    color: Colors.green,
  );

  Widget _text(String name) {
    List<TextSpan> textSpans = [];

    List<String> searchStrs = name.split(searchText);
    for (int i = 0; i < searchStrs.length; i++) {
      String str = searchStrs[i];
      if (str == '' && i < searchStrs.length - 1) {
        textSpans.add(TextSpan(text: searchText, style: _hightlightedStyle));
      } else {
        textSpans.add(TextSpan(text: str, style: _normalStyle));
        if (i < searchStrs.length - 1) {
          textSpans.add(TextSpan(text: searchText, style: _hightlightedStyle));
        }
      }
    }
    return RichText(text: TextSpan(children: textSpans));
  }
}
