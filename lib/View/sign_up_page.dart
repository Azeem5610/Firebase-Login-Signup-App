import 'package:firebase_login_signup/Widgets/button.dart';
import 'package:firebase_login_signup/Widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var emailC=TextEditingController();
  var passwordC=TextEditingController();
  final formkey=GlobalKey<FormState>();
   bool isLoading=false;
   FirebaseAuth _auth = FirebaseAuth.instance;
   void signup(){
       if(formkey.currentState!.validate()){
        setState(() {
          isLoading=true;
        });
            _auth.createUserWithEmailAndPassword(email: emailC.text, password: passwordC.text).then((value){
              setState(() {
                isLoading=false;
              });
          
             }).onError((error, stackTrace) {
              setState(() {
                isLoading=false;
              });
              utils().toastmessaage(error.toString());
            },);
 }
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: Text("Sign up"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Form(
        key: formkey,
        
          child: Column( 
            children: [ 
                       Padding(
                 padding:  EdgeInsets.only(top:130.h),
                 child: Text("Sign up",style: TextStyle(color: Colors.black,fontSize: 26.sp,fontWeight: FontWeight.w600),),
               ),
               SizedBox(height:18.h),
                  Padding(
                    padding:  EdgeInsets.only(left:14.w,right:14.w),
                    child: TextFormField( 
                      validator: (value) {
                         if(value!.isEmpty){
                          return "Enter the E-mail";
                         }else{
                          return null;
                         }
                       },
                      controller: emailC,
                    decoration: InputDecoration( 
                      
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintText:"Enter your Email",
                      contentPadding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 10.w),
                      border: OutlineInputBorder( 
                      borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: Icon(Icons.email)
                    ),
                  )
                  ),
                  SizedBox(height:18.h),
                  Padding(
                    padding:  EdgeInsets.only(left:14.w,right:14.w),
                    child: TextFormField( 
                       validator: (value) {
                         if(value!.isEmpty){
                          return "Enter the password";
                         }else{
                          return null;
                         }
                       },
                     controller: passwordC,
                      decoration: InputDecoration( 
                        fillColor: Colors.grey[200],
                        filled: true,
                        hintText:"Enter your Password",
                        contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                        border: OutlineInputBorder( 
                        borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: Icon(Icons.password)
                        
                      ),
                    ),
                  ),               
                  SizedBox(height:25.h),      
                  Padding(
                     padding:  EdgeInsets.only(left:12.w,right:12.w),
                    child: myButton(
                      title: "Sign up",
                      isLoading: isLoading,
                      onTap:() {
                       signup();
                    },)
                  ),      
                   SizedBox( 
                    height:24.h
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,  
                    
                    children: [ 
                     Text("Already have an account? "),
                     InkWell(onTap: () {
                       Navigator.pop(context);
                     },  child: Text("Login",style: TextStyle(color: Colors.blue),))
                    ],
                  )
            ],
          )
          ),
      )
    );
  }
}