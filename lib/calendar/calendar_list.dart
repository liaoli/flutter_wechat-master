library calendar_list;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:leancloud_official_plugin/leancloud_plugin.dart';
import 'package:wechat/color/colors.dart';
import 'package:wechat/core.dart';

import '../widget/base_scaffold.dart';
import 'month_view.dart';
import 'weekday_row.dart';

class CalendarList extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final Function? onSelectFinish;

  CalendarList(
      {required this.firstDate,
      required this.lastDate,
      this.onSelectFinish,
      this.selectedStartDate,
      this.selectedEndDate})
      : assert(firstDate != null),
        assert(lastDate != null),
        assert(!firstDate.isAfter(lastDate),
            'lastDate must be on or after firstDate');

  @override
  _CalendarListState createState() => _CalendarListState();
}

class _CalendarListState extends State<CalendarList> {
  final double HORIZONTAL_PADDING = 50.w;
  DateTime? selectStartTime;
  DateTime? selectEndTime;
  late int yearStart;
  late int monthStart;
  late int yearEnd;
  late int monthEnd;
  late int count;

  List<Message> messages = [];

  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    // 传入的开始日期
    selectStartTime = widget.selectedStartDate;
    // 传入的结束日期
    selectEndTime = widget.selectedEndDate;
    yearStart = widget.firstDate.year;
    monthStart = widget.firstDate.month;
    yearEnd = widget.lastDate.year;
    monthEnd = widget.lastDate.month;
    count = monthEnd - monthStart + (yearEnd - yearStart) * 12 + 1;


     getMessage();

    SchedulerBinding.instance.addPostFrameCallback((_) { //build完成后的回调
      scrollController.jumpTo(
        scrollController.position.maxScrollExtent,//滚动到底部
      );
    });
  }

  Future<void> getMessage() async {
     var jsonChat =
        await rootBundle.loadString('assets/json/xiaojie_all_2.json');
    List data = json.decode(jsonChat);

    List<Message> _messages = data.map((e) {
      return Message.instanceFrom(
        e,
      );
    }).toList();
    messages.clear();
    messages.addAll(_messages.reversed);
  }

  // 选项处理回调
  void onSelectDayChanged(dateTime) {
    if (selectStartTime == null && selectEndTime == null) {
      selectStartTime = dateTime;
    } else if (selectStartTime != null && selectEndTime == null) {
      selectEndTime = dateTime;
      // 如果选择的开始日期和结束日期相等，则清除选项
      if (selectStartTime == selectEndTime) {
        setState(() {
          selectStartTime = null;
          selectEndTime = null;
        });
        return;
      }
      // 如果用户反选，则交换开始和结束日期
      if (selectStartTime!.isAfter(selectEndTime!)) {
        DateTime temp = selectStartTime!;
        selectStartTime = selectEndTime;
        selectEndTime = temp;
      }
    } else if (selectStartTime != null && selectEndTime != null) {
      selectStartTime = null;
      selectEndTime = null;
      selectStartTime = dateTime;
    }
    setState(() {
      selectStartTime;
      selectEndTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  MyScaffold(
      title: "查找聊天记录",
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 55.0,
              child: Container(
                padding: EdgeInsets.only(
                    left: HORIZONTAL_PADDING, right: HORIZONTAL_PADDING),
                decoration: BoxDecoration(
                  // border: Border.all(width: 3, color: Color(0xffaaaaaa)),
                  // 实现阴影效果
                  color: Colours.c_FFF8F6F8,
                  // boxShadow: [
                  //   BoxShadow(
                  //       color: Colors.black12,
                  //       offset: Offset(0, 2.0),
                  //       blurRadius: 1.0)
                  // ],
                ),
                child: WeekdayRow(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 55.0,),
              child: CustomScrollView(
                controller: scrollController,
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        int month = index + monthStart;
                        DateTime calendarDateTime = DateTime(yearStart, month);
                        return _getMonthView(calendarDateTime,messages);
                      },
                      childCount: count,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _finishSelect() {

      widget.onSelectFinish!.call(selectStartTime, selectEndTime);

  }

  Widget _getMonthView(DateTime dateTime,List<Message> messages) {
    int year = dateTime.year;
    int month = dateTime.month;
    return MonthView(
      context: context,
      messages: messages,
      year: year,
      month: month,
      padding: HORIZONTAL_PADDING,
      dateTimeStart: selectStartTime,
      dateTimeEnd: selectEndTime,
      todayColor: Colours.theme_color,
      onSelectDayRang: (dateTime) => onSelectDayChanged(dateTime),
    );
  }
}
