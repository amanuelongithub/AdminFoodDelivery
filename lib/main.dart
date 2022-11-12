import 'package:admin_fooddelivery/screen/home_screen.dart';
import 'package:admin_fooddelivery/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screen/add_post.dart';
import 'utils/colors.dart';
import 'utils/utils.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

final navigatorKey = GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: Utils.messengerKey,
        theme: ThemeData(
            primaryColor: Colors.white,
            fontFamily: "HandoSoft",
            iconTheme: const IconThemeData(color: Colors.black),
            colorScheme: const ColorScheme.dark()),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const HomePage();
              } else if (snapshot.hasError) {
                return Center(
                    child: Text(
                  '${snapshot.error}',
                ));
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(
                color: AppColors.maincolor,
              );
            } else {
              return LoginPage();
            }
          },
        ));
  }
}
