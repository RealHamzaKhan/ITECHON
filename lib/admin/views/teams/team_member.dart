import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itechon/common/custom_text.dart';
import 'package:itechon/consts/firebase_consts.dart';

class TeamMembers extends StatelessWidget {
  const TeamMembers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
          child: StreamBuilder(stream: firestore.collection(volunteers).snapshots(), builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
            if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
              return Center(
                child: customText(text: "No records found",fw: FontWeight.bold,color: Colors.black.withOpacity(0.3),size: 25.sp),
              );
            }
            else if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }
            else{
              List<TableRow> tableRows = [];

              // Add table headers
              tableRows.add(
                TableRow(
                  children: [
                    customText(text: "Name",fw: FontWeight.bold,size: 18.sp),
                    customText(text: "Email",fw: FontWeight.bold,size: 18.sp),
                    customText(text: "Team Name",fw: FontWeight.bold,size: 18.sp),
                    customText(text: "Semester",fw: FontWeight.bold,size: 18.sp),
                    customText(text: "Whatsapp",fw: FontWeight.bold,size: 18.sp),
                    customText(text: "Delete Member",fw: FontWeight.bold,size: 18.sp),
                  ],
                ),
              );
              for (var doc in snapshot.data!.docs) {
                String name = doc['name'];
                String email = doc['email'];
                String teamName = doc['team_name'];
                String semester = doc['semester'];
                String whatsapp = doc['whatsapp'];

                tableRows.add(
                  TableRow(
                    children: [
                      customText(text: name),
                      customText(text: email),
                      customText(text:teamName),
                      customText(text: semester),
                      customText(text: "+92 $whatsapp"),
                      IconButton(onPressed: (){
                        firestore.collection(volunteers).doc(doc.id).delete();
                      }, icon: const Icon(Icons.delete,color: Colors.red,))
                    ],
                  ),
                );
              }
              return Table(
                border: TableBorder.all(color: Colors.black.withOpacity(0.2)),
                children: tableRows,
              );
            }
          })
        )
      ),
    );
  }
}
