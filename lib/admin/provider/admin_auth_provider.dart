
import 'package:flutter/material.dart';
import 'package:itechon/admin/views/home/home_screen.dart';
import 'package:itechon/consts/firebase_consts.dart';
import 'package:itechon/utils/snackbar.dart';

class AdminAuthProvider with ChangeNotifier{
  bool _isLoading=false;
  bool get isLoading=>_isLoading;
  void setLoading(bool status){
    _isLoading=status;
    notifyListeners();
  }
  loginAdmin(BuildContext context,String email,String password)async{
    setLoading(true);
    try{
      await firestore.collection(adminCredCollection).get().then((value){
        if(email==value.docs[0]['email'] && password==value.docs[0]['password']){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
          setLoading(false);
        }
        else{
          setLoading(false);
          showCustomSnackbar(context, "Invalid Credentials", Colors.red);
        }
      });

    }
    catch(e){
      setLoading(false);
      showCustomSnackbar(context, "Connection Error", Colors.red);
    }
  }
}