import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leancloud_official_plugin/leancloud_plugin.dart';
import 'package:wechat/core.dart';
import 'package:wechat/page/main/chat/chat_2_page.dart';

import '../color/colors.dart';
import '../page/main/chat/chat_page.dart';
import '../utils/navigator_utils.dart';
import 'calendar_notification.dart';
import 'day_number.dart';
import 'month_title.dart';
import 'utils/dates.dart';
import 'utils/screen_sizes.dart';

class MonthView extends StatefulWidget {
  const MonthView(
      {required this.context,
      required this.year,
      required this.month,
      required this.padding,
      this.dateTimeStart,
      this.dateTimeEnd,
      required this.onSelectDayRang,
      this.todayColor = Colors.blue,
      this.monthNames,
      this.messages = const []});

  final BuildContext context;
  final int year;
  final int month;
  final double padding;
  final Color todayColor;
  final List<String>? monthNames;
  final DateTime? dateTimeStart;
  final DateTime? dateTimeEnd;
  final Function onSelectDayRang;
  final List<Message> messages;

  double get itemWidth => getDayNumberSize(context, padding);

  @override
  _MonthViewState createState() => _MonthViewState();
}

class _MonthViewState extends State<MonthView> {
  DateTime? selectedDate;

  Widget buildMonthDays(BuildContext context) {
    List<Row> dayRows = <Row>[];
    List<DayNumber> dayRowChildren = <DayNumber>[];

    int daysInMonth = getDaysInMonth(widget.year, widget.month);

    // 日 一 二 三 四 五 六
    int firstWeekdayOfMonth = DateTime(widget.year, widget.month, 2).weekday;

    for (int day = 2 - firstWeekdayOfMonth; day <= daysInMonth; day++) {
      DateTime moment = DateTime(widget.year, widget.month, day);
      final bool isToday = dateIsToday(moment);

      bool isDefaultSelected = false;
      if (widget.dateTimeStart == null &&
          widget.dateTimeEnd == null &&
          selectedDate == null) {
        isDefaultSelected = false;
      }
      if (widget.dateTimeStart == selectedDate &&
          widget.dateTimeEnd == null &&
          selectedDate?.day == day &&
          day > 0) {
        isDefaultSelected = true;
      }
      if (widget.dateTimeStart != null && widget.dateTimeEnd != null) {
        isDefaultSelected = (moment.isAtSameMomentAs(widget.dateTimeStart!) ||
                    moment.isAtSameMomentAs(widget.dateTimeEnd!)) ||
                moment.isAfter(widget.dateTimeStart!) &&
                    moment.isBefore(widget.dateTimeEnd!) &&
                    day > 0
            ? true
            : false;
      }
      bool show = true;
      DateTime dateTime =  DateTime.now();
      if(dateTime.year == moment.year && dateTime.month == moment.month && day > dateTime.day){
        show = false;
      }

      int index = checkChat(widget.year, widget.month, day);
      bool hasCaht = index >0;
      dayRowChildren.add(
        DayNumber(
          hasChat: hasCaht,
          chatIndex: index,
          size: widget.itemWidth,
          show:show,
          day: day,
          isToday: isToday,
          isDefaultSelected: isDefaultSelected,
          todayColor: widget.todayColor,
          onClick: (int index) {
            // NavigatorUtils.toNamed(ChatPage.routeName,
            //     arguments: {"id":"62d6797b4fbbaa8db413b7235","index":index});

            Get.to(() =>Chat2Page(message: widget.messages,index: index,title: "小杰",));
          },
        ),
      );

      if ((day - 1 + firstWeekdayOfMonth) % DateTime.daysPerWeek == 0 ||
          day == daysInMonth) {
        dayRows.add(
          Row(
            children: List<DayNumber>.from(dayRowChildren),
          ),
        );
        dayRowChildren.clear();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: dayRows,
    );
  }

  Widget buildMonthView(BuildContext context) {
    return NotificationListener<CalendarNotification>(
        onNotification: (notification) {
          selectedDate =
              DateTime(widget.year, widget.month, notification.selectDay);
          widget.onSelectDayRang(selectedDate);
          return true;
        },
        child: Container(
          color: Colours.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MonthTitle(
                year: widget.year,
                month: widget.month,
                monthNames: widget.monthNames,
              ),
              Colours.line.toLine(0.5),
              Container(
                width: 7 * getDayNumberSize(context, widget.padding),
                padding: EdgeInsets.symmetric(horizontal: widget.padding),
                margin: const EdgeInsets.only(top: 4.0),
                child: buildMonthDays(context),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildMonthView(context),
    );
  }

  int checkChat(int year, int month, int day) {
    int result = -1;
    for (int i = 0; i < widget.messages.length; i++) {
      Message m = widget.messages[i];
      DateTime d = DateTime.fromMillisecondsSinceEpoch(m.sentTimestamp! * 1000);
      if (year == d.year && month == d.month && day == d.day) {

        result = i;
      }
    }

    return result;
  }

  List<Message> msg = [];

  @override
  void initState() {
    msg = widget.messages.toList();
  }
}
