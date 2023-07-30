import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/custom_text.dart';
import '../../../../consts/colors.dart';

Padding textTile({final String? title,final String? value,required final bool isExpanded}){
  return Padding(
    padding: EdgeInsets.only(top: 50.h,left: 34.w,bottom: 30.h),
    child: Container(
      width: 253.w,
      height: isExpanded?164.h:49.h,
      padding: EdgeInsets.only(left: 10.w),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: kLightBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: RichText(text: TextSpan(
          children: [
            TextSpan(
              text: "$title: ",
              style: appStyle(size: 20.sp,fw: FontWeight.w600,color: kLight),
            ),
            TextSpan(
              text: "$value",
              style: appStyle(size: 20.sp,fw: FontWeight.w600,color: kLight),
            ),
          ]
      )),
    ),
  );
}