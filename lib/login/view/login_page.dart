import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselogin/home/view/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class HomeScreen extends StatelessWidget {
 HomeScreen({Key? key}) : super(key: key);

  CollectionReference firestore = FirebaseFirestore.instance.collection('user');
 
 TextEditingController nameCOntroller = TextEditingController();
  TextEditingController passwordCOntroller = TextEditingController();
  TextEditingController ageCOntroller = TextEditingController();
  


 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DATA MATCHING "),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameCOntroller,
              decoration: const InputDecoration(border: OutlineInputBorder()),),
            const SizedBox(height: 10,),
            TextFormField(
              controller: passwordCOntroller,
              decoration: const InputDecoration(border: OutlineInputBorder()),),
               TextFormField(
              controller: ageCOntroller,
              decoration: const InputDecoration(border: OutlineInputBorder()),),
            const SizedBox(height: 10,),

               

            Row(
             mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: (){
                  addUser();
                   signIn(context);
                  // getIn();
                }, child: Text("LOGIN")),

                
              ],
            )

          ],
        ),
      ),
    );
  }

  void getIn()async {

   try {
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: nameCOntroller.text,
    password: passwordCOntroller.text,
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}


  }


  void signIn(BuildContext context)async{

try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: nameCOntroller.text,
    password: passwordCOntroller.text
  );
 
 Navigator.push(context, MaterialPageRoute<void>(builder: (context) {
   return HomeScreens();
 },));

} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
}

        

  }

  Future<void> addUser()async {
      // Call the user's CollectionReference to add a new user
      return firestore
          .add({
            'full_name': nameCOntroller.text, // John Doe
            'company': passwordCOntroller.text, // Stokes and Sons
            'age': ageCOntroller.text // 42
          })
          .then((value) => print("User Added"))
          .catchError((dynamic error) => print("Failed to add user: $error"));
    }

}