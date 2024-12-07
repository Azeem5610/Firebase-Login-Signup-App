import 'package:firebase_login_signup/View/splash_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashscreen=SplashServices();
  @override
  void initState() {
    super.initState();
    splashscreen.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
     
      body: Center( 
        child:Text("FIREBASE\nAUTHENTICATION",style: TextStyle(fontSize: 30.sp),)
      ),
    );
  }
}