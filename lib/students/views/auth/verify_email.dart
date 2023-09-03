import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itechon/common/custom_button.dart';
import 'package:itechon/common/custom_text.dart';
import 'package:itechon/common/height_spacer.dart';
import 'package:itechon/consts/colors.dart';
import 'package:itechon/consts/firebase_consts.dart';
import 'package:itechon/students/views/auth/login_screen.dart';
import 'package:itechon/utils/snackbar.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  bool isEmailVerified=false;
  int counter=60;
  Timer? timer;
  Timer? countdown;
  @override
  void initState() {
    // TODO: implement initState
    timer=Timer.periodic(Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });
    startCounter();
    super.initState();
  }
  startCounter(){
    counter=60;
    countdown=Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if(counter>0){
          counter--;
        }
        else{
          countdown!.cancel();
        }
      });
    });
  }
  checkEmailVerified()async{
    await auth.currentUser!.reload();
    setState(() {

      isEmailVerified=auth.currentUser!.emailVerified;
      if(isEmailVerified){
        showCustomSnackbar(context,"Email has been verified", Colors.green);
        timer!.cancel();
        countdown!.cancel();
      }
    });

  }
  sendVerificationEmail()async{
    await auth.currentUser!.sendEmailVerification();
  }
  @override
  Widget build(BuildContext context) {
    return isEmailVerified?const LoginScreen():Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customText(text: "Verification Email has been sent to your email. Kindly verify you email to continue with us.",
            size: 20.sp,color: Colors.black.withOpacity(0.5),fw: FontWeight.normal,alignment: TextAlign.center),
            heightSpacer(height: 30.h),
            customButton(height: 60.h,width: 200.w,text:counter==0? "Resend email":"Sent",color: counter==0?kLightBlue:kLightBlue.withOpacity(0.4),onTap: (){
              if(counter==0){
                sendVerificationEmail();
                counter=60;
                startCounter();
                setState(() {

                });
              }
            }),
            heightSpacer(height: 30.h),
            customText(text: counter==0?"":"Resend in $counter seconds",color: Colors.greenAccent),
            heightSpacer(height: 50.h),
            GestureDetector(
                onTap: (){
                  auth.signOut();
                  Navigator.pop(context);
                },
                child: customText(text: "Cancel",color: Colors.red,fw: FontWeight.w900,size: 25.sp)),
            heightSpacer(height: 50.h),
          ],
        ),
      ),
    );
  }
}
