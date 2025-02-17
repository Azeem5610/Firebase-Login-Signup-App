import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_signup/Widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final forgotpassC = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool isloading = false;

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
              Color(0xFF2C3E50),
              Color(0xFF3498DB),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      IconButton(
                        icon:const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      SizedBox(height: 40.h),
                      Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Enter your email to reset your password",
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
                              controller: forgotpassC,
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
                            SizedBox(height: 24.h),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: isloading
                                    ? null
                                    : () {
                                        setState(() {
                                          isloading = true;
                                        });
                                        auth
                                            .sendPasswordResetEmail(
                                                email: forgotpassC.text)
                                            .then((value) {
                                          setState(() {
                                            isloading = false;
                                          });
                                          utils().toastmessaage(
                                              'We have sent you password reset email, please check your email');
                                        }).onError((error, stackTrace) {
                                          setState(() {
                                            isloading = false;
                                          });
                                          utils()
                                              .toastmessaage(error.toString());
                                        });
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: isloading
                                    ?const CircularProgressIndicator(
                                        color: Color(0xFF2C3E50))
                                    : Text(
                                        "Reset Password",
                                        style: TextStyle(
                                          color:const Color(0xFF2C3E50),
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    const  Spacer(),
                    ],
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