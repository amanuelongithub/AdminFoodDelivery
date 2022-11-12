import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          // final hasdata = snapshot.data.docs.length.toString();

          return Badge(
            badgeContent: Text(
              snapshot.hasData ? snapshot.data!.docs.length.toString() : '0',
              // "0",
              style: TextStyle(color: Colors.black),
            ),
            badgeColor: Colors.amber,
            child: InkWell(
              onTap: () {},
              splashColor: Color.fromARGB(192, 211, 161, 12),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border:
                        Border.all(color: Color.fromARGB(255, 123, 123, 123))),
                child: Center(
                  child: Text(
                    "Orders",
                    style: TextStyle(
                        color: AppColors.maincolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
