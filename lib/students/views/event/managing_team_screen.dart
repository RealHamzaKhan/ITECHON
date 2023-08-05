import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itechon/consts/colors.dart';
import '../../../common/custom_appbar.dart';
import '../../../common/custom_text.dart';
import '../../../common/height_spacer.dart';
import '../../../services/firebase_services.dart';


class ManagingTeamScreen extends StatelessWidget {
  const ManagingTeamScreen({Key? key}) : super(key: key);

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
                padding:  EdgeInsets.symmetric(vertical: height*0.07),
                child: StreamBuilder(
                    stream: FirebaseServices.getTeams(),
                    builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return  Container(
                          color: Colors.transparent,
                          height: 600.h,
                          width: 800.w,
                          child: const Align(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator()),
                        );
                      }
                      else{
                        return Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.spaceEvenly,
                          spacing: width*0.06,
                          runSpacing: height*0.1,
                          children: List.generate(snapshot.data!.docs.length, (index){
                            dynamic data=snapshot.data!.docs[index];
                            return Container(
                              width: 450.w,
                              height: 600.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)

                              ),
                              child: Column(
                                children: [
                                  Align(alignment: Alignment.topCenter,
                                    child: Container(
                                      height: 450.h,
                                      width: 450.w,
                                      decoration:  BoxDecoration(
                                          image: DecorationImage(image: NetworkImage(data["team_image"]),fit: BoxFit.fill)
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                    ),
                                  ),
                                  Expanded(child: Padding(
                                    padding:EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                                    child: Column(
                                      children: [
                                        heightSpacer(height: 9.h),
                                        customText(text: data["team_name"],fw: FontWeight.w800,size: 20.sp,alignment: TextAlign.center),
                                        heightSpacer(height: 5.h),
                                        customText(text: data["team_description"], fw: FontWeight.w400,color: Colors.black.withOpacity(0.8),size: 15.sp,alignment: TextAlign.center),

                                      ],
                                    ),
                                  ))

                                ],
                              ),
                            );
                          }),
                        );
                      }
                    })
            ),
          )
      ),
    );
  }
}
