import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itechon/common/custom_text.dart';
import 'package:itechon/common/height_spacer.dart';
import 'package:itechon/common/textfield_with_title.dart';
import '../../../common/custom_appbar.dart';
import '../../../common/custom_button.dart';
import '../../../common/width_spacer.dart';
import '../../../consts/colors.dart';

class EnrollmentScreen extends StatefulWidget {
  const EnrollmentScreen({Key? key}) : super(key: key);

  @override
  State<EnrollmentScreen> createState() => _EnrollmentScreenState();
}

class _EnrollmentScreenState extends State<EnrollmentScreen> {
  PlatformFile? _imageFile;
  Future<void> pickImage()async{
    FilePickerResult? result=await FilePicker.platform.pickFiles(
        type: FileType.image
    );
    if(result==null){
      return;
    }
    else{
      setState(() {
        _imageFile = result.files.first;
      });
    }
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
                                  title: "Name",
                                  hint: "ENTER YOUR NAME",
                                  minlines: 1),
                              heightSpacer(height: 40.h),
                              textFormFieldWithTitle(
                                  title: "Email",
                                  hint: "ENTER YOUR EMAIL",
                                  minlines: 1),
                              heightSpacer(height: 40.h),
                              textFormFieldWithTitle(
                                  title: "Whatsapp", hint: "", minlines: 1),
                              heightSpacer(height: 40.h),
                              textFormFieldWithTitle(
                                  title: "Team Name", hint: "", minlines: 1),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textFormFieldWithTitle(
                                  title: "Team Members Name",
                                  hint: "ENTER ALL TEAM MEMBERS NAME(IF ANY)",
                                  minlines: 4),
                              heightSpacer(height: 40.h),
                              customText(
                                text:
                                    "Payment Details\nSaadaPay: 033xxxxxxxx\nEasypaisa: 03xxxxxx\nMeezan Bank:0xxxxx",
                                color: Colors.redAccent.withOpacity(0.5),
                                fw: FontWeight.w700,
                                size: 23.sp,
                              ),
                              heightSpacer(height: 40.h),
                              _imageFile==null?GestureDetector(
                                onTap: (){
                                  pickImage();
                                },
                                child: DottedBorder(
                                  color: Colors.black.withOpacity(0.3),
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(10),
                                  padding: const EdgeInsets.all(6),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 122.h,
                                      width: 310.w,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/icons/plus-circle.png',
                                            height: 24.h,
                                            width: 24.w,
                                            color: Colors.black.withOpacity(0.3),
                                          ),
                                          widthSpacer(width: 4.w),
                                          customText(
                                              text: "ADD PAYMENT PROOF SCREENSHOT",
                                              size: 18.sp,
                                              fw: FontWeight.w500,
                                              color:
                                                  Colors.black.withOpacity(0.3)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ):
                                  GestureDetector(
                                    onTap: (){
                                      pickImage();
                                    },
                                    child: Image.memory(Uint8List.fromList(_imageFile!.bytes!),height: 122.h,
                                      width: 310.w,),
                                  )
                            ],
                          ),
                        ],
                      ),
                      heightSpacer(height: 40.h),
                      Align(
                          alignment: Alignment.center,
                          child: customButton(height: 66.h,width: 246.w,text: "Apply",color: kLightBlue,onTap: (){

                          })),
                    ],
                  ))),
        ));
  }
}
