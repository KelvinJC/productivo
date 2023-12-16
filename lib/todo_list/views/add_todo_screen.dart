import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/components/calendar_display.dart';
import 'package:todo/todo_list/view_models/todo_view_model.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TodoViewModel todoViewModel = context.watch<TodoViewModel>();
    bool startCalVisible = todoViewModel.isStartDateCalendarVisible;
    bool endCalVisible = todoViewModel.isEndDateCalendarVisible;


    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 25,),
              GestureDetector(
                onTap: () {
                  todoViewModel.toggleStartDateCalendarVisible();
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(15),

                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Text(
                                  'Start',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  )
                              ),
                            ],
                          ),
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
                              padding: EdgeInsets.symmetric(horizontal: 25.0),
                              child: Divider(),
                            ),
                          ],
                        )
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: () {
                  todoViewModel.toggleEndDateCalendarVisible();
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(15),

                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Text(
                                  'End',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  )
                              ),
                            ],
                          ),
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
                              padding: EdgeInsets.symmetric(horizontal: 25.0),
                              child: Divider(),
                            ),
                          ],
                        )
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 20,),

            ],
          ),
        ),
      ),

    );
  }
}