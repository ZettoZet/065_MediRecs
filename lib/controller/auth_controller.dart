// ignore_for_file: avoid_print
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finalexam/model/user_model.dart';

class AuthController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

    final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();

  bool get success => false;

    var poliCollection = FirebaseFirestore.instance.collection('poli');
    

  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(
            email: email,
            password: password);
            
      final User? user = userCredential.user;

      if (user != null) {
        final DocumentSnapshot snapshot =
            await userCollection.doc(user.uid).get();
        
        final UserModel currentUser = UserModel(
          uid: user.uid,
          email: user.email ?? '',
          name: snapshot['name'] ?? '',
          role: snapshot['role'] ?? '',
        );
        return currentUser;
      }
    } catch (e) {
      print("error signing in: $e");
    }
    return null;
  }

  Future<UserModel?> registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      if (user != null) {
        final UserModel newUser = 
        UserModel(
          uid: user.uid,
          email: user.email ?? '',
          name: name,
          role: 'user',
        );
        await userCollection.doc(newUser.uid).set(newUser.toMap());
        return newUser;
      }
    } catch (e) {
      print('error registering user:$e');
    }
    return null;
  }

  UserModel? getCurrentUser() {
    final User? user = auth.currentUser;
    if (user != null) {
      return UserModel.fromFirebaseUser(user);
    }
    return null;
  }

Future<List<DocumentSnapshot<Object?>>>? getPoli() async {

  final poli = await poliCollection.get();

  streamController.sink.add(poli.docs);
  return poli.docs;
}


  // Future<void> signOut() async{
  //   await auth.signOut();
  // }
}
