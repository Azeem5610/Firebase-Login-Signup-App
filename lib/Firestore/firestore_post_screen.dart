import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_login_signup/Firestore/firestore_add_post.dart';
import 'package:firebase_login_signup/View/login_page.dart';
import 'package:firebase_login_signup/Widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirestorePostScreen extends StatefulWidget {
  const FirestorePostScreen({super.key});

  @override
  State<FirestorePostScreen> createState() => _FirestorePostScreenState();
}

class _FirestorePostScreenState extends State<FirestorePostScreen> {
 
final auth=FirebaseAuth.instance;
final firesotre=FirebaseFirestore.instance.collection('users').snapshots();
CollectionReference ref=FirebaseFirestore.instance.collection('users');
final editC=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
          floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder:(context) => FirestoreAddPost(),));
      },child: Icon(Icons.add),
      ),
      appBar: AppBar( 
        centerTitle:true,
        title:Text("Firestore Post Screen"),
        automaticallyImplyLeading: false,
        actions: [ 
          IconButton(onPressed:() {
            auth.signOut().then((value){
              utils().toastmessaage("Sign out successfully");
              Navigator.push(context, MaterialPageRoute(builder:(context) => LoginPage(),));
            }).onError((error, stackTrace) {
              utils().toastmessaage(error.toString());
            },);
          }, icon: Icon(Icons.logout))
        ],
      ),
      body:Column(  
        children: [ 
          SizedBox(height:12.h),
          StreamBuilder<QuerySnapshot>(
            stream: firesotre,
             builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return CircularProgressIndicator();
              }
              if(snapshot.hasError){
                return Text("Some Error");
              }
               return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder:(context, index) {

              return ListTile(
                onTap: () {
                  //-------Delete Method------//

                  ref.doc(snapshot.data!.docs[index]['id']).delete();

                  //------Update Method-------//

                //   ref.doc(snapshot.data!.docs[index]['id']).update({
                //    'title':'Hii '
                //   }).then((value){
                //  utils().toastmessaage('Post Updated');
                //   }).onError((error, stackTrace) {
                //     utils().toastmessaage(error.toString());
                //   },);
                },
                title: Text(snapshot.data!.docs[index]['title']),
                subtitle: Text(snapshot.data!.docs[index]['id']),
              );
            },)
            );
             },
             ),
          
        ],
      )
    );
    
  }
  Future<void>showMyDialogue(String title,String id){ 
    editC.text=title;
    return showDialog(
      context: context, builder:(context) {
        return AlertDialog( 
          title: Text("Update"),
          content: Container( 
            child: TextField( 
              controller: editC,
            ),
          ),
          actions: [ 
            TextButton(onPressed:() {
              Navigator.pop(context);
            }, child:Text("Cancel")),

            TextButton(onPressed:() {
               

              Navigator.pop(context);
              
            }, child:Text("Update"))
          ],
        );
      },);

  }
  
}
