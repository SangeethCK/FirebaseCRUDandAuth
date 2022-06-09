import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class EditPage extends StatefulWidget {
 EditPage({Key? key,required this.document}) : super(key: key);
 
QueryDocumentSnapshot document;

CollectionReference firestore = FirebaseFirestore.instance.collection("user");

  @override
  State<EditPage> createState() => _EditPageState();
}



class _EditPageState extends State<EditPage> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
       editController.text=widget.document["full_name"].toString();
  }


TextEditingController editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: editController,
              decoration: InputDecoration(
                
                border: OutlineInputBorder()),),
                ElevatedButton(onPressed: (){
                  
                  updateUser();

                  
                }, child: Text("EDIT"))
          ],
        ),
      ))
    );
  }


  Future<void> updateUser() {
  return widget.firestore
    .doc(widget.document.id)
    .update({'full_name': editController.text})
    .then((value){ 
      print("User Updated");
      Navigator.pop(context);
     })
    .catchError((dynamic error) => print("Failed to update user: $error"));
}
}