import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itechon/consts/colors.dart';

import '../../../common/custom_appbar.dart';
import '../../../common/custom_button.dart';
import '../../../common/custom_text.dart';
import '../../../common/height_spacer.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.sizeOf(context).height;
    double width=MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: kLight,
      appBar: PreferredSize(preferredSize: Size.fromHeight(height*0.1), child: customAppBar(context: context)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.1),

          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                height: 439.h,
                width: 904.w,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(image: NetworkImage("https://cdn.pixabay.com/photo/2019/04/17/22/00/billiards-4135500_1280.jpg"),fit: BoxFit.cover)
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                  child: customText(text:"⚫  Coming soon",size: 20.sp,color: Colors.yellow,fw: FontWeight.w700),
                ),

              ),
              heightSpacer(height: height*0.03),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 100.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        customText(text: "Snooker Competition",size: 40.sp,color: kLightBlue,fw: FontWeight.w800),
                        const Spacer(),
                        customText(text: "Monday, 9:00pm - 10:00 pm",size: 20.sp,color: kLightBlue,fw: FontWeight.w700),
                      ],
                    ),
                    heightSpacer(height: 20.h),
                    customText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc faucibus consectetur orci nec condimentum. Suspendisse vitae lacus faucibus purus mollis facilisis. Vestibulum vitae ullamcorper purus.Integer vitae dolor ac massa viverra pretium. Nunc ipsum ligula, auctor elementum nunc quis, ultricies auctor quam. Nam feugiat, justo sed vehicula hendrerit, libero tellus dignissim nunc, vel tempor augue ante mattis enim. Proin ante diam, congue ac interdum non, ullamcorper id lectus. In ac egestas sapien, sit amet congue tortor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam tortor sem, tincidunt sed posuere imperdiet, pretium ut eros. Phasellus auctor bibendum dolor, id euismod velit. Cras rhoncus magna blandit nisi scelerisque, nec lacinia lorem rutrum. Nunc tristique gravida nibh, et tincidunt enim accumsan at. Vivamus dapibus venenatis orci ac interdum. Curabitur vitae interdum mi, eget convallis urna. Nulla id auctor erat.Integer luctus ligula nec eros congue bibendum. Curabitur id lorem et ipsum interdum auctor sit amet id mauris. Sed varius lorem turpis. Integer ultricies, dolor at ullamcorper porta, arcu orci vehicula sem, at fringilla eros libero at justo. Sed aliquam at purus at consequat. Morbi sit amet ullamcorper dolor. Vivamus ut massa vulputate, feugiat nisi at, tempus ipsum. Etiam aliquet nunc turpis, elementum venenatis urna consectetur sed. Aliquam venenatis mi sit amet lorem pharetra, et facilisis metus tristique. Morbi ut nisi tempor, finibus ex eget, placerat nunc. Etiam ut consequat ligula, ac lacinia nisi.Vivamus accumsan purus maximus aliquet hendrerit. Nam condimentum tortor sed pellentesque molestie. Sed id iaculis sapien. Sed efficitur ornare purus eu fringilla. Nullam.",
                        fw: FontWeight.w400,size: 18.sp,color: kLightBlue),
                    heightSpacer(height: 20.h),
                    RichText(text: TextSpan(
                      children:[
                        TextSpan(
                          text: "Venue: ",
                          style: appStyle(size: 30.sp,fw: FontWeight.w800,color: kLightBlue)
                        ),
                        TextSpan(
                            text: "Jinnah Lab",
                            style: appStyle(size: 30.sp,fw: FontWeight.w400,color: kLightBlue)
                        ),
                      ]
                    )),
                    heightSpacer(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        customButton(height: 66.h,width:246.w,text: "Update Event",color: kLightBlue),
                        customButton(height: 66.h,width:246.w,text: "Delete Event",color: Colors.red.withOpacity(0.75)),
                      ],
                    )
                  ],
                ),
              ),
              heightSpacer(height: 50.h),
              customText(text: "Score Board",size: 40,fw: FontWeight.w800,color: kLightBlue),
              heightSpacer(height: 50.h),
              Row(
                children: [
                  customText(text: "Team Name",size: 30.sp,fw: FontWeight.w500,color: Colors.black.withOpacity(0.5)),
                  const Spacer(),
                  customText(text: "Score",size: 30.sp,fw: FontWeight.w500,color: Colors.black.withOpacity(0.5))
                ],
              ),
              Column(children: List.generate(4, (index){
                return Column(
                  children: [
                    const Divider(),

                    heightSpacer(height: 36.h),
                    Row(
              children: [
                    customText(text: "Team $index",size: 30.sp,fw: FontWeight.w500,color: Colors.black.withOpacity(0.5)),
                    const Spacer(),
                    customText(text: "100",size: 30.sp,fw: FontWeight.w500,color: Colors.black.withOpacity(0.5))
              ],
                    ),

                  ],
                );
              }),),
              heightSpacer(height: 68.h),
              customButton(height: 66.h,width: 246.w,text: "Update Score Board",color: kLightBlue),
              heightSpacer(height: 50.h),
              Row(
                children: [
                  customText(text: "Enrolled Teams",size: 30.sp,fw: FontWeight.w500,color: Colors.black.withOpacity(0.5)),
                  const Spacer(),
                  customText(text: "Whatsapp Number",size: 30.sp,fw: FontWeight.w500,color: Colors.black.withOpacity(0.5))
                ],
              ),
              Column(children: List.generate(4, (index){
                return Column(
                  children: [
                    const Divider(),

                    heightSpacer(height: 36.h),
                    Row(
                      children: [
                        customText(text: "Team $index",size: 30.sp,fw: FontWeight.w500,color: Colors.black.withOpacity(0.5)),
                        const Spacer(),
                        customText(text: "+92323$index xxxxxxx",size: 30.sp,fw: FontWeight.w500,color: Colors.black.withOpacity(0.5))
                      ],
                    ),

                  ],
                );
              }),),
              heightSpacer(height: 68.h),
            ],
          ),
        ),
      ),
    );
  }
}
