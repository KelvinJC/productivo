import 'package:flutter/material.dart';
import 'package:todo/event_list/views/list_events_screen.dart';
import 'package:todo/homepage.dart';


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentPageIndex = 0;

  // define list of pages
  final List<Widget> _pages = const [
    HomePage(),
    EventsList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentPageIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200]!, // Color of the shadow
              offset: const Offset(2, 0), // Offset of the shadow (x, y)
              blurRadius: 2.0, // Radius of the shadow blur
              spreadRadius: 1.0, // How much the shadow should spread
            ),
          ],
        ),
        child: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {currentPageIndex = index;});
          },
          indicatorColor: Colors.grey[200],
          selectedIndex: currentPageIndex,
          height: 60,
          // iconSize: 20.0,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,

          // type: BottomNavigationBarType.fixed,
          destinations: const <Widget>[
            NavigationDestination(
                icon: Icon(
                    Icons.home_filled
                ),
                label: 'Home'
            ),

            // TODO: uncomment when other pages are built
            // NavigationDestination(
            //     icon: Icon(
            //         Icons.view_list_rounded
            //     ),
            //     label: 'Tasks'
            // ),
            // NavigationDestination(
            //     icon: Icon(
            //         Icons.add_box_outlined
            //     ),
            //     label: 'Add'
            // ),
            NavigationDestination(
                icon: Icon(
                    Icons.calendar_month),
                label: 'Events'
            ),

            // TODO: delete later when other pages are built
            NavigationDestination(
                 icon: Icon(
                     Icons.view_list_rounded
                 ),
                 label: 'Tasks'
            ),

            NavigationDestination(
                icon: Icon(
                    Icons.person
                ),
                label: 'Profile'
            ),
          ],
        ),
      ),
    );
  }
}

