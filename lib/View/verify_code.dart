import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_signup/View/firestore_post_screen.dart';
import 'package:firebase_login_signup/Widgets/button.dart';
import 'package:firebase_login_signup/Widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifyCode extends StatefulWidget {
  final String verificationId;
  const VerifyCode({super.key,required this.verificationId});
  
  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  var verifyCodeC=TextEditingController();
  bool isLoading=false;
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar( 
        title:const Text("Verify"),
        centerTitle: true,
      ),
      body: Column(  
        children: [ 
          SizedBox(height:20.h),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField( 
             controller: verifyCodeC,
              decoration:const InputDecoration( 
                hintText: "6 Digit Code",
                border: OutlineInputBorder( 
                  
                )
              ),
            ),
          ),
          SizedBox(height:17.h),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: myButton(
              isLoading: isLoading,
              title: "Login",
               onTap: () async{
                setState(() {
                  isLoading=true;
                });
                 final credentials=PhoneAuthProvider.credential(verificationId:widget.verificationId , smsCode:verifyCodeC.text );
                  
                  try {
                    setState(() {
                  isLoading=false;
                });
                    await auth.signInWithCredential(credentials);
                    Navigator.push(context, MaterialPageRoute(builder:(context) =>const FirestorePostScreen(),));
                  }catch(e){
                    setState(() {
                  isLoading=false;
                });
                   utils().toastmessaage(e.toString());
                  }
               },
                 
                
            ),
          )
        ],
      ),
    );
  }
}