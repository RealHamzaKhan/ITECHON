import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itechon/students/provider/student_auth_provider.dart';
import 'package:itechon/students/views/home/student_home_screen.dart';
import 'package:provider/provider.dart';
import '../../../admin/views/home/home_screen.dart';
import '../../../common/custom_text.dart';
import '../../../common/height_spacer.dart';
import '../../../consts/colors.dart';
import 'components/auth_textfield.dart';
import 'components/auth_background.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController email=TextEditingController();
  final TextEditingController password=TextEditingController();
  final TextEditingController name=TextEditingController();
  final TextEditingController id=TextEditingController();
  TextInputFormatter nameInputFormatter = FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'));
  @override
  void dispose() {
    // TODO: implement dispose
    email.dispose();
    password.dispose();
    name.dispose();
    id.dispose();
    super.dispose();
  }
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
                    padding:  EdgeInsets.symmetric(vertical: height*0.02,horizontal: width*0.02),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        customText(text: "Create Account ",color: kLight,size:36.sp,fw: FontWeight.w700 ),
                        authTextField(imagePath: "assets/icons/user.png",hint: "Enter Your Name",controller: name,
                        keyboardType: TextInputType.text,inputformatters: [nameInputFormatter]),
                        authTextField(imagePath: "assets/icons/mail.png",hint: "Enter Your Email",controller: email),
                        authTextField(imagePath: "assets/icons/user-check.png",hint: "QAU ID (Optional)",controller: id),
                        authTextField(imagePath: "assets/icons/Vector.png",hint: "Password",controller: password,isObsecure: true),
                        Consumer<StudentAuthProvider>(builder: (context,provider,child){
                          return provider.isLoading?Container(
                            alignment: Alignment.center,
                            height: 45.92.h,
                            width: 135.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blueGrey.withOpacity(0.2)
                            ),
                            child: customText(text: "Sign Up",color: kLightBlue,fw: FontWeight.w600,size: 18.sp),
                          ):GestureDetector(
                            onTap: (){
                              provider.createUser(context: context, email: email.text, password: password.text, name: name.text, id: id.text);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 45.92.h,
                              width: 135.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: kLight
                              ),
                              child: customText(text: "Sign Up",color: kLightBlue,fw: FontWeight.w600,size: 18.sp),
                            ),
                          );
                        }),
                        heightSpacer(height: height*0.006),
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: RichText(text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Already have an account? ",
                                  style: appStyle(
                                    size:13.sp,
                                    color: kLight,
                                    fw: FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                  text: "Log In",
                                  style: appStyle(
                                    size: 13.sp,
                                    color: kLight,
                                    fw: FontWeight.bold,
                                  ),
                                ),
                              ]
                          )),
                        )

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