import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {});
  test();
}

Future<void> test() async {
  var jsonChat = await rootBundle.loadString('assets/json/xiaojie_chat.json');
  List data = json.decode(jsonChat);

  jsonChat = await rootBundle.loadString('assets/json/tang_time.json');
  Map tMap = json.decode(jsonChat);

  List timeList = tMap["time"];

  for (int i = 0; i < data.length; i++) {
    Map e = data[i];
    // String t = timeList[i];
    int type = e["typeMsgData"]["_lctype"];

    String from = e["from"];
    String message = "";

    String time =  e["time"];

    DateTime? dtime = DateTime.tryParse(time);

     e["timestamp"] = dtime?.millisecondsSinceEpoch;

     e["timestamp"] =  (e["timestamp"] / 1000).toInt();

    if (from == "+8618200000000") {
      from = "amy";
    } else {
      from = "xiaojie";
    }

    switch (type) {
      case -4:
      case -2:
        message = e["typeMsgData"]["_lcfile"]["url"];
        break;
      case -1:
        message = e["typeMsgData"]["_lctext"];
        break;
    }

    print("$from : $message ----- \n\n");
    // print("$from : $message ----- $t\n\n");
  }

  String s = json.encode(data);

  print(s);
  print(s);
}
