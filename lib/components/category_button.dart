import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/event_list/view_models/category_view_model.dart';

class DefaultCategoryButton extends StatelessWidget {
  final String category;
  const DefaultCategoryButton({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    CategoryViewModel categoryViewModel = context.watch<CategoryViewModel>();
    String selectedCategory = categoryViewModel.selectedCategory;

    return GestureDetector(
      onTap: () {
        categoryViewModel.setSelectedCategory(category);
        FocusScope.of(context).unfocus();

      },
      child: Container(
        decoration: BoxDecoration(
        //   border: Border.all(
        //   color: Colors.black,
        //   width: 0.001,
        // ),
          color: selectedCategory == category ? Colors.black : Colors.white70,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!, // Color of the shadow
              offset: Offset(0, 4), // Offset of the shadow (x, y)
              blurRadius: 2.0, // Radius of the shadow blur
              spreadRadius: 1.0, // How much the shadow should spread
            ),
          ],

        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
              category,
              style: GoogleFonts.montserrat(
                fontSize: 13,
                color: selectedCategory == category ? Colors.grey :  Colors.black ,
              )
          ),
        ),
      ),
    );
  }
}



class AddCategoryButton extends StatelessWidget {
  const AddCategoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryViewModel categoryViewModel = context.watch<CategoryViewModel>();
    bool addCategory = categoryViewModel.addCategory;

    return GestureDetector(
      onTap: () {
        categoryViewModel.setAddCategory();
      },
      child: Container(
        width: 160.0,
        decoration: BoxDecoration(
            // border: Border.all(
            //   color: Colors.black,
            //   width: 0.001,
            // ),
            color: addCategory ? Colors.black : Colors.white70,
            borderRadius: BorderRadius.circular(10),
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
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(
                  color: Colors.grey ,
                  Icons.library_add
              ),
              const SizedBox(width: 10.0,),
              Text(
                  'Add Category',
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    color: Colors.grey ,
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}








