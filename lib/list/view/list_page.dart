import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaselogin/editpage/view/edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ListPage extends StatelessWidget {
 ListPage({Key? key}) : super(key: key);
 CollectionReference firestore = FirebaseFirestore.instance.collection('user');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder(
        builder: (context, AsyncSnapshot <QuerySnapshot >snapshot) {
          if(snapshot.hasData){
            return ListView(
              children: snapshot.data!.docs.map((e){
                return Card(
                  child: ListTile(
                    
                    
                    // title: Text(e.id),
                    leading: Text(e["full_name"].toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: (){
                              
                           Navigator.push(context, MaterialPageRoute<void>(builder: ((context) {
                             return EditPage(document: e);
                           })));
                        }, icon: Icon(Icons.edit)),

                        IconButton(onPressed: (){
                              
                          deleteUser(e.id);
                        }, 
                        icon: Icon(Icons.delete)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }else{

            return CircularProgressIndicator();
          }
        },
        stream: firestore.snapshots(),)
    );
  }



Future<void> deleteUser(String id) {
  
  return firestore
    .doc(id)
    .delete()
    .then((value) => print("User Deleted"))
    .catchError((dynamic error) => print("Failed to delete user: $error"));
}
}