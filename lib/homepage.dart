
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/components/greeting_card.dart';
import 'package:todo/components/todo_list_row.dart';
import 'package:todo/validation/view_models/login_validation.dart';
import 'auth/view_models/auth_view_model.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuthViewModel authViewModel = context.watch<FirebaseAuthViewModel>();
    LoginValidationViewModel loginValidationViewModel = context.watch<LoginValidationViewModel>();


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
            size:30.0,
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
        iconSize: 20.0,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
                color: Colors.black54,
                Icons.home_filled
            ),
            label: ''
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  color: Colors.black,
                  Icons.calendar_month),
              label: ''
          ),
          BottomNavigationBarItem(
            icon: Icon(

              Icons.add_box_outlined
            ),
            label: 'Add'
          ),
          BottomNavigationBarItem(
              icon: Icon(

                  Icons.view_list_rounded
              ),
              label: 'Boards'
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  color: Colors.black54,

                  Icons.person
              ),
              label: 'Profile'
          ),
        ],
      ),
      body: Column(
        children: [
          GreetUserCard(),
          SizedBox(height: 25,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0,),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '8 Tasks',
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.bold // normal if unselected
                      ),
                    ),
                    Text(
                      '4 Boards',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        // fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),

                // tab switch imitation
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 180,
                        child: Divider(color: Colors.black,) // switches colour based on selection of tasks or boards
                    ),
                    SizedBox(
                        width: 180,
                        child: Divider(color: Colors.grey[400],)
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          Expanded(
            child: ListView.separated(
                padding: EdgeInsets.only(top: 5.0, bottom: 15.0),
                itemBuilder: (context, index) {
                  return TodoListRow(index: index);
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
