// data/repositories/user_repository.dart
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../model/usermodel.dart';

class UserRepository {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  UserRepository(this.firestore, this.storage);

  Future<void> createUser(UserModel user) async {
    await firestore.collection('users').doc(user.uid).set(user.toMap());
  }

  Future<UserModel> getUser(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!);
    } else {
      throw Exception("User not found");
    }
  }

  Future<void> updateUser(UserModel user) async {
    await firestore.collection('users').doc(user.uid).update(user.toMap());
  }

  Stream<List<UserModel>> getAllUsers() {
    return firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserModel.fromMap(doc.data());
      }).toList();
    });
  }

  Future<String> uploadProfileImage(String uid, File file) async {
    final ref = storage.ref().child("profile_images").child("$uid.jpg");
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }
}
