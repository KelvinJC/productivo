
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/components/calendar_display.dart';
import 'package:todo/components/greeting_card.dart';
import 'package:todo/components/todo_list_row.dart';
import 'package:todo/components/calendar_row.dart';

import 'package:todo/validation/view_models/login_validation.dart';
import 'auth/view_models/auth_view_model.dart';

class Calendar {
  String day;
  int date;

  Calendar({required this.day, required this.date});

}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuthViewModel authViewModel = context.watch<FirebaseAuthViewModel>();
    LoginValidationViewModel loginValidationViewModel = context.watch<LoginValidationViewModel>();
    List cal = [
      Calendar(day: 'Mon', date: 21),
      Calendar(day: 'Tues', date: 22),
      Calendar(day: 'Wed', date: 23),
      Calendar(day: 'Thur', date: 24),
      Calendar(day: 'Fri', date: 25),
      Calendar(day: 'Sat', date: 26),
      Calendar(day: 'Sun', date: 27),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        surfaceTintColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: GestureDetector(
            onTap: () {
              loginValidationViewModel.changeUserLoggedOut();
              authViewModel.signOut();
            },
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/beach3.png'),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 180.0),
            child: Text(
              'Hi Kelvin',
              style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          Icon(
            color: Colors.grey[600],
            Icons.notifications_none_outlined,
            size: 30.0,
          ),
          SizedBox(width: 25,),
          // Icon(
          //   color: Colors.grey[600],
          //   Icons.message_outlined,
          //   size: 30.0,
          // ),
          // SizedBox(width: 25,),

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              size: 28,
                color: Colors.black54,
                Icons.home_filled
            ),
            label: ''
          ),
          BottomNavigationBarItem(
              icon: Icon(color: Colors.black54, Icons.calendar_today),
              label: ''
          ),
          BottomNavigationBarItem(
            icon: Icon(
              color: Colors.black54,
              size: 32,
              Icons.add_box_outlined
            ),
            label: 'Add'
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  color: Colors.black54,
                  size: 32,
                  Icons.view_list_rounded
              ),
              label: ''
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  color: Colors.black54,
                  size: 32,
                  Icons.person
              ),
              label: ''
          ),
        ],
      ),
      body: Column(
        children: [
          // SizedBox(height: 25,),
          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: TextFormField(
          //     decoration: InputDecoration(
          //         hintText: 'Search',
          //         prefixIcon: GestureDetector(
          //           onTap: () {
          //             loginValidationViewModel.changeUserLoggedOut();
          //             authViewModel.signOut();
          //           },
          //           child: Icon(Icons.search)
          //         ),
          //         filled: true,
          //         fillColor: Colors.white70,
          //         enabledBorder: OutlineInputBorder(
          //           borderSide: BorderSide(
          //               width: 1,
          //               color: Colors.white70
          //           ),
          //           borderRadius: BorderRadius.circular(30),
          //         ),
          //         focusedBorder: OutlineInputBorder(
          //           borderSide: BorderSide(
          //               width: 1,
          //               color: Colors.white70
          //           ),
          //           borderRadius: BorderRadius.circular(30),
          //         )
          //     ),
          //   ),
          // ),
          GreetUserCard(),
          SizedBox(height: 25,),
          // SizedBox(
          //   height: 120,
          //   child: ListView.builder(
          //       padding: EdgeInsets.fromLTRB(12.0, 0.0, 25.0, 24.0),
          //       scrollDirection: Axis.horizontal,
          //       itemCount: cal.length,
          //       itemBuilder: (context, index) {
          //         return Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //           child: CalendarRow(calendar: cal[index]),
          //         );
          //       }
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Text(
                  'Tasks for you',
                  style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Expanded(
            child: ListView.separated(
                padding: EdgeInsets.only(top: 5.0, bottom: 15.0),
                itemBuilder: (context, index) {
                  return TodoListRow();
                },
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Divider(
                    color: Colors.grey[200],
                  ),
                ),
                itemCount: 10
            ),
          ),

        ],
      ),
      // body: ,
    );
  }
}
