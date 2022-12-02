import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wechat/color/colors.dart';
import 'package:wechat/ext/decoration_ext.dart';
import 'package:wechat/ext/screen_util_ext.dart';
import 'package:wechat/ext/toast_ext.dart';
import 'package:wechat/page/main/chat/model/friend_item.dart';
import 'package:wechat/page/main/chat/widget/search_bar.dart';

import '../../../utils/utils.dart';
import 'model/search_friend_model.dart';

class SearchPage extends StatefulWidget {
  static const String routeName = '/SearchPage';

  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<SearchFriendModel> data = [];

  List words = [
    '朋友圈',
    '公众号',
    '小程序',
    '视频号',
  ];

  List hots = [
    "央媒头版：敬爱的江泽民同志永垂不朽",
    "北京天安门下半旗为江泽民志哀",
    "联合国安理会为江泽民默哀一分钟",
    "6位中国航天员会师太空",
    "卡塔尔和中国的时差",
    "告全党全军全国各族人民书",
  ];

  Widget wordView(item) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15.w),
        child: Text(
          item,
          style:
              TextStyle(color: Colours.c_FF6073FF, fontWeight: FontWeight.w700),
        ),
      ),
      onTap: () => '$item功能小编正在开发'.toast(),
    );
  }

  Widget hotView(item) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15.w),
        child: Text(
          item,
          style: TextStyle(color: Colours.c_FFA6A6A6),
        ),
      ),
      onTap: () => '$item功能小编正在开发'.toast(),
    );
  }

  Widget searchType() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.w),
            child: Text(
              '搜索指定内容',
              style: TextStyle(color: Colours.c_FFA7A7A7),
            ),
          ),
          Colours.c_FFE8E8E8.toLine(1.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: words.map(wordView).toList(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.w),
            child: Text(
              '搜索发现',
              style: TextStyle(color: Colours.c_FFC0C0C0),
            ),
          ),
          Colours.c_FFE8E8E8.toLine(1.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: hots.map(hotView).toList(),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    rootBundle.loadString('assets/json/search_friends.json').then((value) {
      List data = json.decode(value);
      this.data = data.map((e) => SearchFriendModel.fromMap(e)).toList();
    }).catchError((onError) {
      debugPrint("$onError");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          _models.isEmpty
              ? searchType()
              : MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: searchResult(),
                ),
        ],
      ),
    );
  }

  Widget searchResult() {
    return Expanded(
      child: CustomScrollView(
        slivers: [
          if (_models.isNotEmpty) contactHead(),
          if (_models.isNotEmpty) contact(),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 10.w,
            ),
          ),
          SearchRecordHead(),
        ],
      ),
    );
  }

  SliverToBoxAdapter contactHead() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colours.white,
        padding: EdgeInsets.only(left: 20.w, bottom: 0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w, bottom: 20.w, top: 20.w),
              child: Text(
                '联系人',
                style: TextStyle(color: Colours.c_FFC0C0C0, fontSize: 32.sp),
              ),
            ),
            Colours.c_CCCCCC.toLine(1.w),
          ],
        ),
      ),
    );
  }

  Widget contact() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        SearchFriendModel m = _models[index];

        return FriendItem(
          friend: m,
          searchText: _searchStr,
        );
      }, childCount: _models.length),
    );
  }

  SliverToBoxAdapter chatRecordHead() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colours.white,
        padding: EdgeInsets.only(left: 20.w, bottom: 0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w, bottom: 20.w, top: 20.w),
              child: Text(
                '聊天记录',
                style: TextStyle(color: Colours.c_FFC0C0C0, fontSize: 32.sp),
              ),
            ),
            Colours.c_CCCCCC.toLine(1.w),
          ],
        ),
      ),
    );
  }

  Widget chatRecord() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        SearchFriendModel m = _models[index];

        return FriendItem(
          friend: m,
          searchText: _searchStr,
        );
      }, childCount: _models.length),
    );
  }

  SliverToBoxAdapter SearchRecordHead() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colours.white,
        padding: EdgeInsets.only(left: 40.w, bottom: 0.w, right: 30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  Utils.getImgPath('search_more', dir: 'chat'),
                  width: 60.w,
                  height: 60.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 10.w,
                        ),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "搜索 ",
                              ),
                              TextSpan(
                                style: TextStyle(
                                    color: Colours.theme_color,
                                    fontSize: 40.sp),
                                text: _searchStr,
                              ),
                            ],
                          ),
                          style:
                              TextStyle(color: Colours.black, fontSize: 40.sp),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Text(
                          '小程序、公众号、文章、朋友圈和表情等',
                          style: TextStyle(
                              color: Colours.c_FFC0C0C0, fontSize: 32.sp),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 30.w,
                  color: Colours.c_FFC0C0C0,
                ),
              ],
            ),
            Colours.c_CCCCCC.toLine(1.w),
          ],
        ),
      ),
    );
  }

  //满足查找条件的数据数组
  List<SearchFriendModel> _models = [];

  //正在搜索的内容
  String _searchStr = '';

  // 搜索数据查找
  void _searchData(String text) {
    //每次搜索前先清空
    _models.clear();
    _searchStr = text;
    if (text.length < 1) {
      setState(() {});
      return;
    }
    for (int i = 0; i < data.length; i++) {
      String name = data[i].nikeName;
      String phone = data[i].phone;
      if (name.contains(text) || phone.contains(text)) {
        _models.add(data[i]);
      }
    }
    setState(() {});
  }
}
