import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/custom_text.dart';
import '../../../../consts/colors.dart';

Container authTextField({final String? hint,final String? imagePath,final TextEditingController? controller,bool isObsecure=false}){
  return Container(
    height: 51.91.h,
    width: 302.w,
    child: TextFormField(
      obscureText: isObsecure,
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: kLightBlue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: kLightBlue),
        ),
        prefixIcon: Image.asset(imagePath!,width: 30.w,height: 23.96.h,),
        hintText: hint,
        hintStyle: appStyle(
          fw: FontWeight.w400,
          color: Colors.black.withOpacity(0.5),
          size: 18.sp,

        ),

      ),
    ),
  );
}