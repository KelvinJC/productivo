import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/components/calendar_display.dart';
import 'package:todo/todo_list/view_models/todo_view_model.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    TodoViewModel todoViewModel = context.watch<TodoViewModel>();
    bool startCalVisible = todoViewModel.isStartDateCalendarVisible;
    bool endCalVisible = todoViewModel.isEndDateCalendarVisible;


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
                      contentPadding: EdgeInsets.all(20.0),
                      // prefixIcon: Icon(Icons.email),
                      filled: true,
                      fillColor: Colors.white70,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: Colors.white70
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
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
                    todoViewModel.toggleStartDateCalendarVisible();
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: startCalVisible ? Colors.black : Colors.white70,
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
                                      color: startCalVisible ? Colors.white70 : Colors.black,
                                  )
                              ),
                              Text(
                                  'Sat, 16 Dec 2023  08:00',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    // fontWeight: FontWeight.bold,
                                    color: startCalVisible ? Colors.white70 : Colors.black,
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),

                      Visibility(
                          maintainState: true,
                          visible: startCalVisible,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20,),
                              CalendarDisplay(),
                              Padding(
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
                    todoViewModel.toggleEndDateCalendarVisible();
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: endCalVisible ? Colors.black : Colors.white70,
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
                                      color: endCalVisible ? Colors.white70 : Colors.black,
                                  )
                              ),
                              Text(
                                  'Wed, 17 Feb 2024  08:00',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    // fontWeight: FontWeight.bold,
                                    color: endCalVisible ? Colors.white70 : Colors.black,
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                          maintainState: true,
                          visible: endCalVisible,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 20,),
                              CalendarDisplay(),
                              Padding(
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
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.timer_outlined),
                                const SizedBox(width: 10,),
                                Text(
                                    'Time',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const VerticalDivider(
                          color: Colors.grey,
                          thickness: 1.0,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  color: Colors.grey,
                                  Icons.calendar_month_outlined
                                ),
                                const SizedBox(width: 10,),
                                Text(
                                    'All day',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]
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