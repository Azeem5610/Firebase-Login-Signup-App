import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_login_signup/Widgets/button.dart';
import 'package:firebase_login_signup/Widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class addPost extends StatefulWidget {
  const addPost({super.key});

  @override
  State<addPost> createState() => _addPostState();
}

class _addPostState extends State<addPost> {
  FirebaseAuth auth=FirebaseAuth.instance;
  bool isLoading=false;
  final databaseRef=FirebaseDatabase.instance.ref('Student');
  var postC=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        centerTitle: true,
        title: Text("Add Post"),
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
              padding: const EdgeInsets.all(8.0),
              child: myButton(title: "Add", onTap:() {
                String id=DateTime.now().millisecondsSinceEpoch.toString();
                setState(() {
                   isLoading=true;
                });
               
                databaseRef.child(id).set({
                  'id':id,
                  'perspective':postC.text
                }).then((value){
                  setState(() {
                    isLoading=false;
                  });
                  
                  utils().toastmessaage('Post Added');
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