import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_signup/View/firestore_add_post.dart';
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
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance.collection('users').snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection('users');
  final editC = TextEditingController();
  final searchfilterC = TextEditingController();
  String searchText = '';

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
          child: Column(
            children: [

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My Notes",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        auth.signOut().then((value) {
                          utils().toastmessaage("Sign out successfully");
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>const LoginPage()));
                        }).onError((error, stackTrace) {
                          utils().toastmessaage(error.toString());
                        });
                      },
                      icon:const Icon(Icons.logout, color: Colors.white),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.all(16.w),
                child: TextFormField(
                  controller: searchfilterC,
                  style:const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search notes...",
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
                    prefixIcon:const Icon(Icons.search, color: Colors.white70),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius:const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: firestore,
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator(
                          color: Colors.white,
                        ));
                      }
                      if (snapshot.hasError) {
                        return const Center(child: Text("Some Error", 
                          style: TextStyle(color: Colors.white)));
                      }

                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final doc = snapshot.data!.docs[index];
                          final title = doc['title'].toString();
                          
                          if (searchfilterC.text.isEmpty ||
                              title.toLowerCase().contains(searchText.toLowerCase())) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                title: Text(
                                  title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                // subtitle: Text(
                                //   doc['id'],
                                //   style: TextStyle(
                                //     color: Colors.white60,
                                //     fontSize: 12.sp,
                                //   ),
                                // ),
                                trailing: PopupMenuButton(
                                  icon:const Icon(Icons.more_vert, color: Colors.white),
                                  color:const Color(0xFF2C3E50),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.pop(context);
                                          showMyDialogue(title, doc['id']);
                                        },
                                        title:const Text("Edit",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        trailing:
                                           const Icon(Icons.edit, color: Colors.white),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      child: ListTile(
                                        onTap: () {
                                          ref.doc(doc['id']).delete();
                                          Navigator.pop(context);
                                        },
                                        title:const Text("Delete",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        trailing:const Icon(Icons.delete,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return Container();
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>const FirestoreAddPost()));
        },
        backgroundColor: Colors.white,
        child:const Icon(Icons.add, color: Color(0xFF2C3E50)),
      ),
    );
  }

  Future<void> showMyDialogue(String title, String id) {
    editC.text = title;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor:const Color(0xFF2C3E50),
          title:const Text("Update Note", style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: editC,
            style:const TextStyle(color: Colors.white),
            decoration: InputDecoration(
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
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child:const Text("Cancel", style: TextStyle(color: Colors.white70)),
            ),
            TextButton(
              onPressed: () {
                ref.doc(id).update({
                  'title': editC.text
                }).then((value) {
                  utils().toastmessaage('Note updated');
                }).onError((error, stackTrace) {
                  utils().toastmessaage(error.toString());
                });
                Navigator.pop(context);
              },
              child:const Text("Update", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}