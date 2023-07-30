import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itechon/admin/views/requests/components/text_tile.dart';
import 'package:itechon/common/custom_button.dart';
import 'package:itechon/common/custom_text.dart';
import 'package:itechon/common/height_spacer.dart';

import '../../../common/custom_appbar.dart';
import '../../../consts/colors.dart';

class RequestsScreen extends StatelessWidget {
  const RequestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.1),
        child: customAppBar(context: context),
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [kLight, kLightBlue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.antiAlias,
            itemCount: 5,
            itemBuilder: (context,index){
          return Padding(
            padding:EdgeInsets.only(left: 185.w,right: 185.w,top: 26.h,bottom: 50.h),
            child: Container(
              width: 911.w,
              height: 684.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(0, 0, 0, 0.05)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      textTile(title: "Team Name",value: "XYZ",isExpanded: false),
                      textTile(title: "Team Members",value: "\n1-\n2-\n3-\n4-\n",isExpanded: true),
                      textTile(title: "WA",value: "033xxxxxxxxxxxxxxx",isExpanded: false),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 462.h,
                        width: 455.w,
                        decoration: const BoxDecoration(
                          image: DecorationImage(image: NetworkImage("https://public.bnbstatic.com/image/cms/article/body/202302/d9f75be540977a5782c30a277ff180b1.jpeg"),
                            fit: BoxFit.fill,)
                        ),
                        clipBehavior: Clip.antiAlias,

                      ),
                      heightSpacer(height: 30.h),
                      SizedBox(
                        width: 455.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            customButton(text: "Decline",color: Colors.red.withOpacity(0.7),height: 66.h,width: 202.w),
                            heightSpacer(height: 52.w),
                            customButton(text: "Approve",color: Colors.greenAccent.withOpacity(0.8),height: 66.h,width: 202.w),
                          ],
                        ),
                      )

                    ],
                  )

                ],
              )
            ),
          );
        }),
      )
    );
  }
}
