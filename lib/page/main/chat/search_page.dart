import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wechat/ext/screen_util_ext.dart';
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
          Expanded(
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView.builder(
                  itemCount: _models.length,
                  itemBuilder: (context, i) {
                    SearchFriendModel m = _models[i];
                    return Container(
                      child: Column(
                        children: [
                          _searchTitle(m.nikeName),
                          _searchTitle(m.phone),
                        ],
                      ),
                    );
                  }),
            ),
          )
        ],
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

  TextStyle _normalStyle = TextStyle(
    fontSize: 16,
    color: Colors.black,
  );
  TextStyle _hightlightedStyle = TextStyle(
    fontSize: 16,
    color: Colors.green,
  );

  Widget _searchTitle(String name) {
    List<TextSpan> textSpans = [];

    List<String> searchStrs = name.split(_searchStr);
    for (int i = 0; i < searchStrs.length; i++) {
      String str = searchStrs[i];
      if (str == '' && i < searchStrs.length - 1) {
        textSpans.add(TextSpan(text: _searchStr, style: _hightlightedStyle));
      } else {
        textSpans.add(TextSpan(text: str, style: _normalStyle));
        if (i < searchStrs.length - 1) {
          textSpans.add(TextSpan(text: _searchStr, style: _hightlightedStyle));
        }
      }
    }
    return RichText(text: TextSpan(children: textSpans));
  }
}
