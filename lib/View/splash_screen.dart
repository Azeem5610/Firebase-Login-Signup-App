import 'package:firebase_login_signup/View/splash_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  SplashServices splashscreen = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashscreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: 3.seconds,
        curve: Curves.easeInOut,
        width: double.infinity,
        height: double.infinity,
        decoration:const  BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2C3E50), 
              Color(0xFF3498DB), 
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             const Icon(
        Icons.lock,
              color: Colors.white,
              size: 100,
     )
         .animate()
         .fade(duration: 1.seconds)
         .then()
         .scale(duration: 0.5.seconds, curve: Curves.easeInOut)
         .then()
         .moveY(begin: -20, end: 0, duration: 800.ms, curve: Curves.bounceOut),
              SizedBox(height: 24.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    Text(
                      "Powered by Flutter,\nSecured by Firebase",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                        .animate()
                        .slideX(begin: -1, end: 0, duration: 1.seconds)
                        .fadeIn()
                        .shimmer(delay: 1.seconds, duration: 2.seconds),
                    
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              CircularProgressIndicator(
                valueColor:const AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 3.w,
              )
                  .animate()
                  .scale(delay: 500.ms, duration: 800.ms)
                  .then(delay: 500.ms)
                  .shimmer(duration: 2.seconds),
            ],
          ),
        ),
      ),
    );
  }
}
