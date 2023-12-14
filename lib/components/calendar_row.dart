

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/homepage.dart';

class CalendarRow extends StatelessWidget {
  final Calendar calendar;
  const CalendarRow({super.key, required this.calendar});

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
