import 'package:admin_fooddelivery/otp/body.dart';
import 'package:admin_fooddelivery/resources/firestore_method.dart';
import 'package:admin_fooddelivery/utils/colors.dart';
import 'package:admin_fooddelivery/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/default_button.dart';
import '../main.dart';
import 'add_post.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  String phoneNo = "";
  String smsCode = "";
  String verificationId = "";
  bool isSending = false;
  bool codeSent = false;

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  // Future<void> verifyPhone() async {
  //   final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
  //     this.verificationId = verId;
  //   };

  //   final PhoneCodeSent smsCodeSent = (String verId, int? forceCodeResend) {
  //     this.verificationId = verId;
  //   };

  //   final PhoneVerificationCompleted verifiedSuccess = (User user) {
  //     print("verified");
  //   } as PhoneVerificationCompleted;
  //   final PhoneVerificationFailed verifiFailed = (FirebaseAuthException ex) {
  //     print('${ex.message}');
  //   };
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: this.phoneNo,
  //     verificationCompleted: verifiedSuccess,
  //     verificationFailed: verifiFailed,
  //     codeSent: smsCodeSent,
  //     codeAutoRetrievalTimeout: autoRetrieve,
  //     timeout: const Duration(minutes: 1),
  //   );

  //   // phonenumber = "+251${_phoneNumberController.text}";
  //   // Utils.showSnackBar(phonenumber);
  //   // FireStoreMethods().phoneSignIn(context, phonenumber);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: conditionalWrapper());
  }

  Widget conditionalWrapper() {
    if (isSending && !codeSent) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 60),
              child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Please use the link to verify you are not a robot",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
            
            Center(
              child: CircularProgressIndicator(
                color: AppColors.maincolor,
              ),
            ),

            Container(),

          ],
        ),
      );
    }
    if (!codeSent && !isSending) {
      return Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: Column(
                      children: const [
                        Text(
                          "Only For Admin ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 35),
                        ),
                        Text(
                          "Food Delivery",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Form(key: _formKey, child: buildPhoneNumberField(context)),
                  SizedBox(
                    height: 40,
                  ),
                  DefaultButton(
                      text: "Login",
                      press: () {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                buildPhoneConfirmationPopup(context));
                      }),
                ],
              ),
            ),
          ),
        ],
      );
    }
    if (codeSent) {
      return OtpBody(
          phone: "+251" + _phoneNumberController.text,
          verificationId: verificationId);
    }
    return Container();
  }

  void sendOtp() async {
    setState(() {
      isSending = true;
    });
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      phoneNumber: "+251" + _phoneNumberController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!

        // Sign the user in (or link) with the auto-generated credential
        await auth.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      codeSent: (String verificationId, int? forceResendingToken) async {
        //Update the UI for user to enter SMS Code and store verificationID on variable
        setState(() {
          this.verificationId = verificationId;
          isSending = false;
          codeSent = true;
        });
      },
      verificationFailed: (FirebaseAuthException error) {
        setState(() {
          isSending = false;
        });
        Utils.showSnackBar(error.message.toString());
      },
    );
  }

  SimpleDialog buildPhoneConfirmationPopup(BuildContext context) {
    return SimpleDialog(
      title: Text(
        "Confirm Phone Number",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16),
      ),
      contentPadding: const EdgeInsets.all(20.0),
      children: [
        const Text("We are going to send confimation code to ",
            textAlign: TextAlign.center),
        Text(
          "+251" + _phoneNumberController.text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const Text("Would you like to continue?", textAlign: TextAlign.center),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel",
                    style: TextStyle(color: AppColors.maincolor))),
            TextButton(
                onPressed: () {
                  //Continue to verification page after continue
                  Navigator.of(context).pop();
                  setState(() {
                    isSending = true;
                  });
                  sendOtp();
                },
                child: Text(
                  "Continue",
                  style: TextStyle(color: AppColors.maincolor),
                ))
          ],
        ),
      ],
    );
  }

  TextFormField buildPhoneNumberField(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(10));
    return TextFormField(
      controller: _phoneNumberController,
      showCursor: true,
      cursorColor: Theme.of(context).primaryColor,
      enableInteractiveSelection: true,
      maxLength: 9,
      // validator: (value) {
      // },
      decoration: InputDecoration(
        hintText: "Phone number",
        hintStyle: TextStyle(
            color: Color.fromARGB(255, 126, 126, 126),
            fontWeight: FontWeight.bold),
        border: inputBorder,
        prefixText: "+251 ",
        suffixIcon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              color: Color.fromARGB(255, 126, 126, 126),
              Icons.phone_outlined,
              size: 20,
            ),
          ],
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      keyboardType: TextInputType.phone,
    );
  }
}
