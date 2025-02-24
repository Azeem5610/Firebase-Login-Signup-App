import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_signup/View/firestore_post_screen.dart';
import 'package:firebase_login_signup/Widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifyCode extends StatefulWidget {
  final String verificationId;
  const VerifyCode({super.key, required this.verificationId});
  
  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  var verifyCodeC = TextEditingController();
  bool isLoading = false;
  final auth = FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
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
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      SizedBox(height: 40.h),
                      Text(
                        "Verify Your Phone",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Enter the 6-digit code sent to your phone",
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
                              controller: verifyCodeC,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(color: Colors.white, letterSpacing: 2),
                              decoration: InputDecoration(
                                hintText: "Enter verification code",
                                hintStyle: const TextStyle(color: Colors.white60),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Colors.white30),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Colors.white30),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Colors.white),
                                ),
                                prefixIcon: const Icon(Icons.security, color: Colors.white70),
                              ),
                            ),
                            SizedBox(height: 24.h),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: isLoading ? null : () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  final credentials = PhoneAuthProvider.credential(
                                    verificationId: widget.verificationId,
                                    smsCode: verifyCodeC.text
                                  );
                                    
                                  try {
                                    await auth.signInWithCredential(credentials);
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => const FirestorePostScreen(),
                                    ));
                                  } catch(e) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    utils().toastmessaage(e.toString());
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: isLoading
                                  ? const CircularProgressIndicator(color: Color(0xFF2C3E50))
                                  : Text(
                                      "Verify",
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