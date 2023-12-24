import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/clock/view_models/clock_view_model.dart';



class GreetUserCard extends StatelessWidget {

  const GreetUserCard({super.key});

  String abbreviateMonth(String date) {
    List splitDate = date.split(' ');
    String monthAbbreviated = splitDate[0].substring(0,3);
    return '$monthAbbreviated ${splitDate[1]}, ${splitDate[2]}';
  }

  @override
  Widget build(BuildContext context) {
    ClockViewModel clockViewModel = context.watch<ClockViewModel>();
    String currentTime = clockViewModel.formattedTime;
    String currentDay = clockViewModel.formattedDay;
    String currentDate = clockViewModel.formattedDate;
    String periodOfDay = clockViewModel.periodOfDay;

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
            currentDay,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
                height: 0.8,
            ),
          ),
          Text(
            periodOfDay,
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
                currentTime,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white70
                ),
              ),
              Text(
                'Score',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white70
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                abbreviateMonth(currentDate),
                style: GoogleFonts.montserrat(
                  // fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white70
                ),
              ),
              Text(
                '1,075',
                style: GoogleFonts.montserrat(
                  // fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white70
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}
