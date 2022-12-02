import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wechat/color/colors.dart';
import 'package:wechat/ext/decoration_ext.dart';
import 'package:wechat/ext/screen_util_ext.dart';
import 'package:wechat/ext/toast_ext.dart';
import 'package:wechat/page/main/chat/model/friend_item.dart';
import 'package:wechat/page/main/chat/widget/search_bar.dart';

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
          contact(),
        ],
      ),
    );
  }

  Widget _sliverListItemWidget() {
    return Column(
      children: [
        Text("好友"),
        Expanded(
          child: contact(),
        ),
      ],
    );
  }

  Widget contact() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        SearchFriendModel m = _models[index];

        return FriendItem(friend: m,searchText: _searchStr,);
      }, childCount: _models.length),
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
