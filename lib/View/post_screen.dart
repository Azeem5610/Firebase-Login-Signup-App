import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_login_signup/View/add_post.dart';
import 'package:firebase_login_signup/View/login_page.dart';
import 'package:firebase_login_signup/Widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
final  ref=FirebaseDatabase.instance.ref('Student');
final auth=FirebaseAuth.instance;
final searchfilterC=TextEditingController();
final editC=TextEditingController();
 @override
  Widget build(BuildContext context) {

    return Scaffold( 
            floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder:(context) => addPost(),));
      },child: Icon(Icons.add),
      ),
      appBar: AppBar( 
        centerTitle:true,
        title:Text("Post Screen"),
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              controller: searchfilterC,
              decoration:const  InputDecoration( 
                hintText: "Search",
                border: OutlineInputBorder(
            
                )
              ),
              onChanged: (value) {
                setState(() {
                  
                });
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(query: ref, itemBuilder:(context, snapshot, animation, index) {
              final title=snapshot.child('perspective').value.toString();
              if(searchfilterC.text.isEmpty){
                  return ListTile( 
                title:Text(snapshot.child('perspective').value.toString()) ,
                subtitle:Text(snapshot.child('id').value.toString()),
                trailing:PopupMenuButton(
                  
                  icon: Icon(Icons.more_vert),
                  itemBuilder:(context) => [
                    PopupMenuItem(child: ListTile( 
                      onTap: () {
                         Navigator.pop(context);
                        showMyDialogue(title,snapshot.child('id').value.toString());
                       
                      },
                    
                      title: Text("Edit"),
                      trailing: Icon(Icons.edit),
                      
                    )
                    ),
                    PopupMenuItem(child: ListTile(
                      onTap: () {
                        ref.child(snapshot.child('id').value.toString()).remove();
                        Navigator.pop(context);
                      },
                      title: Text("Delete"),
                      trailing: Icon(Icons.delete),
                     ))

                ],)
               );
              }else if(title.toLowerCase().contains(searchfilterC.text.toLowerCase())){
                 return ListTile( 
                title:Text(snapshot.child('perspective').value.toString()) ,
                subtitle:Text(snapshot.child('id').value.toString()),
                trailing: PopupMenuButton(
                  icon: Icon(Icons.more_vert),
                  itemBuilder: (context) =>const [ 
                    PopupMenuItem( 
                      child: ListTile( 
                        leading: Text("Edit"),
                        trailing: Icon(Icons.edit),
                      ),
                    ),
                    PopupMenuItem(child: ListTile( 
                      leading: Text("Delete"),
                      trailing: Icon(Icons.delete),
                    ))
                  ],
                ),
                );
              
              }else{
                return Container();
              }
              
            },))
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
               ref.child(id).update({
                'perspective':editC.text
               }).then((value){

                utils().toastmessaage('Post updated');

               }).onError((error, stackTrace) {
                utils().toastmessaage(error.toString());     
               },);

              Navigator.pop(context);
              
            }, child:Text("Update"))
          ],
        );
      },);

  }
}







//  Expanded(
//           child: StreamBuilder(stream: ref.onValue, builder:(context, snapshot) {
            
            
//             if(!snapshot.hasData){
//               return Center(child: CircularProgressIndicator());
//             }else{
//               Map<dynamic,dynamic> map=snapshot.data!.snapshot.value as dynamic;
//               List<dynamic>list=[];
//               list.clear();
//               list=map.values.toList();

//             return ListView.builder(
//               itemCount: snapshot.data!.snapshot.children.length,
//               itemBuilder:(context, index) {
//                 return ListTile( 
//                   title:Text(list[index]['perspective']) ,
//                   subtitle:Text(list[index]['id']) ,
//                 );
//               },
//               );
//               }
//           },)
//           ),