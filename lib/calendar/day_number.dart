import 'package:flutter/material.dart';

import 'calendar_notification.dart';


class DayNumber extends StatefulWidget {
  const DayNumber({
    required this.size,
    required this.day,
    required this.isDefaultSelected,
    this.isToday = true,
    this.todayColor = Colors.blue,
  });

  final int day;
  final bool isToday;
  final Color todayColor;
  final double size;
  final bool isDefaultSelected;

  @override
  _DayNumberState createState() => _DayNumberState();
}

class _DayNumberState extends State<DayNumber> {
  final double itemMargin = 5.0;
  bool isSelected = false;

  Widget _dayItem() {
    return Container(
      width: widget.size - itemMargin * 2,
      height: widget.size - itemMargin * 2,
      margin: EdgeInsets.all(itemMargin),
      alignment: Alignment.center,
      decoration: (isSelected && widget.day > 0)
          ? BoxDecoration(color: Colors.blue)
          : widget.isToday ? BoxDecoration(color: widget.todayColor) : null,
      child: Text(
        widget.day < 1 ? '' : widget.day.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: (widget.isToday || isSelected) ? Colors.white : Colors.black87,
          fontSize: 15.0,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    isSelected = widget.isDefaultSelected;
    return widget.day > 0
        ? InkWell(
            onTap: () => CalendarNotification(widget.day).dispatch(context),
            child: _dayItem())
        : _dayItem();
  }
}
