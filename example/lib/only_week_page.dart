import 'package:flutter/material.dart';
import 'package:flutter_custom_calendar/flutter_custom_calendar.dart';

/**
 * 默认风格+单选
 */
class OnlyWeekPage extends StatefulWidget {
  OnlyWeekPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _OnlyWeekPageState createState() => _OnlyWeekPageState();
}

class _OnlyWeekPageState extends State<OnlyWeekPage> {
  ValueNotifier<String> text;
  ValueNotifier<String> selectText;

  CalendarController controller;

  @override
  void initState() {
    DateTime now = DateTime.now();
    controller = new CalendarController(
        minYear: now.year,
        minYearMonth: now.month - 2,
        maxYear: now.year,
        maxYearMonth: now.month + 1,
        showMode: CalendarConstants.MODE_SHOW_ONLY_WEEK);

    controller.addMonthChangeListener(
      (year, month) {
        text.value = "$year年$month月";
      },
    );

    controller.addOnCalendarSelectListener((dateModel) {
      //刷新选择的时间
      selectText.value =
          "单选模式\n选中的时间:\n${controller.getSingleSelectCalendar()}";
    });

    text = new ValueNotifier("${DateTime.now().year}年${DateTime.now().month}月");

    selectText = new ValueNotifier(
        "单选模式\n选中的时间:\n${controller.getSingleSelectCalendar()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new IconButton(
                    icon: Icon(Icons.navigate_before),
                    onPressed: () {
//                      controller.moveToPreviousMonth();
                      controller.previousPage();
                    }),
                ValueListenableBuilder(
                    valueListenable: text,
                    builder: (context, value, child) {
                      return new Text(text.value);
                    }),
                new IconButton(
                    icon: Icon(Icons.navigate_next),
                    onPressed: () {
//                      controller.moveToNextMonth();
                      controller.nextPage();
                    }),
              ],
            ),
            CalendarViewWidget(
              calendarController: controller,
            ),
            ValueListenableBuilder(
                valueListenable: selectText,
                builder: (context, value, child) {
                  return new Text(selectText.value);
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.toggleExpandStatus();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
