
// Collect all the code relating to building a custom horizontal calendar in one place
// if it remains unused this page is to be deleted

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// define calendar class
class Calendar {
  String day;
  int date;
  Calendar({required this.day, required this.date});
}

// initialise list of calendar objects
List cal = [
  Calendar(day: 'Mon', date: 21),
  Calendar(day: 'Tues', date: 22),
  Calendar(day: 'Wed', date: 23),
  Calendar(day: 'Thur', date: 24),
  Calendar(day: 'Fri', date: 25),
  Calendar(day: 'Sat', date: 26),
  Calendar(day: 'Sun', date: 27),
];



// define horizontal calendar widget
class HorizontalCalendarDisplay extends StatelessWidget {
  const HorizontalCalendarDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
          padding: EdgeInsets.fromLTRB(12.0, 0.0, 25.0, 24.0),
          scrollDirection: Axis.horizontal,
          itemCount: cal.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CalendarDate(calendar: cal[index]),
            );
          }
      ),
    );
  }
}


class CalendarDate extends StatelessWidget {
  final Calendar calendar;
  const CalendarDate({super.key, required this.calendar});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: calendar.day == 'Wed' ? Colors.blue[900]: Colors.white
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            calendar.date.toString(),
            style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: calendar.date == 23 ? Colors.white : Colors.black
            ),
          ),
          Text(
            calendar.day,
            style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: calendar.date == 23 ? Colors.white :Colors.black
            ),
          ),
        ],
      ),
    );
  }
}
