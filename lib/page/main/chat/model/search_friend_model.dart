// To parse this JSON data, do
//
//     final searchFriendModel = searchFriendModelFromMap(jsonString);

import 'dart:convert';

class SearchFriendModel {
  SearchFriendModel({
    required this.nikeName,
    required this.phone,
  });

  String nikeName;
  String phone;

  factory SearchFriendModel.fromJson(String str) =>
      SearchFriendModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SearchFriendModel.fromMap(Map<String, dynamic> json) =>
      SearchFriendModel(
        nikeName: json["nike_name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toMap() => {
        "nike_name": nikeName,
        "phone": phone,
      };
}
