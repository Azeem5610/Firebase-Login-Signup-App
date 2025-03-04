import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_signup/View/firestore_post_screen.dart';
import 'package:firebase_login_signup/View/forgot_password.dart';
import 'package:firebase_login_signup/View/login_with_phone_no.dart';
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
  var emailC = TextEditingController();
  var passwordC = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void login() {
    if (formkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      
      _auth.signInWithEmailAndPassword(
        email: emailC.text,
        password: passwordC.text
      ).then((value) {
        setState(() {
          isLoading = false;
        });
        utils().toastmessaage(value.user!.email.toString());
        Navigator.push(context, MaterialPageRoute(builder: (context) => const FirestorePostScreen()));
      }).onError((error, stackTrace) {
        setState(() {
          isLoading = false;
        });
        utils().toastmessaage(error.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration:const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2C3E50),  // Dark blue-gray
              Color(0xFF3498DB),  // Light blue
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Form(
                key: formkey,
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 60.h),
                        Text(
                          "Welcome Back",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Sign in to continue",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 40.h),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.all(24.w),
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter the E-mail";
                                  }
                                  return null;
                                },
                                controller: emailC,
                                style:const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle:const TextStyle(color: Colors.white60),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:const BorderSide(color: Colors.white30),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:const BorderSide(color: Colors.white30),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:const BorderSide(color: Colors.white),
                                  ),
                                  prefixIcon:const Icon(Icons.email, color: Colors.white70),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter the password";
                                  }
                                  return null;
                                },
                                controller: passwordC,
                                obscureText: true,
                                style:const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle:const TextStyle(color: Colors.white60),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:const BorderSide(color: Colors.white30),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:const BorderSide(color: Colors.white30),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:const BorderSide(color: Colors.white),
                                  ),
                                  prefixIcon:const Icon(Icons.lock, color: Colors.white70),
                                ),
                              ),
                              SizedBox(height: 24.h),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: isLoading ? null : login,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    padding:const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: isLoading
                                    ? const CircularProgressIndicator(color: Color(0xFF2C3E50))
                                    : Text(
                                        "Login",
                                        style: TextStyle(
                                          color: const Color(0xFF2C3E50),
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>const ForgotPassword()));
                            },
                            child: const Text(
                              "Forgot password?",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          const  Text(
                              "Don't have an account? ",
                              style: TextStyle(color: Colors.white70),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>const SignUpPage()));
                              },
                              child:const Text(
                                "Sign up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Center(
                          child: TextButton.icon(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>const PhoneNumberLogin()));
                            },
                            icon:const Icon(Icons.phone, color: Colors.white70),
                            label:const Text(
                              "Login with Phone number",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        ),
                       const Spacer(),  // This will push the content up and fill remaining space
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}