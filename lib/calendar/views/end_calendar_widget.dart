// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:todo/calendar/view_models/calendar_view_model.dart';
//
// class EndCalendar extends StatelessWidget {
//   const EndCalendar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     CalendarViewModel calendarViewModel = context.watch<CalendarViewModel>();
//     DateTime endDay = calendarViewModel.endCalCurrentDay;
//
//     return TableCalendar(
//       focusedDay: endDay,
//       firstDay: DateTime.utc(2020, 10, 16),
//       lastDay: DateTime.utc(2030, 3, 14),
//       // enabledDayPredicate: (day) {
//       //   return day.isAfter(startDay) || isSameDay(day, startDay);
//       // },
//       rowHeight: 40,
//       headerStyle: HeaderStyle(
//         formatButtonVisible: false,
//         titleCentered: true,
//         titleTextStyle: GoogleFonts.montserrat(
//             fontWeight: FontWeight.bold,
//             color: Colors.white70
//         ),
//         leftChevronIcon: const Icon(
//             color: Colors.white70,
//             Icons.chevron_left
//         ),
//         rightChevronIcon: const Icon(
//             color: Colors.white70,
//             Icons.chevron_right
//         ),
//       ),
//       availableGestures: AvailableGestures.horizontalSwipe, // instead of AvailableGestures.all,
//                                                             // enables vertical scrolling of screen
//                                                             // without swiping through calendar months
//       selectedDayPredicate: (day) => isSameDay(day, endDay),
//       onDaySelected: calendarViewModel.setEndCalCurrentDay,
//       daysOfWeekStyle: DaysOfWeekStyle(
//         weekdayStyle: GoogleFonts.montserrat(
//             fontSize: 13,
//             color: Colors.white70
//         ),
//         weekendStyle: GoogleFonts.montserrat(
//             fontSize: 13,
//             color: Colors.white70
//         ),
//       ),
//       calendarStyle: CalendarStyle(
//         todayTextStyle: GoogleFonts.montserrat(
//           fontSize: 12,
//           color: Colors.white70,
//           fontWeight: FontWeight.bold,
//         ),
//         weekendTextStyle: GoogleFonts.montserrat(
//             fontSize: 12,
//             fontWeight: FontWeight.bold,
//             color: Colors.white70
//         ),
//         outsideTextStyle: GoogleFonts.montserrat(
//             fontSize: 12,
//             fontWeight: FontWeight.w100,
//             color: Colors.white70
//         ),
//
//         disabledDecoration: BoxDecoration(
//           color: Colors.transparent, // Customize the color for disabled days
//           shape: BoxShape.circle,
//           border: Border.all(
//             color: Colors.grey, // Outline color for disabled days
//             width: 0.5, // Outline width
//           ),
//         ),
//
//         disabledTextStyle: GoogleFonts.montserrat(
//           fontSize: 12,
//           fontWeight: FontWeight.w100,
//           color: Colors.black, // customize the color for disabled dates to be black i.e. invisible
//         ),
//         defaultTextStyle: GoogleFonts.montserrat(
//             fontSize: 12,
//             fontWeight: FontWeight.bold,
//             color: Colors.white70
//         ),
//         // define the decoration for the selected day i.e. endDay
//         selectedDecoration: const BoxDecoration(
//           color: Colors.white54, // Customize the color as needed
//           shape: BoxShape.circle,
//         ),
//
//         // define today's decoration so that when user clicks another date,
//         // today no longer holds any highlight
//         todayDecoration: const BoxDecoration(),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/calendar/view_models/calendar_view_model.dart';

class EndCalendar extends StatelessWidget {
  const EndCalendar({super.key});

  Future<TableCalendar> buildTableCalendarAsync(BuildContext context) async {
    CalendarViewModel calendarViewModel = context.watch<CalendarViewModel>();
    DateTime endDay = calendarViewModel.endCalCurrentDay;

    // Simulate some asynchronous work, e.g., fetching data
    // await Future.delayed(const Duration(milliseconds: 2));

    return TableCalendar(
      focusedDay: endDay,
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
      availableGestures: AvailableGestures.horizontalSwipe,
      selectedDayPredicate: (day) => isSameDay(day, endDay),
      onDaySelected: calendarViewModel.setEndCalCurrentDay,
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
        disabledDecoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
        disabledTextStyle: GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.w100,
          color: Colors.black,
        ),
        defaultTextStyle: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white70
        ),
        selectedDecoration: const BoxDecoration(
          color: Colors.white54,
          shape: BoxShape.circle,
        ),
        todayDecoration: const BoxDecoration(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TableCalendar>(
      future: buildTableCalendarAsync(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.white70,));
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: GoogleFonts.montserrat(
                  fontSize: 13,
                  color: Colors.white70
              ),
            ),
          );
        } else {
          return snapshot.data ?? Center(
            child: Text(
              'Calendar could not load',
              style: GoogleFonts.montserrat(
                  fontSize: 13,
                  color: Colors.white70
              ),
            ),
          );
        }
      },
    );
  }
}
