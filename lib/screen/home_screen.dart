import 'package:admin_fooddelivery/components/orders.dart';
import 'package:admin_fooddelivery/resources/auth_methods.dart';
import 'package:admin_fooddelivery/utils/colors.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'add_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) =>
      OrientationBuilder(builder: (context, orientation) {
        final isPortaite = orientation == Orientation.portrait;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber,
            centerTitle: false,
            title: const Text(
              "Admin Dashboards",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9), // <-- Radius
                        ),
                        backgroundColor: Colors.black),
                    onPressed: () {
                      showDialog(
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            backgroundColor:
                                Theme.of(context).bottomAppBarColor,
                            title: Center(
                              child: Text("LogOut",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.maincolor,
                                  )),
                            ),
                            content: const Text(
                              "Do You Want to LogOut?",
                              style: TextStyle(color: Colors.amber),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "No",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.maincolor),
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  AuthMethods().signOut();
                                },
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.maincolor),
                                ),
                              ),
                            ],
                            elevation: 5.0,
                            // shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(10)),
                          );
                        },
                        context: context,
                      );
                    },
                    child: Text(
                      "LogOut",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.amber),
                    )),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: GridView.count(
              physics: BouncingScrollPhysics(),
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              crossAxisCount: isPortaite ? 2 : 3,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => AddPost());
                  },
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
                        border: Border.all(
                            color: Color.fromARGB(255, 123, 123, 123))),
                    child: Center(
                      child: Text(
                        "Post to",
                        style: TextStyle(
                            color: AppColors.maincolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                  ),
                ),
                InkWell(
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
                        border: Border.all(
                            color: Color.fromARGB(255, 123, 123, 123))),
                    child: Center(
                      child: Text(
                        "Report",
                        style: TextStyle(
                            color: AppColors.maincolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                  ),
                )

                ,
                Order(),
                InkWell(
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
                        border: Border.all(
                            color: Color.fromARGB(255, 123, 123, 123))),
                    child: Center(
                      child: Text(
                        "My Account",
                        style: TextStyle(
                            color: AppColors.maincolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                  ),
                ),
                InkWell(
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
                        border: Border.all(
                            color: Color.fromARGB(255, 123, 123, 123))),
                    child: Center(
                      child: Text(
                        "My Post",
                        style: TextStyle(
                            color: AppColors.maincolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                  ),
                ),
                InkWell(
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
                        border: Border.all(
                            color: Color.fromARGB(255, 123, 123, 123))),
                    child: Center(
                      child: Text(
                        "Feedbacks",
                        style: TextStyle(
                            color: AppColors.maincolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
