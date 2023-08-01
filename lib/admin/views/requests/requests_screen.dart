import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itechon/admin/provider/event_provider.dart';
import 'package:itechon/admin/views/requests/components/text_tile.dart';
import 'package:itechon/common/custom_button.dart';
import 'package:itechon/common/custom_text.dart';
import 'package:itechon/common/height_spacer.dart';
import 'package:itechon/services/firebase_services.dart';

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
        child: StreamBuilder(
            stream: FirebaseServices.getAllRequests(),
            builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          else if(snapshot.data!.docs.isEmpty || !snapshot.hasData || snapshot.hasError || snapshot.data==null){
            return Center(child: customText(text: "No Pending Requests",color: Colors.black.withOpacity(0.5),fw: FontWeight.bold,size: 40.sp),);
          }
          else{
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.antiAlias,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,index){
                  print(snapshot.data!.docs[index]);
                  var data=snapshot.data!.docs[index];
                  return Column(
                    children: [
                      Padding(
                        padding:EdgeInsets.only(left: 185.w,right: 185.w,top: 26.h,bottom: 10.h),
                        child: Container(
                            width: 911.w,
                            height: 500.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromRGBO(0, 0, 0, 0.05)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.symmetric(vertical: 50.h,horizontal: 40.w),
                                  child: Column(
                                    children: [
                                      textTile(title: "Team Name",value: data['team_name'],isExpanded: false),
                                      textTile(title: "Team Members",value:"\n"+ data['team_members'],isExpanded: true),
                                      textTile(title: "WA",value: data["whatsapp"],isExpanded: false),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 462.h,
                                      width: 455.w,
                                      decoration:  BoxDecoration(
                                          image: DecorationImage(image: NetworkImage(data["image_url"]),
                                            fit: BoxFit.fill,)
                                      ),
                                      clipBehavior: Clip.antiAlias,

                                    ),
                                    heightSpacer(height: 30.h),

                                  ],
                                )

                              ],
                            )
                        ),
                      ),

                      SizedBox(
                        width: 455.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            customButton(text: "Decline",color: Colors.red.withOpacity(0.9),height: 66.h,width: 202.w,onTap: (){
                              EventProvider().declineStudent(data['uid']);
                            }),
                            heightSpacer(height: 52.w),
                            customButton(text: "Approve",color: Colors.green.withOpacity(0.8),height: 66.h,width: 202.w,onTap: (){
                              EventProvider().approveStudent(data['uid']);
                            }),
                          ],
                        ),
                      )
                    ],
                  );
                });
          }
        })
      )
    );
  }
}
