import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget progressIndicator(){
  return Container(
    color: Colors.transparent,
    height: 600.h,
    width: 800.w,
    child: const Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator()),
  );
}