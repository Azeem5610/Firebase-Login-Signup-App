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
  var PhoneNoC = TextEditingController();
  bool isLoading = false;
  final auth = FirebaseAuth.instance;

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
                        "Phone Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Enter your phone number to continue",
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
                              controller: PhoneNoC,
                              style:const TextStyle(color: Colors.white),
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: "+1 234 567 8900",
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
                                prefixIcon:const Icon(Icons.phone, color: Colors.white70),
                              ),
                            ),
                            SizedBox(height: 24.h),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: isLoading
                                    ? null
                                    : () {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        auth.verifyPhoneNumber(
                                          phoneNumber: PhoneNoC.text,
                                          verificationCompleted: (_) {
                                            setState(() {
                                              isLoading = false;
                                            });
                                          },
                                          verificationFailed: (e) {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            utils().toastmessaage(e.toString());
                                          },
                                          codeSent: (verificationId,
                                              forceResendingToken) {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => VerifyCode(
                                                      verificationId:
                                                          verificationId),
                                                ));
                                          },
                                          codeAutoRetrievalTimeout: (e) {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            utils().toastmessaage(e);
                                          },
                                        );
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding:const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: isLoading
                                    ? const CircularProgressIndicator(
                                        color: Color(0xFF2C3E50))
                                    : Text(
                                        "Send Code",
                                        style: TextStyle(
                                          color: Color(0xFF2C3E50),
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                     const Spacer(),
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