import 'package:flutter/material.dart';

import 'calendar_list.dart';

class FullScreenCalendar extends StatefulWidget {
  FullScreenCalendar({Key? key}) : super(key: key);

  @override
  _FullScreenCalendarState createState() => new _FullScreenCalendarState();
}

class _FullScreenCalendarState extends State<FullScreenCalendar> {
  @override
  Widget build(BuildContext context) {

    DateTime first = DateTime.now().subtract(Duration(days: 30));

    DateTime last = DateTime.now().add(Duration(days: 60));

    return CalendarList(
      firstDate: first,
      lastDate: last,
     // selectedStartDate: DateTime(2019, 8, 28),
     // selectedEndDate: DateTime(2019, 9, 2),
      onSelectFinish: (selectStartTime, selectEndTime) {
        List<DateTime> result = <DateTime>[];
        result.add(selectStartTime);
        if (selectEndTime != null) {
          result.add(selectEndTime);
        }
        Navigator.pop(context, result);
      },
    );
  }
}
