import 'package:flutter/material.dart';
import 'package:wechat/core.dart';

import '../color/colors.dart';
import 'calendar_notification.dart';

class DayNumber extends StatefulWidget {
  const DayNumber({
    required this.size,
    required this.day,
    required this.isDefaultSelected,
    this.isToday = true,
    this.todayColor = Colors.blue,
    this.hasChat = false,
    required this.onClick,
    this.chatIndex = -1,
    this.show = true,
  });

  final int day;
  final int chatIndex;
  final bool isToday;
  final Color todayColor;
  final double size;
  final bool isDefaultSelected;
  final bool hasChat;
  final bool show;
  final Function onClick;

  @override
  _DayNumberState createState() => _DayNumberState();
}

class _DayNumberState extends State<DayNumber> {
  final double itemMargin = 10.w;
  bool isSelected = false;

  Widget _dayItem() {
    return Column(
      children: [
        Container(
          width: widget.size - itemMargin * 2,
          height: widget.size - itemMargin * 2,
          margin: EdgeInsets.all(itemMargin),
          alignment: Alignment.center,
          decoration: widget.isToday
              ? BoxDecoration(
                  color: widget.todayColor,
                  borderRadius: BorderRadius.all(Radius.circular(30)))
              : null,
          child: Text(
              !widget.show?"":  widget.day < 1 ? '' : widget.day.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor(),
              fontSize: 40.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Text(
          widget.isToday ? "今天" : "",
          style: TextStyle(color: widget.todayColor, fontSize: 24.w),
        ),
      ],
    );
  }

  Color textColor() {
    if (widget.isToday) {
      return Colors.white;
    } else {
      if (widget.hasChat) {
        return Colors.black87;
      }
      return Colours.c_FFB9B9B9;
    }
  }

  @override
  Widget build(BuildContext context) {
    isSelected = widget.isDefaultSelected;
    return widget.day > 0
        ? InkWell(
            onTap: () {
              if (widget.hasChat) {
                widget.onClick.call(widget.chatIndex);
              }
              CalendarNotification(widget.day).dispatch(context);
            },
            child: _dayItem())
        : _dayItem();
  }
}
