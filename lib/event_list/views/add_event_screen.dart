import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/components/calendar/view_models/calendar_view_model.dart';
import 'package:todo/components/calendar/views/end_calendar_widget.dart';
import 'package:todo/components/calendar/views/start_calendar_widget.dart';
import 'package:todo/components/clock/view_models/clock_view_model.dart';
import 'package:todo/components/category_button.dart';
import 'package:todo/event_list/view_models/category_view_model.dart';
import 'package:todo/event_list/view_models/location_view_model.dart';
import 'package:todo/event_list/view_models/select_time_and_date_view_model.dart';
import 'package:todo/event_list/view_models/save_event_view_model.dart';



class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('building');
    // providers
    SelectTimeDateViewModel eventViewModel = context.watch<SelectTimeDateViewModel>();
    CalendarViewModel calendarViewModel = context.watch<CalendarViewModel>();
    ClockViewModel clockViewModel = context.watch<ClockViewModel>();
    CategoryViewModel categoryViewModel = context.watch<CategoryViewModel>();
    LocationViewModel locationViewModel = context.watch<LocationViewModel>();
    // calendar state
    DateTime startDay = calendarViewModel.startCalCurrentDay;
    DateTime endDay = calendarViewModel.endCalCurrentDay;
    // date display format
    String allDayStartDay = DateFormat('EEE, MMM d y').format(startDay);
    String allDayEndDay = DateFormat('EEE, MMM d y').format(endDay);
    // choice of time input state
    bool startCalVisible = eventViewModel.isStartDateCalendarVisible;
    bool endCalVisible = eventViewModel.isEndDateCalendarVisible;
    bool timeBtnSelected = eventViewModel.isTimeBtnSelected;
    bool allDaySelected = eventViewModel.isAllDay;
    bool startClock = eventViewModel.isStartClockVisible;
    bool endClock = eventViewModel.isEndClockVisible;
    // clock state
    String selectedStartTime = eventViewModel.isStartTimeSet ? 'eventViewModel.formattedTime' : clockViewModel.formattedTime;
    String selectedEndTime = eventViewModel.isEndTimeSet ? 'endTime' : eventViewModel.addOneHour(selectedStartTime);
    String selectedEndDay = eventViewModel.isEndTimeSet ? 'selectedEndDay' : '';
    // calendars
    StartCalendar startCal = const StartCalendar();
    EndCalendar endCal = const EndCalendar();
    // remove keyboard when user clicks outside textbox
    // SystemChannels.textInput.invokeMethod('TextInput.hide');

    // save event
    SaveEvent saveEvent = context.watch<SaveEvent>();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        surfaceTintColor: Colors.transparent,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         color: Colors.grey[850]
                  //     ),
                  //     child: const Icon(
                  //         size: 30,
                  //         Icons.chevron_left,
                  //         color: Colors.white
                  //     ),
                  //   ),
                  // ),
                  // title input field
                  TextFormField(
                    // maxLength: 60,
                    onChanged: (String titleVal) {
                      saveEvent.changeTitle(titleVal);
                    },
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

                  // start date field
                  GestureDetector(
                    onTap: () {
                      if (allDaySelected) {
                        eventViewModel.toggleStartDateCalendarVisible();
                      } else {
                        eventViewModel.toggleStartDateClockVisible();
                      }
                      FocusScope.of(context).unfocus();
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

                        // start date calendar
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

                        // rolling calendar & clock for start date and time
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

                  // end date input field
                  GestureDetector(
                    onTap: () {
                      if (allDaySelected) {
                        eventViewModel.toggleEndDateCalendarVisible();
                      } else {
                        eventViewModel.toggleEndDateClockVisible();
                      }
                      FocusScope.of(context).unfocus();
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
                        // end date calendar
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

                        // rolling calendar & clock for end date and time
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

                  // buttons for 'All day' or 'Time'
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        // Time button
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              eventViewModel.selectTime();
                              FocusScope.of(context).unfocus();
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

                        // All day button
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              eventViewModel.selectAllDay();
                              FocusScope.of(context).unfocus();
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

                  // category field
                  GestureDetector(
                    onTap: () {
                      categoryViewModel.toggleCategoryFieldSelected();
                      FocusScope.of(context).unfocus();
                    },
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
                                    const Icon(Icons.category_outlined),
                                    const SizedBox(width: 20.0,),
                                    Text(
                                        'Category',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        )
                                    ),
                                  ],
                                ),
                                Text(
                                    categoryViewModel.selectedCategory,
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
                        const SizedBox(height: 20,),
                        Visibility(
                          visible: categoryViewModel.categoryFieldSelected,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                               Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                spacing: 20.0,
                                runSpacing: 20.0,
                                children: [
                                  DefaultCategoryButton(category: 'Personal'),
                                  DefaultCategoryButton(category: 'Work'),
                                  DefaultCategoryButton(category: 'Sports'),
                                  DefaultCategoryButton(category: 'Social'),
                                  DefaultCategoryButton(category: 'Projects'),
                                  DefaultCategoryButton(category: 'School'),
                                  DefaultCategoryButton(category: 'Study'),
                                  DefaultCategoryButton(category: 'Purchase'),
                                  DefaultCategoryButton(category: 'Entertainment'),
                                  DefaultCategoryButton(category: 'Finance'),
                                ],
                              ),
                              SizedBox( height: 20,),
                              Row(
                                children: [
                                  AddCategoryButton(),
                                ],
                              ),
                              SizedBox( height: 20,),
                              Divider(),


                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: categoryViewModel.categoryFieldSelected ?  20.0 : 0.0,),
                  TextFormField(
                    maxLines: 4,
                    onChanged: (String noteVal) {
                      saveEvent.changeNote(noteVal);
                    },
                    onTap: () {
                      locationViewModel.toggleLocationFieldSelected();
                    },
                    // onChanged: ,
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 70.0),
                        child: Icon(Icons.sticky_note_2_outlined),
                      ),
                      contentPadding: const EdgeInsets.all(20.0),
                      hintText: 'Note',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white70,
                        ),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white70,
                          ),
                        borderRadius: BorderRadius.circular(15)
                      )
                    ),
                  ),

                  // GestureDetector(
                  //   // onTap: () {
                  //   //   eventViewModel.toggleEndDateCalendarVisible();
                  //   // },
                  //   child: Column(
                  //     children: [
                  //       Container(
                  //         height: 70,
                  //         decoration: BoxDecoration(
                  //           color: Colors.white70,
                  //           borderRadius: BorderRadius.circular(15),
                  //
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Row(
                  //                 children: [
                  //                   const Icon(Icons.location_on_outlined),
                  //                   const SizedBox(width: 20,),
                  //                   Text(
                  //                       'Location',
                  //                       style: GoogleFonts.montserrat(
                  //                         fontSize: 15,
                  //                         fontWeight: FontWeight.bold,
                  //                         color: Colors.black,
                  //                       )
                  //                   ),
                  //                 ],
                  //               ),
                  //               Text(
                  //                   'My desk',
                  //                   style: GoogleFonts.montserrat(
                  //                     fontSize: 15,
                  //                     // fontWeight: FontWeight.bold,
                  //                     color: Colors.black,
                  //                   )
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
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
                  const SizedBox(height: 20,),
                  TextFormField(
                    onTap: () {

                    },
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white70,
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Icon(Icons.location_on_outlined),
                        ),
                        contentPadding: const EdgeInsets.all(21.0),
                        hintText: 'Location',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white70,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white70
                            ),
                            borderRadius: BorderRadius.circular(15)
                        )
                    ),
                  ),
                  const SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
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
                  GestureDetector(
                    onTap: () {
                      String startVal = timeBtnSelected ? '$allDayStartDay  $selectedStartTime' : allDayStartDay;
                      String endVal = timeBtnSelected ? '$selectedEndDay  $selectedEndTime' : allDayEndDay;
                      saveEvent.changeStart(startVal);
                      saveEvent.changeEnd(endVal);
                      saveEvent.changeCategory(categoryViewModel.selectedCategory);
                      saveEvent.saveEvent();
                    },
                    child: Container(
                      height: 80,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: saveEvent.saveStatus == 'Saving'
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                          'Save',
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[200]
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
          ),
        ),
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(right: 8.0, left: 40.0),
      //   child: Container()
      // ),
    );
  }
}



