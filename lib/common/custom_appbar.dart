import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itechon/admin/views/auth/admin_login_screeen.dart';
import 'package:itechon/admin/views/events/add_event.dart';
import 'package:itechon/admin/views/gallery/gallery_screen.dart';
import 'package:itechon/admin/views/home/home_screen.dart';
import 'package:itechon/admin/views/requests/requests_screen.dart';
import 'package:itechon/admin/views/teams/add_team_screen.dart';
import 'package:itechon/students/provider/student_auth_provider.dart';
import 'package:itechon/students/views/gallery/galleryscreen.dart';
import 'package:itechon/students/views/home/student_home_screen.dart';
import 'package:itechon/students/views/home/student_main_home.dart';
import '../consts/colors.dart';
import '../students/views/event/managing_team_screen.dart';
import 'width_spacer.dart';

import 'appbar_actions.dart';

AppBar customAppBar({required final BuildContext context,final bool isAdmin=true}){
  return isAdmin?AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    backgroundColor: kLight,
    title: GestureDetector(

        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
        },
        child: Image.asset('assets/images/app_logo.png',width: 342.w,height: 60.h,)),
    actions:[
       AppBarActions( iconPath:'assets/icons/git-pull-request.png', text: "Requests",onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const RequestsScreen()));
      },),
      widthSpacer(width: 25.w),
      AppBarActions( iconPath:'assets/icons/gallery.png', text: "Add To Gallery",onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddToGallery()));
      },),
      widthSpacer(width: 25.w),
       AppBarActions( iconPath:'assets/icons/plus-circle.png', text: "Add Event",onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddEvent()));
      },),
      widthSpacer(width: 25.w),
      AppBarActions( iconPath:'assets/icons/group.png', text: "Add Team",onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddTeamScreen()));
      },),
      widthSpacer(width: 25.w),
      AppBarActions( iconPath:'assets/icons/user.png', text: "Admin",onTap: (){
        showMenu(context: context, position: RelativeRect.fromLTRB(double.infinity, 50.h, 10.w, double.infinity), items: [
          PopupMenuItem(child: AppBarActions(iconPath: "assets/icons/logout.png", text: "Logout",onTap: (){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const AdminLoginScreen()), (route) => false);
          },)),
        ]);
      },),
      widthSpacer(width: 25.w),
    ],
  ): AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    backgroundColor: kLight,
    title: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentMainHome()));
        },
        child: Image.asset('assets/images/app_logo.png',width: 342.w,height: 60.h,)),
    actions: [
      AppBarActions( iconPath:'assets/icons/gallery.png', text: "Gallery",onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const GalleryScreen()));
      },),
      widthSpacer(width: 20.w),
      AppBarActions(iconPath: "assets/icons/calendar.png", text: "Events",onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentHome()));
      },),
      widthSpacer(width: 20.w),
      AppBarActions(iconPath: "assets/icons/group.png", text: "Managing Teams",onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const ManagingTeamScreen()));
      },),
      widthSpacer(width: 20.w),
      AppBarActions(iconPath: "assets/icons/logout.png", text: "Logout",onTap: (){
        StudentAuthProvider provider=StudentAuthProvider();
        provider.logout(context);
      },),
      widthSpacer(width: 20.w),

    ],
  );
}