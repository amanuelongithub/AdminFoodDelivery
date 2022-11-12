import 'dart:typed_data';

import 'package:admin_fooddelivery/model/admin_model.dart';
import 'package:admin_fooddelivery/model/post.dart';
import 'package:admin_fooddelivery/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'storage_methods.dart';

class FireStoreMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<bool?> checkIfUserExists(String uid) async {
    bool? exists = false;
    await _firebaseFirestore.collection('users').doc(uid).get().then((doc) {
      exists = doc.exists;
    });
    return exists;
  }

  String initializeUserData(String uid, String phoneNumber) {
    String res = "Failed to add user";
    Admin userToInitialize = Admin(
      uid: uid,
      phoneNumber: phoneNumber,
    );
    _firebaseFirestore
        .collection('admin')
        .doc(uid)
        .set(userToInitialize.toJson())
        .catchError((error) => "Failed to add user: $error");
    return res;
  }


  Future<String> uploadPost(
    String title,
    String content,
    String description,
    String price,
    Uint8List file,
    String uid,
  ) async {
    String res = "Something error occured";

    try {
      String postUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = const Uuid().v1();

      Post post = Post(
        title: title,
        content: content,
        description: description,
        price: price,
        postId: postId,
        postUrl: postUrl,
        datePublished: DateTime.now(),
        uid: uid,
      );

      _firebaseFirestore.collection('posts').doc(postId).set(post.toJson());

      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}