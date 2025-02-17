import 'package:firebase_login_signup/View/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit( 
      designSize: const Size(360,780),
      builder: (context, child) {
        return const MaterialApp(
         debugShowCheckedModeBanner: false,
         home:SplashScreen()
    );
      },
    );
    
  }
}