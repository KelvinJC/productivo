import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/calendar/view_models/calendar_view_model.dart';
import 'package:todo/calendar/views/end_calendar_widget.dart';
import 'package:todo/calendar/views/start_calendar_widget.dart';
import 'package:todo/clock/view_models/clock_view_model.dart';
import 'package:todo/todo_list/view_models/todo_view_model.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TodoViewModel todoViewModel = context.watch<TodoViewModel>();
    CalendarViewModel calendarViewModel = context.watch<CalendarViewModel>();
    ClockViewModel clockViewModel = context.watch<ClockViewModel>();
    DateTime startDay = calendarViewModel.startCalCurrentDay;
    DateTime endDay = calendarViewModel.endCalCurrentDay;
    String allDayStartDay = DateFormat('EEE, MMM d y').format(startDay);
    String allDayEndDay = DateFormat('EEE, MMM d y').format(endDay);
    bool startCalVisible = todoViewModel.isStartDateCalendarVisible;
    bool endCalVisible = todoViewModel.isEndDateCalendarVisible;
    bool timeBtnSelected = todoViewModel.isTimeBtnSelected;
    bool allDaySelected = todoViewModel.isAllDay;
    String selectedStartTime = todoViewModel.isStartTimeSet ? 'todoViewModel.formattedTime' : clockViewModel.formattedTime;
    String selectedEndTime = todoViewModel.isEndTimeSet ? 'endTime' : todoViewModel.addOneHour(selectedStartTime);
    String selectedEndDay = todoViewModel.isEndTimeSet ? 'selectedEndDay' : '';
    bool startClock = todoViewModel.isStartClockVisible;
    bool endClock = todoViewModel.isEndClockVisible;

    SystemChannels.textInput.invokeMethod('TextInput.hide');

    StartCalendar startCal = const StartCalendar();
    EndCalendar endCal = const EndCalendar();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                      hintText: 'Title',
                      hintStyle: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      contentPadding: const EdgeInsets.all(20.0),
                      // prefixIcon: Icon(Icons.email),
                      filled: true,
                      fillColor: Colors.white70,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1,
                            color: Colors.white70
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1,
                            color: Colors.white70
                        ),
                        borderRadius: BorderRadius.circular(15),
                      )
                  ),
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    if (allDaySelected) {
                      todoViewModel.toggleStartDateCalendarVisible();
                    } else {
                      todoViewModel.toggleStartDateClockVisible();
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: startCalVisible || startClock ? Colors.black : Colors.white70,
                          borderRadius: BorderRadius.circular(15),

                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'Start',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: startCalVisible || startClock ? Colors.white70 : Colors.black,
                                  )
                              ),
                              Text(
                                  timeBtnSelected ? '$allDayStartDay  $selectedStartTime' : allDayStartDay,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    // fontWeight: FontWeight.bold,
                                    color: startCalVisible || startClock ? Colors.white70 : Colors.black,
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),


                      Visibility(
                          maintainState: true,
                          visible: startCalVisible,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20,),
                              Container(
                                height: 330,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black,
                                ),
                                child: startCal,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                                child: Divider(),
                              ),
                            ],
                          )
                      ),

                      // select time
                      Visibility(
                          maintainState: true,
                          visible: startClock,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20,),
                              Container(
                                height: 330,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black,
                                ),
                                child: Text(
                                    'Time Sat, 16 Dec 2023  08:00',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    )
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                                child: Divider(),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: startCalVisible ? 0.0 : 20,),
                GestureDetector(
                  onTap: () {
                    if (allDaySelected) {
                      todoViewModel.toggleEndDateCalendarVisible();
                    } else {
                      todoViewModel.toggleEndDateClockVisible();
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: endCalVisible || endClock ? Colors.black : Colors.white70,
                          borderRadius: BorderRadius.circular(15),

                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'End',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: endCalVisible || endClock ? Colors.white70 : Colors.black,
                                  )
                              ),
                              Text(
                                  timeBtnSelected ? '$selectedEndDay  $selectedEndTime' : allDayEndDay,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    color: endCalVisible || endClock ? Colors.white70 : Colors.black,
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                          maintainState: true,
                          visible: endCalVisible,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20,),
                                Container(
                                  height: 330,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.black,
                                  ),
                                  child: endCal,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                                  child: Divider(),
                                ),
                              ],
                          )
                      ),

                      // select time
                      Visibility(
                          maintainState: true,
                          visible: endClock,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20,),
                              Container(
                                height: 330,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black,
                                ),
                                child: Text(
                                        'Time Sat, 16 Dec 2023  08:00',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        )
                                      ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                                child: Divider(),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: endCalVisible ? 0.0 : 20.0 ,),
                // toggler for 'All day' or 'Time'
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            todoViewModel.selectTime();
                          },
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                                color: timeBtnSelected ? Colors.black : Colors.white70,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                      color: timeBtnSelected ? Colors.grey : Colors.black,
                                      Icons.timer_outlined
                                  ),
                                  const SizedBox(width: 10,),
                                  Text(
                                      'Time',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: timeBtnSelected ? Colors.grey : Colors.black,
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: VerticalDivider(
                          color: Colors.grey,
                          thickness: 1.0,
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            todoViewModel.selectAllDay();
                          },
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                                color: allDaySelected ? Colors.black : Colors.white70,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    color: allDaySelected ? Colors.grey : Colors.black,
                                    Icons.calendar_month_outlined
                                  ),
                                  const SizedBox(width: 10,),
                                  Text(
                                      'All day',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: allDaySelected ? Colors.grey : Colors.black,
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  // onTap: () {
                  //   todoViewModel.toggleEndDateCalendarVisible();
                  // },
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(15),

                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'Category',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  )
                              ),
                              Text(
                                  'Work',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Visibility(
                      //     maintainState: true,
                      //     visible: endCalVisible,
                      //     child: const Column(
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       children: [
                      //         SizedBox(height: 20,),
                      //         CalendarDisplay(),
                      //         Padding(
                      //           padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                      //           child: Divider(),
                      //         ),
                      //       ],
                      //     )
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  // onTap: () {
                  //   todoViewModel.toggleEndDateCalendarVisible();
                  // },
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(15),

                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.location_on_outlined),
                                  const SizedBox(width: 20,),
                                  Text(
                                      'Location',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      )
                                  ),
                                ],
                              ),
                              Text(
                                  'My desk',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Visibility(
                      //     maintainState: true,
                      //     visible: endCalVisible,
                      //     child: const Column(
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       children: [
                      //         SizedBox(height: 20,),
                      //         CalendarDisplay(),
                      //         Padding(
                      //           padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                      //           child: Divider(),
                      //         ),
                      //       ],
                      //     )
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  // onTap: () {
                  //   todoViewModel.toggleEndDateCalendarVisible();
                  // },
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(15),

                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.alarm_on),
                                  const SizedBox(width: 20,),
                                  Text(
                                      'Reminder',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      )
                                  ),
                                ],
                              ),
                              Text(
                                  'None',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Visibility(
                      //     maintainState: true,
                      //     visible: endCalVisible,
                      //     child: const Column(
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       children: [
                      //         SizedBox(height: 20,),
                      //         CalendarDisplay(),
                      //         Padding(
                      //           padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                      //           child: Divider(),
                      //         ),
                      //       ],
                      //     )
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),                GestureDetector(
                  // onTap: () {
                  //   todoViewModel.toggleEndDateCalendarVisible();
                  // },
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(15),

                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.bookmark_border),
                                  const SizedBox(width: 20,),
                                  Text(
                                      'Priority',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      )
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.orange,
                                    ),
                                    width: 8.0, // Adjust the width as needed
                                    height: 8.0, // Adjust the height as needed
                                  ),
                                  const SizedBox(width: 5,),
                                  Text(
                                      'Medium',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.orange,
                                      )
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Visibility(
                      //     maintainState: true,
                      //     visible: endCalVisible,
                      //     child: const Column(
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       children: [
                      //         SizedBox(height: 20,),
                      //         CalendarDisplay(),
                      //         Padding(
                      //           padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                      //           child: Divider(),
                      //         ),
                      //       ],
                      //     )
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
              ],
            ),

          ),
        ),
      ),

    );
  }
}
