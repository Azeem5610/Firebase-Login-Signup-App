import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_signup/Widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirestoreAddPost extends StatefulWidget {
  const FirestoreAddPost({super.key});

  @override
  State<FirestoreAddPost> createState() => _FirestoreAddPostState();
}

class _FirestoreAddPostState extends State<FirestoreAddPost> {
 
  final firesotre=FirebaseFirestore.instance.collection('users');
  bool isLoading=false;
  var postC=TextEditingController();
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
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon:const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        "Add New Note",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: postC,
                          maxLines: 6,
                          style:const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "What's on your mind?",
                            hintStyle:const TextStyle(color: Colors.white60),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
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
                   isLoading=true;
                });

                String id=DateTime.now().millisecondsSinceEpoch.toString();
                

                firesotre.doc(id).set({
                  'title':postC.text,
                  'id':id

                }).then((value){
                  setState(() {
                   isLoading=false;
                });
                  utils().toastmessaage("Data added");

                }).onError((error, stackTrace) {
                  setState(() {
                   isLoading=false;
                });
                  utils().toastmessaage(error.toString());
                },);
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding:const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: isLoading
                                ?const CircularProgressIndicator(
                                    color: Color(0xFF2C3E50))
                                : Text(
                                    "Add Note",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}