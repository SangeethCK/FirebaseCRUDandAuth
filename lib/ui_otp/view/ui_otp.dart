import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class OTP extends StatelessWidget {
 OTP({Key? key}) : super(key: key);
 TextEditingController numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("LOGIN",style: TextStyle(color: Colors.deepPurple),),
            SizedBox(height: 20,),
            TextFormField(
              controller: numberController,
              decoration: InputDecoration(border: OutlineInputBorder()),),
            ElevatedButton(onPressed: (){
              getOTP();
            }, child: Text("LOGIN"))
          ],
        ),
      )),
    );
  }
Future <void>getOTP()async{


  await FirebaseAuth.instance.verifyPhoneNumber(
  phoneNumber: numberController.text,
  verificationCompleted: (PhoneAuthCredential credential) {},
  verificationFailed: (FirebaseAuthException e) {
    print("failed");
  },
  codeSent: (String verificationId, int? resendToken) {
   showDialog(context: context, builder: (cntxt){

   });
  },
  codeAutoRetrievalTimeout: (String verificationId) {},
);
}
}