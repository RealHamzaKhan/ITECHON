import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itechon/admin/views/scoreboard/score_board_dynamic_widget.dart';
import 'package:itechon/common/custom_text.dart';
import 'package:itechon/common/height_spacer.dart';
import 'package:itechon/common/width_spacer.dart';

import '../../../consts/colors.dart';

class UpdateScoreBoardScreen extends StatefulWidget {
  const UpdateScoreBoardScreen({Key? key}) : super(key: key);

  @override
  State<UpdateScoreBoardScreen> createState() => _UpdateScoreBoardScreenState();
}

class _UpdateScoreBoardScreenState extends State<UpdateScoreBoardScreen> {
  bool validation = false;
  List<TeamScoreWidget> dynamicWidget = [
    TeamScoreWidget(),
    TeamScoreWidget(),
    TeamScoreWidget()
  ];
  void addWidget() {
    dynamicWidget.add(TeamScoreWidget());
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
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
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 50.w, vertical: 50.h),
          child: Column(
            children: [
              //MyCustomWidget(),
              Expanded(
                child: ListView.builder(
                    itemCount: dynamicWidget.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          dynamicWidget[index],
                          heightSpacer(height: 50.h),
                        ],
                      );
                    }),
              ),

              GestureDetector(
                onTap: () {
                  addWidget();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 70.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: kLightBlue,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add_comment_outlined,
                        size: 30,
                        color: kLight,
                      ),
                      widthSpacer(width: 30.w),
                      customText(text: "Add Team",size: 25.sp,color: kLight,fw: FontWeight.w800)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h
              ),
              GestureDetector(
                onTap: () {
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 70.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.greenAccent.withOpacity(0.4),
                  ),
                  child: customText(text: "Update Score",size: 25.sp,color: kLight,fw: FontWeight.w800)
                ),
              ),
            ],
          ),
        )),
      );
  }
}