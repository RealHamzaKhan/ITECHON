import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itechon/admin/views/events/event_details.dart';

import '../consts/colors.dart';
import 'custom_text.dart';
import 'height_spacer.dart';

class EventTile extends StatelessWidget {
  final double height;
  final double width;
  final Function()? onTap;
  final dynamic data;
  const EventTile({Key? key, required this.height, required this.width, this.onTap,required this.data}) : super(key: key);

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
              decoration:  BoxDecoration(
                  image: DecorationImage(image: NetworkImage(data["event_image"]),fit: BoxFit.cover)
              ),
              clipBehavior: Clip.antiAlias,
            ),
          ),
          Expanded(child: Padding(
            padding:EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
            child: Column(
              children: [
                heightSpacer(height: 9.h),
                customText(text: data["event_name"],fw: FontWeight.w800,size: 20.sp,alignment: TextAlign.center),
                heightSpacer(height: 5.h),
                customText(text: "${data["event_date"]+" "+data["event_time"]}",fw: FontWeight.w300,color: Colors.black.withOpacity(0.5),size: 15.sp),
                heightSpacer(height: 6.h),
                customText(text: data["event_description"].toString().length>100?"${data["event_description"].toString().substring(0,100)} ....":data["event_description"].toString(), fw: FontWeight.w400,color: Colors.black.withOpacity(0.8),size: 15.sp,alignment: TextAlign.center),
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
