import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TodoListRow extends StatelessWidget {
  final int index;
  const TodoListRow({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!, // Color of the shadow
            offset: Offset(0, 2), // Offset of the shadow (x, y)
            blurRadius: 2.0, // Radius of the shadow blur
            spreadRadius: 1.0, // How much the shadow should spread
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: switchColor(index),
                      ),
                      width: 8.0, // Adjust the width as needed
                      height: 8.0, // Adjust the height as needed
                    ),
                    SizedBox(width: 10,),
                    Text(
                      switchCategory(index),
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    switchTask(index),
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}




class EventListRow extends StatelessWidget {
  final int index;
  final String title;
  final String start;
  final String end;
  final String category;

  const EventListRow({
    super.key,
    required this.index,
    required this.title,
    required this.start,
    required this.end,
    required this.category
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!, // Color of the shadow
            offset: const Offset(0, 2), // Offset of the shadow (x, y)
            blurRadius: 2.0, // Radius of the shadow blur
            spreadRadius: 1.0, // How much the shadow should spread
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: switchColor(index),
                      ),
                      width: 8.0, // Adjust the width as needed
                      height: 8.0, // Adjust the height as needed
                    ),
                    SizedBox(width: 10,),
                    Text(
                      switchCategory(index),
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    title,
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}



Color? switchColor(int index) {
  switch (index) {
    case 1:
      return Colors.blue[900];
    case 2:
      return Colors.red;
    default:
      return Colors.green;
  }
}

String switchCategory(int index) {
  switch (index) {
    case 1:
      return 'Leisure';
    case 2:
      return 'Work';
    default:
      return 'Sport';
  }
}

String switchTask(int index) {
  switch (index) {
    case 1:
      return 'Dinner with Jenny';
    case 2:
      return 'Merge PR on Task App';
    default:
      return 'Run Harcourt marathon';
  }
}
