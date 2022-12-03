import 'package:flutter/material.dart';
import 'package:leancloud_official_plugin/leancloud_plugin.dart';

import 'calendar_list.dart';

class FullScreenCalendar extends StatefulWidget {
  List<Message> message ;
  FullScreenCalendar({Key? key,this.message = const []}) : super(key: key);

  @override
  _FullScreenCalendarState createState() => new _FullScreenCalendarState();
}

class _FullScreenCalendarState extends State<FullScreenCalendar> {
  @override
  Widget build(BuildContext context) {
    DateTime first = DateTime.now().subtract(Duration(days: 30));
    if(widget.message.isNotEmpty){
      first =DateTime.fromMillisecondsSinceEpoch(widget.message.last.sentTimestamp!*1000);
    }


    DateTime last = DateTime.now();



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
