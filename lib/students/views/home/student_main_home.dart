import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itechon/common/custom_text.dart';
import 'package:itechon/common/height_spacer.dart';

import '../../../common/custom_appbar.dart';
import '../../../consts/colors.dart';

class StudentMainHome extends StatelessWidget {
  const StudentMainHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.sizeOf(context).height;
    double width=MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height*0.1),
        child: customAppBar(context: context,isAdmin:false),
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              kLight,
              kLightBlue
            ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
                padding:  EdgeInsets.symmetric(vertical: 30.h,horizontal: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customText(text: "ITECHON brought to you by IIT is the first of it's kind diverse mega annual event at QAU. ITECHON spans various activities including competitions in art, music, poetry, drama, literature, debates, outdoor-indoor sports, technology and business ideas.Moreover ITECHON provides opportunity for small businesses to put up stalls at the Itechonminimarket at IT lawns. Series of seminars by tech experts throughout the week.The finale is power packed with all best performers of ITECHON showcasing their talents, launch of the IIT annual magazine and last but not the least, closing on a rocking concert. Students from QAU and other universities attended to experience the most exciting and exhilarating event of the year.",
                      size: 16.sp,
                    ),
                    heightSpacer(height: 50.h),
                    customText(text: "Message from Mentors",color: Colors.black,size: 25.sp,fw: FontWeight.bold),
                    heightSpacer(height: 20.h),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      height: 400.h,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 300.h,
                              width: 400.w,
                              child: Image.asset("assets/images/mentors.jpeg",fit: BoxFit.fill,)),
                         heightSpacer(height: 10.h),
                          customText(text: "ITECHON provides opportunity for small businesses to put up stalls at the Itechonminimarket at IT lawns. Series of seminars by tech experts throughout the week.The finale is power packed with all best performers of ITECHON showcasing their talents, launch of the IIT annual magazine and last but not the least, closing on a rocking concert. Students from QAU and other universities attended to experience the most exciting and exhilarating event of the year.",size: 16.sp),
                        ],
                      ),
                    ),
                    heightSpacer(height: 20.h),
                    customText(text: "Contact Us",color: Colors.black,size: 25.sp,fw: FontWeight.bold),
                    heightSpacer(height: 10.h),
                    customText(text: "instagram: itechonQAU",fw: FontWeight.w500,size: 16.sp),
                    heightSpacer(height: 10.h),
                    customText(text: "Email: itechon@qau.com",fw: FontWeight.w500,size: 16.sp),
                  ],
                )
            ),
          )
      ),
    );
  }
}
