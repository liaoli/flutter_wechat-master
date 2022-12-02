import 'package:flutter/material.dart';

import 'utils/dates.dart';

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
      child: Text(
        "$year年$month月",
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
        ),
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: false,
      ),
    );
  }
}
