import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itechon/consts/firebase_consts.dart';
import 'package:itechon/services/firebase_services.dart';
import 'package:itechon/students/views/home/student_home_screen.dart';
import 'package:itechon/utils/snackbar.dart';

import '../../common/custom_button.dart';
import '../../consts/colors.dart';
import '../views/event/enrollment_screen.dart';

class EnrollmentProvider with ChangeNotifier{
  bool _isLoading=false;
  bool get isLoading=>_isLoading;
  void setLoading(bool status){
    _isLoading=status;
    notifyListeners();
  }

  //Enrolled in event

void enrollment({
  required BuildContext context,
  required String docId,
  final String? uid,
  final String? name,
  final String? email,
  final String? whatsapp,
  final String? teamName,
  final String? teamMembers,
  required final image
})async{
    try{
      print("try");
      setLoading(true);
      String url=await uploadImage(image);
      print("upload");
      await firestore.collection(eventCollection).doc(docId).collection(requestsCollection).doc().set({
            "uid":uid,
            "name":name,
            "email":email,
            "whatsapp":whatsapp,
            "team_name":teamName,
            "team_members":teamMembers,
            "status":"pending",
            "image_url":url
          }
      );
      setLoading(false);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const StudentHome()), (route) => false);
      showCustomSnackbar(context, "Request Sent Successfully", Colors.green);
    }
    catch(e){
      setLoading(false);
      showCustomSnackbar(context, e.toString(), Colors.red);
    }
}

  Future<String> uploadImage(item)async{
    var destination="Images/requests/${Random.secure().nextInt(1000)}";
    Reference reference=storage.ref().child(destination);
    await reference.putData(item,SettableMetadata(contentType: 'image/jpeg'),);
    var n=await reference.getDownloadURL();
    return n;
  }
  // Future<Widget> checkStatus(BuildContext context,dynamic data)async{
  //   if(await FirebaseServices.checkStatus(data.id)=='pending'){
  //     return Align(
  //         alignment: Alignment.center,
  //         child: customButton(height: 66.h,width: 246.w,text: "Pending",color: Colors.grey.withOpacity(0.3),onTap: (){
  //           // Navigator.push(context, MaterialPageRoute(builder: (context)=> EnrollmentScreen(data: data,)));
  //         }));
  //   }
  //   else if(await FirebaseServices.checkStatus(data.id)=='declined'){
  //     return Align(
  //         alignment: Alignment.center,
  //         child: customButton(height: 66.h,width: 246.w,text: "Declined",color: Colors.red,onTap: (){
  //           // Navigator.push(context, MaterialPageRoute(builder: (context)=> EnrollmentScreen(data: data,)));
  //         }));
  //   }
  //   else if (await FirebaseServices.checkStatus(data.id)=='approved'){
  //     return Container();
  //
  //   }
  //   else{
  //     Align(
  //         alignment: Alignment.center,
  //         child: customButton(height: 66.h,width: 246.w,text: "Enroll Now",color: kLightBlue,onTap: (){
  //           Navigator.push(context, MaterialPageRoute(builder: (context)=> EnrollmentScreen(data: data,)));
  //         }));
  //   }
  // }
}