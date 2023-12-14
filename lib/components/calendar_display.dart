import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarDisplay extends StatefulWidget {
  const CalendarDisplay({super.key});

  @override
  State<CalendarDisplay> createState() => _CalendarDisplayState();
}

class _CalendarDisplayState extends State<CalendarDisplay> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
      child: Container(
        height: 330,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.black,
        ),
        child: TableCalendar(
          focusedDay: today,
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          rowHeight: 40,
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              color: Colors.white70
            ),
            leftChevronIcon: const Icon(
              color: Colors.white70,
              Icons.chevron_left
            ),
            rightChevronIcon: const Icon(
                color: Colors.white70,
                Icons.chevron_right
            ),
          ),

          // headerStyle: HeaderStyle(
          //     titleCentered: true,
          //     titleTextFormatter: (date, locale) => DateFormat.yMMM(locale).format(date),
          //     formatButtonVisible: false,
          //     titleTextStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.007)
          // )
          availableGestures:  AvailableGestures.all,
          selectedDayPredicate: (day) => isSameDay(day, today),
          onDaySelected: _onDaySelected,
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: GoogleFonts.montserrat(
              fontSize: 13,
              color: Colors.white70
            ),
            weekendStyle: GoogleFonts.montserrat(
              fontSize: 13,
              color: Colors.white70

            ),
          ),
          calendarStyle: CalendarStyle(
              todayTextStyle: GoogleFonts.montserrat(
                  fontSize: 12,
              ),
              weekendTextStyle: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70

              ),
              outsideTextStyle: GoogleFonts.montserrat(
                  fontSize: 12,
                fontWeight: FontWeight.w100,
                color: Colors.white70


              ),
              defaultTextStyle: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70

              )
          ),

        )
      ),
    );
  }
}