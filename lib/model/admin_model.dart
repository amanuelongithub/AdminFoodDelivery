import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  final String uid;
  final String phoneNumber;
  const Admin({
    required this.uid,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "phoneNumber": phoneNumber,
      };
}
