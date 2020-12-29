import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  Future<void> logIn(String email, String password) async {
    UserCredential authResult;
    try {
      authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }


}

// Future<void> logIn1(String email, String password) async {
//   try {
//     UserCredential userCredential = await FirebaseAuth.instance
//         .signInWithEmailAndPassword(email: email, password: password);
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'user-not-found') {
//       print('No user found for that email.');
//     } else if (e.code == 'wrong-password') {
//       print('Wrong password provided for that user.');
//     }
//   }
// }
// Future<void> _authenticate(String email,String password,String urlSegment) async{
//   final url="https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyA2PZ4aHQJv9QEKzBzyFVpFGeRU4aYvtII";
//
//   try{
//     final res=await http.post(url,body: jsonEncode({
//       'email':email,
//       'password':password,
//       'returnSecureToken':true,
//     }));
//     final resData=json.decode(res.body);
//     if(resData['error']!=null){
//       throw "${resData['error']['message']}";
//     }
//   }catch(e){
//     throw e;
//   }
// }
//
// Future<void> signUp(String email,String password) async{
//   return _authenticate(email, password, "signUp");
// }
//
// Future<void> logIn(String email,String password) async{
//   return _authenticate(email, password, "signInWithPassword");
// }

// Future<void> _authenticate(String email,String password,String urlSegment) async{
//
//   UserCredential authResult;
//   try{
//     if(urlSegment == logIn){
//       authResult=await _auth.signInWithEmailAndPassword(email: email, password: password);
//     }else {
//       authResult = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//     }
//   }catch
//
// }
// Future<void> signUp(String email,String password) async{
//   UserCredential authResult;
//   try{
//     authResult=await _auth.createUserWithEmailAndPassword(email: email, password: password);
//     await FirebaseFirestore.instance.collection("new pro").doc(authResult.user.uid).set({
//         "pass":  password
//     });
//   }on FirebaseAuthException catch (e) {
//     if (e.code == 'weak-password') {
//       print('The password provided is too weak.');
//     } else if (e.code == 'email-already-in-use') {
//       print('The account already exists for that email.');
//     }
//   } catch (e) {
//     print(e);
//   }
// }
