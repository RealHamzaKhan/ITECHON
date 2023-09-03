import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itechon/admin/provider/event_provider.dart';
import 'package:itechon/consts/firebase_consts.dart';
import 'package:itechon/firebase_options.dart';
import 'package:itechon/students/provider/enrollment_provder.dart';
import 'package:itechon/students/provider/student_auth_provider.dart';
import 'package:itechon/students/views/auth/login_screen.dart';
import 'package:itechon/admin/provider/admin_auth_provider.dart';
import 'package:itechon/students/views/home/student_home_screen.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
Widget checkUser(){
  User? user=auth.currentUser;
  if(user==null){
    return const LoginScreen();
  }
  else{
    return const StudentHome();
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=>AdminAuthProvider()),
      ChangeNotifierProvider(create: (context)=>EventProvider()),
      ChangeNotifierProvider(create: (context)=>StudentAuthProvider()),
      ChangeNotifierProvider(create: (context)=>EnrollmentProvider()),
    ],child: ScreenUtilInit(
      designSize: const Size(1280, 720),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ITECHON',
          home: child,
        );
      },
      child: checkUser(),
    ),);
  }
}

