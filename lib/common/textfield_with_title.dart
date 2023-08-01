import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../consts/colors.dart';
import 'custom_text.dart';
import 'height_spacer.dart';

Column textFormFieldWithTitle({final String? title,final String? hint,final TextEditingController? controller,final int? minlines}){
  return  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      customText(
          text: title??"",
          color: Colors.black,
          size: 18.sp,
          fw: FontWeight.bold),
      heightSpacer(height: 9.h),
      Container(
        width: 367.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kTextFieldColor,
        ),
        child: TextFormField(
          minLines: minlines,
          maxLines: null,
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 17.w,vertical: 13.h),
            border: InputBorder.none,
            hintText: hint,
            hintStyle: appStyle(
              fw: FontWeight.w400,
              color: Colors.black.withOpacity(0.5),
              size: 18.sp,
            ),
          ),
        ),
      ),
    ],
  );
}