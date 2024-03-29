
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/components/greeting_card.dart';
import 'package:todo/components/todo_list_row.dart';
import 'package:todo/validation/view_models/login_validation.dart';
import 'auth/view_models/auth_view_model2.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MyTileWidget extends StatelessWidget {
  final Color color;
  final int index;
  final String text;
  final String completed;

  MyTileWidget(this.index, this.color, this.text, this.completed);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  text,
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    // shadows: [
                    //   const Shadow(
                    //     offset: Offset(0.0, 0.8), // Set the offset of the shadow
                    //     blurRadius: 2.0, // Set the blur radius of the shadow
                    //     color: Colors.grey, // Set the color of the shadow
                    //   ),
                    // ],
                  ),
                ),
                Text(
                  completed,
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      color: Colors.white70,
                      // fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(135.0,1,0.0,0.0),
              child: Icon(
                Icons.add,
                color: Colors.white70,
              ),
            )
          ],
        ),
      ),
    );
  }
}

List colors = [
  (Colors.grey[350]),
  (Colors.grey),
  (Colors.grey[850]),
  (Colors.black38),
  (Colors.brown[200]),
  (Colors.blueGrey[100]),
  (Colors.grey),
  (Colors.grey[350]),
  (Colors.black),
];

List text = [
  'Personal',
  'Sports',
  'Work',
  'Social',
  'Projects',
  'School',
  'Study',
  'Purchase',
  'Entertainment',
  'Finance',
];

List  completedTasks = [
  '11',
  '50',
  '24',
  '2',
  '4',
  '0',
  '1',
  '78'
];


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthViewModel authViewModel = context.watch<AuthViewModel>();
    LoginValidationViewModel loginValidationViewModel = context.watch<LoginValidationViewModel>();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        surfaceTintColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: GestureDetector(
            onTap: () {
              loginValidationViewModel.changeUserLoggedOut();
              authViewModel.signOut();
            },
            child: const CircleAvatar(
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
      // bottomNavigationBar: BottomNavigationBar(
      //   iconSize: 20.0,
      //   backgroundColor: Colors.white,
      //   type: BottomNavigationBarType.fixed,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //           color: Colors.black54,
      //           Icons.home_filled
      //       ),
      //       label: ''
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //             color: Colors.black,
      //             Icons.calendar_month),
      //         label: ''
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //
      //         Icons.add_box_outlined
      //       ),
      //       label: 'Add'
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //
      //             Icons.view_list_rounded
      //         ),
      //         label: 'Boards'
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //             color: Colors.black54,
      //
      //             Icons.person
      //         ),
      //         label: 'Profile'
      //     ),
      //   ],
      // ),
      body: Column(
        children: [
          GreetUserCard(),
          // SizedBox(height: 25,),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 25.0,),
          //   child: Column(
          //     // mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             '8 Tasks',
          //             style: GoogleFonts.montserrat(
          //                 fontSize: 15,
          //                 fontWeight: FontWeight.bold // normal if unselected
          //             ),
          //           ),
          //           Text(
          //             '4 Boards',
          //             style: GoogleFonts.montserrat(
          //               fontSize: 15,
          //               // fontWeight: FontWeight.bold
          //             ),
          //           ),
          //         ],
          //       ),
          //
          //       // tab switch imitation
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           const SizedBox(
          //             width: 180,
          //               child: Divider(color: Colors.black,) // switches colour based on selection of tasks or boards
          //           ),
          //           SizedBox(
          //               width: 180,
          //               child: Divider(color: Colors.grey[400],)
          //           ),
          //         ],
          //       )
          //     ],
          //   ),
          // ),
          const SizedBox(height: 12,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 2, // Number of columns
                itemCount: 8, // Number of items
                itemBuilder: (BuildContext context, int index) => MyTileWidget(index, colors[index], text[index], completedTasks[index]),
                staggeredTileBuilder: (int index) => StaggeredTile.count(
                  1, // Width of the tile
                  index.isEven ? 1.2 : 0.9, // Height of the tile
                ),
                mainAxisSpacing: 8.0, // Spacing between tiles vertically
                crossAxisSpacing: 8.0, // Spacing between tiles horizontally
              ),
            ),
          ),
          // Expanded(
          //   child: ListView.separated(
          //       padding: EdgeInsets.only(top: 5.0, bottom: 15.0),
          //       itemBuilder: (context, index) {
          //         return Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //           child: TodoListRow(index: index),
          //         );
          //       },
          //       separatorBuilder: (context, index) => Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //         child: Divider(
          //           color: Colors.grey[200],
          //         ),
          //       ),
          //       itemCount: 10
          //   ),
          // ),

        ],
      ),
      // body: ,
    );
  }
}
