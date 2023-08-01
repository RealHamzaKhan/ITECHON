import 'package:itechon/consts/firebase_consts.dart';

class FirebaseServices{
  static getAllEvents(){
    return firestore.collection(eventCollection).snapshots();
}
static Future<String> checkStatus(String docID)async{
    String status='';
    await firestore.collection(eventCollection).doc(docID).collection(requestsCollection)
        .where('uid',isEqualTo:auth.currentUser!.uid)
        .get().then((value){
       if(value.docs.first['status']=='pending'){
         status='pending';
       }
       else if(value.docs.first['status']=='declined'){
         status='declined';
       }
       else{
         status='approved';
       }
    });
    return status;
}

static getEnrolledTeams(String docId){
    return firestore.collection(eventCollection).doc(docId).collection(requestsCollection).where('status',isEqualTo: 'approved').snapshots();
}
static getAllRequests(){
    return firestore.collectionGroup(requestsCollection).where('status',isEqualTo: 'pending').snapshots();
}

}