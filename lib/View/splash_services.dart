import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_signup/Firestore/firestore_post_screen.dart';
import 'package:firebase_login_signup/View/login_page.dart';
import 'package:flutter/material.dart';

class SplashServices{
  
  void isLogin(BuildContext context){
    final auth=FirebaseAuth.instance;
    final user= auth.currentUser;
  if(user!=null){
    Timer(Duration(seconds: 3), ()=>Navigator.push(context, MaterialPageRoute(builder:(context) => FirestorePostScreen(),)));
  }else{
     Timer(Duration(seconds: 3), ()=>Navigator.push(context, MaterialPageRoute(builder:(context) => LoginPage(),)));
  }
    
  }
  }
