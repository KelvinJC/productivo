import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';



class GreetUserCard extends StatelessWidget {

  const GreetUserCard({super.key});

  String appropriateGreeting (currentTime) {
    String formattedTime = DateFormat.Hms().format(currentTime);
    String hourOfDay = formattedTime.split(':')[0];

    switch (int.parse(hourOfDay)) {
      case < 12 && >= 0:      // 00:00 am - 11:59 am
        return 'Morning';
      case == 12:             // 12:00 pm - 12:59 pm
        return 'Noon';
      case < 16 && > 12:      // 13:00 pm - 15:59 pm
        return 'Afternoon';
      case >= 16 && <= 19:    // 16:00 pm - 19:59 pm
        return 'Evening';
      default:                // 20:00 pm - 23:59 pm
        return 'Night';
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime _currentTime = DateTime.now();
    String formattedTime = DateFormat.Hm().format(_currentTime);
    String formattedDate = DateFormat('EEEE, MMMM d y').format(_currentTime);
    List splitFormattedDate = formattedDate.split(', ');
    String currentDay = splitFormattedDate[0];
    String currentDate = splitFormattedDate[1];

    return Container(
      width: 370,
      height: 250,
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thursday',
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
                height: 0.8,
            ),
          ),
          Text(
            appropriateGreeting(_currentTime),
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 48,
                color: Colors.white
            ),
          ),
          SizedBox(height: 45,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Today  ',//$currentDay',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white70
                ),
              ),
              Text(
                'Completed',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white70
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                currentDate,
                style: GoogleFonts.montserrat(
                  // fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white70
                ),
              ),
              Text(
                '75%',
                style: GoogleFonts.montserrat(
                  // fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white70
                ),
              )
            ],
          ),
        ],
      )
    );
  }
}
