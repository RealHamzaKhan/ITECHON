import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../common/custom_appbar.dart';
import '../../../common/custom_button.dart';
import '../../../common/height_spacer.dart';
import '../../../common/textfield_with_title.dart';
import '../../../consts/colors.dart';
import '../../provider/event_provider.dart';

class UpdateEventScreen extends StatefulWidget {
  final dynamic data;
  const UpdateEventScreen({Key? key,required this.data}) : super(key: key);

  @override
  State<UpdateEventScreen> createState() => _UpdateEventScreenState();
}

class _UpdateEventScreenState extends State<UpdateEventScreen> {
  TextEditingController title=TextEditingController();
  TextEditingController date=TextEditingController();
  TextEditingController status=TextEditingController();
  TextEditingController time=TextEditingController();
  TextEditingController venue=TextEditingController();
  TextEditingController description=TextEditingController();
  @override
  void initState() {
    title.text=widget.data["event_name"];
    date.text=widget.data["event_date"];
    status.text=widget.data["event_status"];
    time.text=widget.data["event_time"];
    venue.text=widget.data["event_venue"];
    description.text=widget.data["event_description"];
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    title.dispose();
    date.dispose();
    status.dispose();
    time.dispose();
    venue.dispose();
    description.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.1),
        child: customAppBar(context: context),
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [kLight, kLightBlue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
                padding:
                EdgeInsets.symmetric(vertical: 10.h, horizontal: 177.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heightSpacer(height: 35.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        textFormFieldWithTitle(minlines: 1,hint: "Enter Title",title: "Title",controller: title),
                        textFormFieldWithTitle(minlines: 1,hint: "Event Date",title: "Date",controller: date),
                      ],
                    ),
                    heightSpacer(height: 40.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        textFormFieldWithTitle(minlines: 1,hint: "Upcoming",title: "Status",controller: status),
                        textFormFieldWithTitle(minlines: 1,hint: "Event Time",title: "Time",controller: time),
                      ],
                    ),
                    heightSpacer(height: 40.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        textFormFieldWithTitle(minlines: 1,hint: "Enter Event Venue",title: "Venue",controller: venue),
                        textFormFieldWithTitle(minlines: 4,hint: "Enter Description of Event Here...",title: "Description",controller: description),
                      ],
                    ),
                    heightSpacer(height: 50.h),
                    Consumer<EventProvider>(builder: (context,provider,child){
                      return Align(
                          alignment: Alignment.center,
                          child: provider.isAdding?customButton(height: 66.h,width: 220.w,text: "Add Event",color: kLightBlue.withOpacity(0.2),

                          ):customButton(height: 66.h,width: 220.w,text: "Add Event",color: kLightBlue,
                              onTap: (){
                                provider.updateEvent(
                                docId: widget.data.id,
                                    context: context,
                                    eventtitle: title.text,
                                    date: date.text,
                                    status: status.text,
                                    time: time.text,
                                    venue: venue.text,
                                    description: description.text,
                                );}
                          ));
                    }),
                    heightSpacer(height: 50.h),
                  ],
                )),
          )),
    );
  }
}
