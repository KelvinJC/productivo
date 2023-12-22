import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/calendar/view_models/calendar_view_model.dart';

class StartCalendar extends StatelessWidget {
  const StartCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    CalendarViewModel calendarViewModel = context.watch<CalendarViewModel>();
    DateTime today = calendarViewModel.startCalCurrentDay;

    return TableCalendar(
      focusedDay: today,
      firstDay: DateTime.utc(2020, 10, 16),
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

      availableGestures: AvailableGestures.horizontalSwipe, // instead of AvailableGestures.all,
                                                            // enables vertical scrolling of screen
                                                            // without swiping through calendar months
      selectedDayPredicate: (day) => isSameDay(day, today),
      onDaySelected: calendarViewModel.setStartCalCurrentDay,
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
          color: Colors.white70,
          fontWeight: FontWeight.bold,
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
        ),
        // define the selected day decoration
        selectedDecoration: const BoxDecoration(
          color: Colors.white54, // Customize the color as needed
          shape: BoxShape.circle,
        ),

        // define today's decoration so that when user clicks another date,
        // today no longer holds any highlight
        todayDecoration: BoxDecoration(),
      ),
    );
  }
}
