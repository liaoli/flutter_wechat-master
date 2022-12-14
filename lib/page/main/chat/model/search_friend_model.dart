// To parse this JSON data, do
//
//     final searchFriendModel = searchFriendModelFromMap(jsonString);

import 'dart:convert';

import 'package:leancloud_official_plugin/leancloud_plugin.dart';

class SearchFriendModel {
  SearchFriendModel({
    required this.message,
    required this.nikeName,
    required this.phone,
    required this.avatar,
  });

  List<dynamic> message;
  String nikeName;
  String phone;
  String avatar;
  factory SearchFriendModel.fromJson(String str) =>
      SearchFriendModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SearchFriendModel.fromMap(Map<String, dynamic> json) {


   List<dynamic> message = json["message"].map((e) {
      return Message.instanceFrom(
        e,
      );
    }).toList();
    return SearchFriendModel(
      nikeName: json["nike_name"],
      phone: json["phone"],
      message: message,
      avatar: json["avatar"]
    );
  }

  Map<String, dynamic> toMap() => {
        "nike_name": nikeName,
        "phone": phone,
        "avatar": avatar,
      };
}
