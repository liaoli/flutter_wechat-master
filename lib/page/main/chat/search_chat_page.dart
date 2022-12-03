import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leancloud_official_plugin/leancloud_plugin.dart';
import 'package:wechat/ext/screen_util_ext.dart';

import '../../../calendar/fullscreen_calendar.dart';
import '../../../color/colors.dart';
import '../../../widget/base_scaffold.dart';
import 'widget/search_bar.dart';


class SearchChatPage extends StatefulWidget {
  static const String routeName = '/SearchChatPage';

  List<Message> message ;

  SearchChatPage({Key? key,this.message = const []}):super(key: key);

  @override
  _SearchChatPageState createState() => _SearchChatPageState();
}

class _SearchChatPageState extends State<SearchChatPage> {

  List words = ['日期', '图片及视频', '文件', '链接', "音乐", "交易", "小程序"];

  Widget wordView(item) {
    return InkWell(
      child: Container(
        width: ScreenUtilExt.getWidth() / 4,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 15.w),
        child: Text(
          item,
          style: TextStyle(
              color: Colours.c_FF6073FF, fontWeight: FontWeight.w400),
        ),
      ),
      onTap: () {

        switch (item){
          case "日期":
            Get.to(() =>FullScreenCalendar(message: widget.message,));
            break;
          default:
            break;
        }

      },
    );
  }

  // Widget body() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: <Widget>[
  //       Padding(
  //         padding: EdgeInsets.symmetric(vertical: 60.w),
  //         child: Text(
  //           '搜索指定内',
  //           style: TextStyle(color: Colours.c_FFA7A7A7),
  //         ),
  //       ),
  //       SizedBox(height: 100.w,),
  //       Wrap(
  //         children: words.map(wordView).toList(),
  //       )
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      showAppbar: false,
      body: Column(
        children: [
          SizedBox(
            height: ScreenUtilExt.getStatusBarHeight(),
          ),
          SearchBar(
            onChanged: (String text) {
              // _searchStr = text;
              _searchData(text);
            },
          ),
          searchType()
        ],
      ),
    );
  }


  Widget searchType() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 80.w,bottom: 30.w),
            child: Text(
              '搜索指定内容',
              style: TextStyle(color: Colours.c_FFA7A7A7),
            ),
          ),
          Wrap(
            children: words.map(wordView).toList(),
          )
        ],
      ),
    );
  }

  void _searchData(String text) {}
}
