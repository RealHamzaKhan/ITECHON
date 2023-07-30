import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../consts/colors.dart';
import 'custom_text.dart';
import 'height_spacer.dart';

class EventTile extends StatelessWidget {
  final double height;
  final double width;
  final Function()? onTap;
  const EventTile({Key? key, required this.height, required this.width, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 437.h,
      width: 303.w,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)

      ),
      child: Column(
        children: [
          Align(alignment: Alignment.topCenter,
            child: Container(
              height: 185.h,
              width: 303.w,
              decoration: const BoxDecoration(
                  image: DecorationImage(image: NetworkImage("https://cdn.pixabay.com/photo/2017/01/09/22/24/guy-playing-billiard-1967834_1280.jpg"),fit: BoxFit.cover)
              ),
              clipBehavior: Clip.antiAlias,

            ),
          ),
          Expanded(child: Padding(
            padding:EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
            child: Column(
              children: [
                heightSpacer(height: 9.h),
                customText(text: "Snooker Competition",fw: FontWeight.w800,size: 20.sp,alignment: TextAlign.center),
                heightSpacer(height: 5.h),
                customText(text: "Monday, 9:00pm - 10:00pm",fw: FontWeight.w300,color: Colors.black.withOpacity(0.5),size: 15.sp),
                heightSpacer(height: 6.h),
                customText(text: "Lorem Ipsum is simply dummy text of unknown printer took a galley of type and scrambled it to make a type specimen book....",
                    fw: FontWeight.w400,color: Colors.black.withOpacity(0.8),size: 15.sp,alignment: TextAlign.center),
                const Spacer(),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    alignment: Alignment.center,
                    height: 46.h,
                    width: 140.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: kLightBlue
                    ),
                    child: customText(text: "View More",color: kLight,fw: FontWeight.w600,size: 18.sp),
                  ),
                ),
              ],
            ),
          ))

        ],
      ),
    );

  }
}
