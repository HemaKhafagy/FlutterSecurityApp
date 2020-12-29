
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:encrypt/encrypt.dart' as encrypt;
import 'my_encryption.dart';



class AddNewUsers{
  final String id;
  final String name;
  final String email;
  final String Password;


  AddNewUsers({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.Password,
  });
}



class AddNewUser with ChangeNotifier {
  final _auth=FirebaseAuth.instance;
  Future<void> signUp(String email,String password,String name) async{
    UserCredential authResult;
    try{
      authResult=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      var encryptedText=MyEncryptionDecryption.encryptSalsa20(password);
      await FirebaseFirestore.instance.collection("allUsers").doc(authResult.user.uid).set({
        "email": email,
        "pass":  '${encryptedText.base64}',
        "name": name,
      });
    }on FirebaseAuthException catch (e) {
      // if (e.code == 'weak-password') {
      //   print('The password provided is too weak.');
      // } else if (e.code == 'email-already-in-use') {
      //   print('The account already exists for that email.');
      // }
      throw e;
    } catch (e) {
      throw e;
     // print(e);
    }
  }


}