import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'width_spacer.dart';

import 'custom_text.dart';

class AppBarActions extends StatelessWidget {
  final String iconPath;
  final String text;
  final Function()? onTap;
  const AppBarActions({Key? key, required this.iconPath, required this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(iconPath,height: 24.h,width: 24.w,color: Colors.black,),
          widthSpacer(width: 6.w),
          customText(text: text,size: 20.sp,fw: FontWeight.w600,color: Colors.black)
        ],
      ),
    );
  }
}
