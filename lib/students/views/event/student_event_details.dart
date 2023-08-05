import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itechon/consts/firebase_consts.dart';
import 'package:itechon/services/firebase_services.dart';
import 'package:itechon/students/views/event/enrollment_screen.dart';

import '../../../common/custom_appbar.dart';
import '../../../common/custom_button.dart';
import '../../../common/custom_text.dart';
import '../../../common/height_spacer.dart';
import '../../../consts/colors.dart';

class StudentEventDetails extends StatelessWidget {
  final dynamic data;
  const StudentEventDetails({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double height=MediaQuery.sizeOf(context).height;
    double width=MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: kLight,
      appBar: PreferredSize(preferredSize: Size.fromHeight(height*0.1), child: customAppBar(context: context,isAdmin: false)),
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
                    image:  DecorationImage(image: NetworkImage(data['event_image']),fit: BoxFit.cover)
                ),


              ),
              heightSpacer(height: height*0.03),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 100.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        customText(text: data['event_name'],size: 40.sp,color: kLightBlue,fw: FontWeight.w800),
                        const Spacer(),
                        customText(text: "${data['event_date']}, ${data['event_time']}",size: 20.sp,color: kLightBlue,fw: FontWeight.w700),
                      ],
                    ),
                    heightSpacer(height: 20.h),
                    customText(text: data['event_description'],fw: FontWeight.w400,size: 18.sp,color: kLightBlue),
                    heightSpacer(height: 20.h),
                    RichText(text: TextSpan(
                        children:[
                          TextSpan(
                              text: "Venue: ",
                              style: appStyle(size: 30.sp,fw: FontWeight.w800,color: kLightBlue)
                          ),
                          TextSpan(
                              text: data['event_venue'],
                              style: appStyle(size: 30.sp,fw: FontWeight.w400,color: kLightBlue)
                          ),
                        ]
                    )),
                  heightSpacer(height: 30.h),
                  // data['enrolled_students']?Align(
                  //     alignment: Alignment.center,
                  //     child: customButton(height: 66.h,width: 246.w,text: "Enroll Now",color: kLightBlue,onTap: (){
                  //       Navigator.push(context, MaterialPageRoute(builder: (context)=> EnrollmentScreen(data: data,)));
                  //     })):
                    StreamBuilder(
                        stream: firestore.collection(eventCollection)
                            .doc(data.id).collection(requestsCollection)
                            .where('uid',isEqualTo: auth.currentUser!.uid).snapshots(),
                        builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return SizedBox.shrink();
                      }
                      else if(snapshot.data!.docs.isNotEmpty){
                        return snapshot.data!.docs[0]['status']=='pending'?
                        Align(
                            alignment: Alignment.center,
                            child: customButton(height: 66.h,width: 246.w,text: "Pending",color: Colors.grey.withOpacity(0.3),onTap: (){
                            })):
                        snapshot.data!.docs[0]['status']=='approved'?

                        SizedBox.shrink():snapshot.data!.docs[0]['status']=='declined'?
                        Align(
                            alignment: Alignment.center,
                            child: customButton(height: 66.h,width: 246.w,text: "Declined",color: Colors.red,onTap: (){
                            })):Align(
                            alignment: Alignment.center,
                            child: customButton(height: 66.h,width: 246.w,text: "Enroll Now",color: kLightBlue,onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> EnrollmentScreen(data: data,)));
                            }));
                      }
                      else{
                        return Align(
                            alignment: Alignment.center,
                            child: customButton(height: 66.h,width: 246.w,text: "Enroll Now",color: kLightBlue,onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> EnrollmentScreen(data: data,)));
                            }));
                      }
                    })
                  ],
                ),
              ),
              heightSpacer(height: 50.h),
              data['is_concert']==false?Align(
                  alignment: Alignment.centerLeft,
                  child: customText(text: "Score Board",size: 40.sp,fw: FontWeight.w800,color: kLightBlue)):SizedBox.shrink(),
              heightSpacer(height: 50.h),
              data['is_concert']==false?Row(
                children: [
                  customText(text: "Team Name",size: 30.sp,fw: FontWeight.w500,color: Colors.black.withOpacity(0.5)),
                  const Spacer(),
                  customText(text: "Score",size: 30.sp,fw: FontWeight.w500,color: Colors.black.withOpacity(0.5))
                ],
              ):SizedBox.shrink(),
              data['is_concert']==false?Column(children: List.generate(data['scoreBoard'].length, (index){
                return Column(
                  children: [
                    const Divider(),

                    heightSpacer(height: 36.h),
                    Row(
                      children: [
                        customText(text: data["scoreBoard"][index]['team'],size: 30.sp,fw: FontWeight.w500,color: Colors.black.withOpacity(0.5)),
                        const Spacer(),
                        customText(text: data["scoreBoard"][index]['score'],size: 30.sp,fw: FontWeight.w500,color: Colors.black.withOpacity(0.5))
                      ],
                    ),

                  ],
                );
              }),):SizedBox.shrink(),
              heightSpacer(height: 68.h),
              heightSpacer(height: 50.h),
              Row(
                children: [
                  customText(text: "Enrolled",size: 40.sp,fw: FontWeight.w800,color: kLightBlue),
                ],
              ),
              StreamBuilder(
                stream: FirebaseServices.getEnrolledTeams(data.id),
                  builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return const SizedBox.shrink();
                    }
                    else{
                      return Column(children: List.generate(snapshot.data!.docs.length, (index){
                        return Column(
                          children: [
                            const Divider(),

                            heightSpacer(height: 36.h),
                            Row(
                              children: [
                                customText(text: snapshot.data!.docs[index]['team_name'],size: 30.sp,fw: FontWeight.w500,color: Colors.black.withOpacity(0.5)),
                              ],
                            ),
                          ],
                        );
                      }),);
                    }
                  }),
              heightSpacer(height: 68.h),
            ],
          ),
        ),
      ),
    );
  }
}
