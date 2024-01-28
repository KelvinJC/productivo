import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/event_list/views/add_event_screen.dart';

import '../../components/todo_list_row.dart';

class EventsListCalendar extends StatelessWidget {
  const EventsListCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    // CalendarViewModel calendarViewModel = context.watch<CalendarViewModel>();
    // DateTime endDay = calendarViewModel.endCalCurrentDay;
    DateTime endDay = DateTime.now();

    return TableCalendar(
      focusedDay: endDay,
      firstDay: DateTime.utc(2020, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      // enabledDayPredicate: (day) {
      //   return day.isAfter(startDay) || isSameDay(day, startDay);
      // },
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
      selectedDayPredicate: (day) => isSameDay(day, endDay),
      // onDaySelected: calendarViewModel.setEndCalCurrentDay,
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
          color: Colors.transparent, // Customize the color for disabled days
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey, // Outline color for disabled days
            width: 0.5, // Outline width
          ),
        ),

        disabledTextStyle: GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.w100,
          color: Colors.black, // customize the color for disabled dates to be black i.e. invisible
        ),
        defaultTextStyle: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white70
        ),
        // define the decoration for the selected day i.e. endDay
        selectedDecoration: const BoxDecoration(
          color: Colors.white54, // Customize the color as needed
          shape: BoxShape.circle,
        ),

        // define today's decoration so that when user clicks another date,
        // today no longer holds any highlight
        todayDecoration: const BoxDecoration(),
      ),
    );
  }
}



class EventsList extends StatelessWidget {
  const EventsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Container(
                height: 330,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black87,
                ),
                child: const EventsListCalendar()
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  Text(
                      'Events',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: Colors.black87,
                      )
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Divider(),
              ),
              Expanded(
                child: ListView.separated(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 15.0),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AddTodoScreen(),
                                ),
                              );
                            },
                            child: TodoListRow(index: index)),
                      );
                    },
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Divider(
                        color: Colors.grey[200],
                      ),
                    ),
                    itemCount: 10
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: FloatingActionButton(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white70,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddTodoScreen(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}



