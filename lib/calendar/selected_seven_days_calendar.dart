import 'package:flutter/material.dart';

import 'calendar_list.dart';

class FullScreenCalendar extends StatefulWidget {
  DateTime? firstDate;

  DateTime? lastDate;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  FullScreenCalendar(
      {Key? key,
      this.firstDate,
      this.lastDate,
      this.selectedStartDate,
      this.selectedEndDate})
      : super(key: key);

  @override
  _FullScreenCalendarState createState() => new _FullScreenCalendarState();
}

class _FullScreenCalendarState extends State<FullScreenCalendar> {
   DateTime? first;

  DateTime last = DateTime.now();

  late DateTime selectedStartDate;

  late DateTime selectedEndDate;

  @override
  void initState() {
    if (widget.firstDate != null) {
      first = widget.firstDate;
    } else {
      first = DateTime.now().subtract(Duration(days: 30));
    }
    if (widget.lastDate != null) {
      last = widget.lastDate!;
    } else {
      last = DateTime.now();
    }

    if (widget.selectedEndDate != null) {
      selectedEndDate = widget.selectedEndDate!;
    } else {
      selectedEndDate = DateTime.now();
    }

    if (widget.selectedStartDate != null) {
      selectedStartDate = widget.selectedStartDate!;
    } else {
      selectedStartDate = selectedStartDate.subtract(Duration(days: 7));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CalendarList(
      firstDate: first!,
      lastDate: last,
      selectedStartDate: selectedStartDate,
      selectedEndDate: selectedEndDate,
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
