import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showCustomSnackbar(BuildContext context, String text, Color color) {
   final snackBar = SnackBar(
      backgroundColor: color, // Set the snackbar background color to transparent
      elevation: 0, // Remove the shadow
      behavior: SnackBarBehavior.floating, // Make the snackbar float above the content
      shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      duration: Duration(seconds: 3), // Adjust the duration as per your requirement
      content: Container(
         alignment: Alignment.center,
         padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
         decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10), // Rounded corners to match the shape
            boxShadow: [
               BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  spreadRadius: 1,
                  offset: Offset(0, 2), // Add a subtle shadow to the snackbar
               ),
            ],
         ),
         child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 16), // Customize text style
         ),
      ),
      margin: EdgeInsets.symmetric(vertical: 20.h,horizontal: 100.w), // Add some margin around the snackbar
      padding: EdgeInsets.zero,
   );

   ScaffoldMessenger.of(context).showSnackBar(snackBar);
}