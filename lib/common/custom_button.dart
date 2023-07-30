import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itechon/consts/colors.dart';
import 'custom_text.dart';

GestureDetector customButton({final double? height,final double? width,final String? text,final Function()? onTap,final Color? color}){
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: color,
      ),
      child: customText(text: text??"",size: 24.sp,fw: FontWeight.w400,color: kLight),
    ),
  );
}