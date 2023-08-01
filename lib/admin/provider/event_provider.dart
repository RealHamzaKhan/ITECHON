import 'dart:js';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:itechon/admin/views/home/home_screen.dart';
import 'package:itechon/consts/firebase_consts.dart';
import 'package:itechon/utils/snackbar.dart';

import '../views/scoreboard/score_board_dynamic_widget.dart';

class EventProvider with ChangeNotifier{
  bool _isAdding=false;
  bool get isAdding=>_isAdding;
  void setIsAdding(bool setter){
    _isAdding=setter;
    notifyListeners();
  }
  void addEvent({
    required final BuildContext context,
    required final String eventtitle,
    required final String date,
    required final String status,
    required final String time,
    required final String venue,
    required final String description,
    required final image
  })async{
    setIsAdding(true);
    try{
      var url=await uploadImage(image);
      await firestore.collection(eventCollection).doc().set({
        "event_name":eventtitle,
        "event_date":date,
        "event_status":status,
        "event_time":time,
        "event_venue":venue,
        "event_description":description,
        "enrolled_students":[],
        "scoreBoard":[],
        "event_image":url
      });
      showCustomSnackbar(context, "Event Added Succesfully", Colors.green);
      setIsAdding(false);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
    }
    catch(e){
      showCustomSnackbar(context, e.toString(), Colors.red);
      setIsAdding(false);
    }
  }

  Future<String> uploadImage(item)async{
    var destination="Images/events/${Random.secure().nextInt(1000)}";
    Reference reference=storage.ref().child(destination);
    await reference.putData(item,SettableMetadata(contentType: 'image/jpeg'),);
    var n=await reference.getDownloadURL();
    return n;
  }

  //update event
  void updateEvent({
    required final String docId,
    required final BuildContext context,
    required final String eventtitle,
    required final String date,
    required final String status,
    required final String time,
    required final String venue,
    required final String description,
  })async{
    setIsAdding(true);
    try{
      await firestore.collection(eventCollection).doc(docId).update({
        "event_name":eventtitle,
        "event_date":date,
        "event_status":status,
        "event_time":time,
        "event_venue":venue,
        "event_description":description,
      });
      showCustomSnackbar(context, "Event Updated Succesfully", Colors.green);
      setIsAdding(false);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
    }
    catch(e){
      showCustomSnackbar(context, e.toString(), Colors.red);
      setIsAdding(false);
    }
  }

  //delete event
void deleteEvent({required BuildContext context,required final String id})async{
    try{
      setIsAdding(true);
      await firestore.collection(eventCollection).doc(id).delete();
      setIsAdding(false);
      showCustomSnackbar(context, "Event Deleted Successfully", Colors.green);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
    }
    catch(e){
      showCustomSnackbar(context, e.toString(), Colors.red);
      setIsAdding(false);
    }

}

//update Score Board
void updateScoreBoard({required BuildContext context,required List<TeamScoreWidget> dynamicWidget,required String id})async{
    try{
      setIsAdding(true);
      List<Map<String,dynamic>> hashmap=[];
      for(var i in dynamicWidget){
        if(i.team.text.isNotEmpty && i.score.text.isNotEmpty){
          hashmap.add({
            "team":i.team.text,
            "score":i.score.text,
          });
        }

      }
      await firestore.collection(eventCollection).doc(id).update({
        "scoreBoard":[]
      });
      await firestore.collection(eventCollection).doc(id).update({
        "scoreBoard":FieldValue.arrayUnion(hashmap),
      });
      setIsAdding(false);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
      showCustomSnackbar(context, "Score Board Updated Successfully", Colors.green);
    }
    catch(e){
      setIsAdding(false);
      showCustomSnackbar(context, e.toString(), Colors.red);
    }
}

//approve student
void approveStudent(String uid)async{
  // Step 1: Construct the query to filter "requests" subcollection
  var querySnapshot = await firestore
      .collectionGroup('requests')
      .where('uid', isEqualTo: uid)
      .get();

  // Step 2 & 3: Loop through the fetched documents and update
  for (var documentSnapshot in querySnapshot.docs) {
    // Step 4: Perform the update
    await documentSnapshot.reference.update({'status': 'approved'});
  }
}
  void declineStudent(String uid)async{
    // Step 1: Construct the query to filter "requests" subcollection
    var querySnapshot = await firestore
        .collectionGroup('requests')
        .where('uid', isEqualTo: uid)
        .get();

    // Step 2 & 3: Loop through the fetched documents and update
    for (var documentSnapshot in querySnapshot.docs) {
      // Step 4: Perform the update
      await documentSnapshot.reference.update({'status': 'declined'});
    }
  }

}