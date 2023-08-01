import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itechon/admin/provider/event_provider.dart';
import 'package:itechon/admin/views/events/update_event_screen.dart';
import 'package:itechon/admin/views/scoreboard/update_score_board_screen.dart';
import 'package:itechon/common/progress_indicator.dart';
import 'package:itechon/consts/colors.dart';
import 'package:itechon/services/firebase_services.dart';
import 'package:provider/provider.dart';

import '../../../common/custom_appbar.dart';
import '../../../common/custom_button.dart';
import '../../../common/custom_text.dart';
import '../../../common/height_spacer.dart';

class EventDetails extends StatelessWidget {
  final dynamic data;
  const EventDetails({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EventProvider provider = Provider.of<EventProvider>(context, listen: false);
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: kLight,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(height * 0.1),
          child: customAppBar(context: context)),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.01, horizontal: width * 0.1),
            child: StreamBuilder(
                stream: FirebaseServices.getAllEvents(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return progressIndicator();
                  } else {
                    return Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          height: 439.h,
                          width: 904.w,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: NetworkImage(data['event_image']),
                                  fit: BoxFit.cover)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                          ),
                        ),
                        heightSpacer(height: height * 0.03),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 100.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  customText(
                                      text: data['event_name'],
                                      size: 40.sp,
                                      color: kLightBlue,
                                      fw: FontWeight.w800),
                                  const Spacer(),
                                  customText(
                                      text:
                                          "${data['event_date']}, ${data['event_time']}",
                                      size: 20.sp,
                                      color: kLightBlue,
                                      fw: FontWeight.w700),
                                ],
                              ),
                              heightSpacer(height: 20.h),
                              customText(
                                  text: data['event_description'],
                                  fw: FontWeight.w400,
                                  size: 18.sp,
                                  color: kLightBlue),
                              heightSpacer(height: 20.h),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "Venue: ",
                                    style: appStyle(
                                        size: 30.sp,
                                        fw: FontWeight.w800,
                                        color: kLightBlue)),
                                TextSpan(
                                    text: data['event_venue'],
                                    style: appStyle(
                                        size: 30.sp,
                                        fw: FontWeight.w400,
                                        color: kLightBlue)),
                              ])),
                              heightSpacer(height: 20.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  customButton(
                                      height: 66.h,
                                      width: 246.w,
                                      text: "Update Event",
                                      color: kLightBlue,
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateEventScreen(
                                                        data: data)));
                                      }),
                                  customButton(
                                      height: 66.h,
                                      width: 246.w,
                                      text: "Delete Event",
                                      color: Colors.red.withOpacity(0.75),
                                      onTap: () {
                                        provider.deleteEvent(
                                            context: context, id: data.id);
                                      }),
                                ],
                              )
                            ],
                          ),
                        ),
                        heightSpacer(height: 50.h),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: customText(
                                text: "Score Board",
                                size: 40,
                                fw: FontWeight.w800,
                                color: kLightBlue)),
                        heightSpacer(height: 50.h),
                        Row(
                          children: [
                            customText(
                                text: "Team Name",
                                size: 30.sp,
                                fw: FontWeight.w500,
                                color: kLightBlue),
                            const Spacer(),
                            customText(
                                text: "Score",
                                size: 30.sp,
                                fw: FontWeight.w500,
                                color: kLightBlue)
                          ],
                        ),
                        Column(
                          children:
                              List.generate(data['scoreBoard'].length, (index) {
                            return Column(
                              children: [
                                const Divider(),
                                heightSpacer(height: 36.h),
                                Row(
                                  children: [
                                    customText(
                                        text: data['scoreBoard'][index]["team"],
                                        size: 30.sp,
                                        fw: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.5)),
                                    const Spacer(),
                                    customText(
                                        text: data['scoreBoard'][index]["score"]
                                            .toString(),
                                        size: 30.sp,
                                        fw: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.5))
                                  ],
                                ),
                              ],
                            );
                          }),
                        ),
                        heightSpacer(height: 68.h),
                        customButton(
                            height: 66.h,
                            width: 246.w,
                            text: "Update Score Board",
                            color: kLightBlue,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateScoreBoardScreen(
                                            docId: data.id,
                                          )));
                            }),
                        heightSpacer(height: 50.h),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: customText(
                                text: "Enrolled Teams",
                                size: 40,
                                fw: FontWeight.w800,
                                color: kLightBlue)),
                        heightSpacer(height: 20.h),
                        Row(
                          children: [
                            customText(
                                text: "Team",
                                size: 30.sp,
                                fw: FontWeight.w500,
                                color: kLightBlue),
                            const Spacer(),
                            customText(
                                text: "Whatsapp Number",
                                size: 30.sp,
                                fw: FontWeight.w500,
                                color: kLightBlue)
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
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          customText(text: snapshot.data!.docs[index]['team_name'],size: 30.sp,fw: FontWeight.w500,color: Colors.black.withOpacity(0.5)),
                                          customText(text: snapshot.data!.docs[index]['whatsapp'],size: 30.sp,fw: FontWeight.w500,color: Colors.black.withOpacity(0.5)),
                                        ],
                                      ),
                                    ],
                                  );
                                }),);
                              }
                            }),
                        // StreamBuilder(
                        //     stream: FirebaseServices.getEnrolledTeams(data.id),
                        //     builder: (context,AsyncSnapshot<QuerySnapshot>enrollsnap){
                        //       if(!enrollsnap.hasError || !enrollsnap.hasData || enrollsnap.connectionState==ConnectionState.waiting || enrollsnap.data!.docs.isEmpty){
                        //         return const SizedBox.shrink();
                        //       }
                        //
                        //       else{
                        //
                        //         return Column(
                        //           children: List.generate(
                        //               enrollsnap.data!.docs.length, (index) {
                        //             return Column(
                        //               children: [
                        //                 const Divider(),
                        //                 heightSpacer(height: 36.h),
                        //                 Row(
                        //                   children: [
                        //                     customText(
                        //                         text:enrollsnap.data!.docs[index]['team_name'],
                        //                         size: 30.sp,
                        //                         fw: FontWeight.w500,
                        //                         color: Colors.black.withOpacity(0.5)),
                        //                     const Spacer(),
                        //                     customText(
                        //                         text: enrollsnap.data!.docs[index]['whatsapp']
                        //                             .toString(),
                        //                         size: 30.sp,
                        //                         fw: FontWeight.w500,
                        //                         color: Colors.black.withOpacity(0.5))
                        //                   ],
                        //                 ),
                        //               ],
                        //             );
                        //           }),
                        //         );
                        //       }
                        //
                        //     }),

                        heightSpacer(height: 68.h),
                      ],
                    );
                  }
                })),
      ),
    );
  }
}
