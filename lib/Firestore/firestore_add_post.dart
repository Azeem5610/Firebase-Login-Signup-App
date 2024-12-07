import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_signup/Widgets/button.dart';
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
      appBar: AppBar( 
        centerTitle: true,
        title: Text("Firestore Add Post"),
      ),
       body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(  
          children: [ 
            SizedBox(height:15.h),
            TextFormField(
              controller: postC, 
              maxLines: 4,
              decoration:const InputDecoration( 
                hintText: "What's in your mind",
                border: OutlineInputBorder( 
                 
                )
              ),
            ),
            SizedBox(height:20.h),
            Padding(
              padding:  EdgeInsets.all(8.0),
              child: myButton(
                title: "Add",
                isLoading: isLoading,
                 onTap:() {
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
               
              
              },),
            )
          ],
        ),
      ),
    );
  }
}