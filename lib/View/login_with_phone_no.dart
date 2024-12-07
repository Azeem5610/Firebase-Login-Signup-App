import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_signup/Widgets/button.dart';
import 'package:firebase_login_signup/Widgets/utils.dart';
import 'package:firebase_login_signup/View/verify_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneNumberLogin extends StatefulWidget {
  const PhoneNumberLogin({super.key});

  @override
  State<PhoneNumberLogin> createState() => _PhoneNumberLoginState();
}

class _PhoneNumberLoginState extends State<PhoneNumberLogin> {
  var  PhoneNoC=TextEditingController();
  bool isLoading=false;
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar( 
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Column(  
        children: [ 
          SizedBox(height:20.h),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField( 
             controller: PhoneNoC,
              decoration: InputDecoration( 
                hintText: "Phone no.",
                border: OutlineInputBorder( 
                  
                )
              ),
            ),
          ),
          SizedBox(height:17.h),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: myButton(
              title: "Login",
              isLoading: isLoading,
               onTap: () {
                setState(() {
                  isLoading=true;
                });



                 auth.verifyPhoneNumber(
                  
                  phoneNumber: PhoneNoC.text,
                  verificationCompleted:(_) {
                    setState(() {
                  isLoading=false;
                });
                  },
                   verificationFailed:(e) {
                     setState(() {
                  isLoading=false;
                });
                    utils().toastmessaage(e.toString());
                     
                   },
                    codeSent: (verificationId, forceResendingToken) {
                       setState(() {
                  isLoading=false;
                });
                       Navigator.push(context, MaterialPageRoute(builder:(context) => VerifyCode(verificationId: verificationId),));
                    },
                     codeAutoRetrievalTimeout: (e) {
                       setState(() {
                  isLoading=false;
                });
                      utils().toastmessaage(e);
                       
                     },
                  );
               },
               
            ),
          )
        ],
      ),
    );
  }
}