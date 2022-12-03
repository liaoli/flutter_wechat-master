import 'package:flutter/material.dart';
import 'package:wechat/color/colors.dart';
import 'package:wechat/core.dart';


class MonthTitle extends StatelessWidget {
  const MonthTitle({
    required this.month,
    required this.year,

    this.monthNames,
  });

  final int month;
  final int year;
  final List<String>? monthNames;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 25),
      child: Text(
        "$year年$month月",
        style: TextStyle(
          color: Colours.c_FFB9B9B9,
          fontSize: 36.w,
          fontWeight: FontWeight.w400,
        ),
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: false,
      ),
    );
  }
}
