import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_signup/Widgets/button.dart';
import 'package:firebase_login_signup/Widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final forgotpassC=TextEditingController();
  final auth=FirebaseAuth.instance;
  bool isloading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text("Forgot Password"),
      ),
      body: Column( 
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [ 
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField( 
             controller: forgotpassC,
            
             decoration: InputDecoration( 
              hintText: "Email",
              border: OutlineInputBorder( 
            
              )
             ),
            ),
          ),
          SizedBox(height:8.h),
          Padding(
            padding: const EdgeInsets.all(17.0),
            child: myButton(
              isLoading: isloading,
              title: "Forgot Password", onTap:() {
                setState(() {
                  isloading=true;
                });
              auth.sendPasswordResetEmail(email: forgotpassC.text).then((value){
                isloading=false;
                utils().toastmessaage('We have sent you password,please check your email');
              }).onError((error, stackTrace) {
                isloading=false;
                utils().toastmessaage(error.toString());
              },);
            },),
          )
        ],
      ),
    );
  }
}