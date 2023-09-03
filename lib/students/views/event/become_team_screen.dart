import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itechon/common/height_spacer.dart';
import 'package:itechon/common/textfield_with_title.dart';
import 'package:provider/provider.dart';
import '../../../common/custom_appbar.dart';
import '../../../common/custom_button.dart';
import '../../../consts/colors.dart';
import '../../provider/enrollment_provder.dart';

class TeamEnrollment extends StatefulWidget {
  const TeamEnrollment({Key? key}) : super(key: key);

  @override
  State<TeamEnrollment> createState() => _TeamEnrollmentState();
}

class _TeamEnrollmentState extends State<TeamEnrollment> {
  TextInputFormatter nameInputFormatter =
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'));
  TextInputFormatter whatsappInputFormatter =
      FilteringTextInputFormatter.allow(RegExp(r'[1-9\s]'));
  TextInputFormatter semesterInputFormatter =
      FilteringTextInputFormatter.allow(RegExp(r'[0-9\s]'));

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController whatsapp = TextEditingController();
  TextEditingController semester = TextEditingController();
  TextEditingController teamName = TextEditingController();
  TextEditingController qauId = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    name.dispose();
    email.dispose();
    whatsapp.dispose();
    semester.dispose();
    teamName.dispose();
    qauId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height * 0.1),
          child: customAppBar(context: context, isAdmin: false),
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
          child: SingleChildScrollView(
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 177.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textFormFieldWithTitle(
                                  formatters: [nameInputFormatter],
                                  title: "Name",
                                  hint: "ENTER YOUR NAME",
                                  minlines: 1,
                                  controller: name),
                              heightSpacer(height: 40.h),
                              textFormFieldWithTitle(
                                  title: "Email",
                                  hint: "ENTER YOUR EMAIL",
                                  minlines: 1,
                                  controller: email),
                              heightSpacer(height: 40.h),
                              textFormFieldWithTitle(
                                  formatters: [whatsappInputFormatter],
                                  title: "Whatsapp",
                                  hint: "",
                                  minlines: 1,
                                  controller: whatsapp),
                              heightSpacer(height: 40.h),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textFormFieldWithTitle(
                                  formatters: [semesterInputFormatter],
                                  title: "Semester",
                                  hint: "Semester you are currently in",
                                  minlines: 1,
                                  controller: semester),
                              heightSpacer(height: 40.h),
                              textFormFieldWithTitle(
                                  title: "Team Name",
                                  hint: "I want to be a part of team ......",
                                  minlines: 1,
                                  controller: teamName),
                              heightSpacer(height: 40.h),
                              textFormFieldWithTitle(
                                  title: "QAU ID (Optional)",
                                  hint: "",
                                  minlines: 1,
                                  controller: qauId),
                              heightSpacer(height: 40.h),
                            ],
                          ),
                        ],
                      ),
                      heightSpacer(height: 40.h),
                      Consumer<EnrollmentProvider>(
                          builder: (context, provider, child) {
                        return provider.isLoading
                            ? Align(
                                alignment: Alignment.center,
                                child: customButton(
                                    height: 66.h,
                                    width: 246.w,
                                    text: "Apply",
                                    color: Colors.grey.withOpacity(0.2),
                                    onTap: () {}))
                            : Align(
                                alignment: Alignment.center,
                                child: customButton(
                                    height: 66.h,
                                    width: 246.w,
                                    text: "Apply",
                                    color: kLightBlue,
                                    onTap: () {
                                      provider.enrollInTeam(
                                          context: context,
                                          name: name.text,
                                          email: email.text,
                                          teamName: teamName.text,
                                          semester: semester.text,
                                          whatsapp: whatsapp.text,
                                          qauId: qauId.text);
                                    }));
                      })
                    ],
                  ))),
        ));
  }
}
