import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewTodo extends StatelessWidget {
  const NewTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[850]
                  ),
                  child: const Icon(
                      size: 30,
                      Icons.chevron_left,
                      color: Colors.white
                  ),
                ),
                const SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add a',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black,
                        height: 0.8,
                      ),
                    ),
                    Text(
                      'Quickie',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 48,
                          color: Colors.black
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40,),
                TextFormField(
                  // maxLength: 60,
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
                      contentPadding: const EdgeInsets.all(20.0),
                      suffixIcon: const Icon(Icons.save_alt),
                      filled: true,
                      fillColor: Colors.white70,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1,
                            color: Colors.white70
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1,
                            color: Colors.white70
                        ),
                        borderRadius: BorderRadius.circular(15),
                      )
                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  maxLines: 2,

                  // onTap: () {
                  //   locationViewModel.toggleLocationFieldSelected();
                  // },
                  // onChanged: ,
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      // prefixIcon: const Padding(
                      //   padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 70.0),
                      //   child: Icon(Icons.sticky_note_2_outlined),
                      // ),
                      contentPadding: const EdgeInsets.all(20.0),
                      hintText: 'Description',
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white70,
                          ),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white70,
                          ),
                          borderRadius: BorderRadius.circular(15)
                      )
                  ),
                ),
                const SizedBox(height: 20,),

                // buttons for 'Save' and something else
                IntrinsicHeight(
                  child: Row(
                      children: [
                        // Time button
                        Expanded(
                          child: GestureDetector(
                            // onTap: () {
                            //   todoViewModel.selectTime();
                            //   FocusScope.of(context).unfocus();
                            // },
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
                                        Icons.timer_outlined
                                    ),
                                    const SizedBox(width: 10,),
                                    Text(
                                        'Time',
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
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: VerticalDivider(
                            color: Colors.grey,
                            thickness: 1.0,
                          ),
                        ),

                        // All day button
                        Expanded(
                          child: GestureDetector(
                            // onTap: () {
                            //   todoViewModel.selectAllDay();
                            //   FocusScope.of(context).unfocus();
                            // },
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
                                        Icons.save_alt
                                    ),
                                    const SizedBox(width: 10,),
                                    Text(
                                        'Save',
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
