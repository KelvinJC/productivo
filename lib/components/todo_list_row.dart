import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TodoListRow extends StatelessWidget {
  const TodoListRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
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
                          color: Colors.blue[900],
                        ),
                        width: 8.0, // Adjust the width as needed
                        height: 8.0, // Adjust the height as needed
                      ),
                      SizedBox(width: 10,),
                      Text(
                        'Leisure',
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(
                      'Dinner with Jenny',
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
      ),
    );
  }
}
