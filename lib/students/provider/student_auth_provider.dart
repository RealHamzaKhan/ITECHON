import 'package:flutter/material.dart';
import 'package:itechon/consts/firebase_consts.dart';
import 'package:itechon/students/views/auth/login_screen.dart';
import 'package:itechon/students/views/auth/verify_email.dart';
import 'package:itechon/students/views/home/student_main_home.dart';
import 'package:itechon/utils/snackbar.dart';

import '../views/home/student_home_screen.dart';

class StudentAuthProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading(bool status) {
    _isLoading = status;
    notifyListeners();
  }


  void createUser(
      {required BuildContext context,
      required String email,
      required String password,
      required String name,
      required String id}) async {
    try {
      setLoading(true);
      if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
        await auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          firestore.collection(studentsCollection).doc().set({
            "email": email,
            "name": name,
            "id": id,
            "uid": value.user!.uid,
          });
        });
        await auth.signInWithEmailAndPassword(email: email, password: password);
        await auth.currentUser!.reload();
        auth.currentUser!.sendEmailVerification();
        Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyScreen()));
        setLoading(false);
      } else {
        setLoading(false);
        showCustomSnackbar(
            context, "Kindly Fill All required Fields", Colors.red);
      }
    } catch (e) {
      setLoading(false);
      showCustomSnackbar(context, e.toString(), Colors.red);
    }
  }

  //login User

  void login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try{
      setLoading(true);
      await auth.signInWithEmailAndPassword(email: email, password: password).then((value)async {
        if(auth.currentUser!.emailVerified){

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const StudentMainHome()),
                  (route) => false);
        }
        else{
          await auth.currentUser!.reload();
          auth.currentUser!.sendEmailVerification();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const VerifyScreen()));
        }
      });
      setLoading(false);
    }
    catch(e){
      setLoading(false);
      showCustomSnackbar(context, e.toString(), Colors.red);
    }

  }
  void logout(BuildContext context)async{
    await auth.signOut().then((value){
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false);
    });
  }
  void resetPassword({required BuildContext context,required String email})async{
    try{
      if(email.isNotEmpty){
        await auth.sendPasswordResetEmail(email: email);
        showCustomSnackbar(context, "Reset Password has been sent to your email", Colors.green);
      }
      else{
        showCustomSnackbar(context, "Kindly provide an email to proceed", Colors.red);
      }
    }
    catch(e){
      showCustomSnackbar(context, e.toString(), Colors.red);
    }

  }
}
