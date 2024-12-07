import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_signup/Widgets/button.dart';
import 'package:firebase_login_signup/View/forgot_password.dart';
import 'package:firebase_login_signup/View/login_with_phone_no.dart';
import 'package:firebase_login_signup/View/post_screen.dart';
import 'package:firebase_login_signup/View/sign_up_page.dart';
import 'package:firebase_login_signup/Widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailC=TextEditingController();
  var passwordC=TextEditingController();
  final formkey=GlobalKey<FormState>();
  bool isLoading=false;
  FirebaseAuth _auth=FirebaseAuth.instance;

  void login(){
    if(formkey.currentState!.validate()){
      setState(() {
        isLoading=true;
      });
      
    }
    _auth.signInWithEmailAndPassword(email: emailC.text, password: passwordC.text).then((value){
    setState(() {
      isLoading=false;
    });
     utils().toastmessaage(value.user!.email.toString());
     Navigator.push(context, MaterialPageRoute(builder:(context) => PostScreen(),));
    }
    ).onError((error, stackTrace) {
         setState(() {
           isLoading=false;
         });
      utils().toastmessaage(error.toString());
   
    },);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: Text("Login"),
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
                 child: Text("Login",style: TextStyle(color: Colors.black,fontSize: 26.sp,fontWeight: FontWeight.w600),),
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
                      isLoading: isLoading,
                      title: "Login",
                     onTap:() {
                        login();
                    },)
                  ),
                  SizedBox( 
                    height:6.h
                  ),
                  Align(
                     alignment:Alignment.bottomRight,
                     child: TextButton(onPressed:() {
                       Navigator.push(context, MaterialPageRoute(builder:(context) => ForgotPassword(),));
                     }, child:Text("Forgot passsword?")),
                  ),
                  SizedBox( 
                    height:24.h
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,  
                    
                    children: [ 
                     Text("Don't have an account? "),
                     InkWell(onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder:(context) => SignUpPage(),));
                     },  child: Text("Sign up",style: TextStyle(color: Colors.blue),))
                    ],
                  ),
                  SizedBox(height:13.h),
                  ElevatedButton(
                    onPressed:() {
                      Navigator.push(context, MaterialPageRoute(builder:(context) => PhoneNumberLogin(),));
                    }, child:Text("Login with Phone number"))
            ],
          )
          ),
      )
    );
  }
}
//minSdk = flutter.minSdkVersion