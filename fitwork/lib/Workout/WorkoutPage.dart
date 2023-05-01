import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

// import 'package:table_calendar/table_calendar';
///-------------------------------------Workout Page -------------------------------------///
class Workout extends StatefulWidget {
  const Workout({Key? key}) : super(key: key);

  @override
  State<Workout> createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  Future _showCalendar() async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2500),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              // brightness: Colors.deepOrange,
              primary: Color(0xff5FB28B),
              onSecondary: Color(0xff5FB28B),
            ),
          ),
          child: child!,
        );
      },
    );
  }

  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          ElevatedButton(onPressed: _showCalendar, child: Text('SELECT DATE')),
          Container(
            child: TableCalendar(
              locale: "en_US",

              rowHeight: 50,
              headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, today),
              focusedDay: today,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              onDaySelected: _onDaySelected,
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: Color(0xff5FB28B),
                  shape: BoxShape.circle
                ),
                todayDecoration: BoxDecoration(
                  color: Color(0xff3C6B62),
                  shape: BoxShape.circle
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}
