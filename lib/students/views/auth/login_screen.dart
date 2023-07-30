import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itechon/admin/views/auth/admin_login_screeen.dart';
import 'package:itechon/students/views/home/student_home_screen.dart';
import '../../../admin/views/home/home_screen.dart';
import '../../../common/custom_text.dart';
import '../../../common/height_spacer.dart';
import '../../../consts/colors.dart';
import 'signup_screen.dart';
import 'components/auth_background.dart';
import 'components/auth_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.sizeOf(context).height;
    double width=MediaQuery.sizeOf(context).width;
    return authBackground(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal:width*0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 92.h,
                clipBehavior: Clip.antiAlias,
                width: 385.w,
                decoration: const BoxDecoration(

                ),
                child: Image.asset('assets/images/app_logo.png',fit: BoxFit.fill,),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 581.h,
                  width: 419.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color:kLightBlue.withOpacity(0.86),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(vertical: height*0.04,horizontal: width*0.02),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        customText(text: "Log In",color: kLight,size:36.sp,fw: FontWeight.w700 ),
                        heightSpacer(height: height*0.02),
                        authTextField(imagePath: "assets/icons/mail.png",hint: "Enter Your Email"),
                        authTextField(imagePath: "assets/icons/Vector.png",hint: "Password"),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const StudentHome()), (route) => false);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 45.92.h,
                            width: 135.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: kLight
                            ),
                            child: customText(text: "Log in",color: kLightBlue,fw: FontWeight.w600,size: 18.sp),
                          ),
                        ),
                        heightSpacer(height: height*0.006),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignupScreen()));
                          },
                          child: RichText(text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Don't have an account? ",
                                  style: appStyle(
                                    size:13.sp,
                                    color: kLight,
                                    fw: FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                  text: "Sign Up",
                                  style: appStyle(
                                    size: 13.sp,
                                    color: kLight,
                                    fw: FontWeight.bold,
                                  ),
                                ),
                              ]
                          )),
                        ),
                        heightSpacer(height: 30.h),
                        GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const AdminLoginScreen()));
                            },
                            child: customText(text: "Log In as Admin",size: 13.sp,fw: FontWeight.w700,color: kLight)),

                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
