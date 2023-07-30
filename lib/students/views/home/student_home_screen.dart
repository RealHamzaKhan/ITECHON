import 'package:flutter/material.dart';
import 'package:itechon/consts/colors.dart';
import 'package:itechon/students/views/event/student_event_details.dart';
import '../../../admin/views/events/event_details.dart';
import '../../../common/custom_appbar.dart';
import '../../../common/event_tile.dart';


class StudentHome extends StatelessWidget {
  const StudentHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.sizeOf(context).height;
    double width=MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height*0.1),
        child: customAppBar(context: context,isAdmin:false),
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              kLight,
              kLightBlue
            ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: height*0.07),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceEvenly,
                spacing: width*0.06,
                runSpacing: height*0.1,
                children: List.generate(10, (index){
                  return EventTile(height: height, width: width,onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const StudentEventDetails()));
                  },);
                }),
              ),
            ),
          )
      ),
    );
  }
}
