import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_signup/View/firestore_post_screen.dart';
import 'package:firebase_login_signup/View/login_page.dart';
import 'package:flutter/material.dart';

class SplashServices{
  
  void isLogin(BuildContext context){
    final auth=FirebaseAuth.instance;
    final user= auth.currentUser;
  if(user!=null){
    Timer(const Duration(seconds: 4), ()=>Navigator.push(context, MaterialPageRoute(builder:(context) =>const FirestorePostScreen(),)));
  }else{
     Timer(const Duration(seconds: 4), ()=>Navigator.push(context, MaterialPageRoute(builder:(context) =>const LoginPage(),)));
  }
    
  }
  }
