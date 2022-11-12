import 'package:admin_fooddelivery/resources/firestore_method.dart';
import 'package:admin_fooddelivery/screen/add_post.dart';
import 'package:admin_fooddelivery/screen/home_screen.dart';
import 'package:admin_fooddelivery/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../components/default_button.dart';
import '../resources/auth_methods.dart';
import '../utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class OtpForm extends StatefulWidget {
  final String verificationId;
  const OtpForm({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpCodeController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _otpCodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(10));
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextFormField(
                    autofocus: true,
                    controller: _otpCodeController,
                    maxLength: 6,
                    //focusNode: pin6FocusNode,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      counterText: "",
                      border: inputBorder,
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return "";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 45),
            DefaultButton(
              text: isLoading ? "Waiting..." : "Verify",
              press: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    isLoading = true;
                  });

                  // isLoading?
                  String? res = await AuthMethods().verifyUser(
                      verificationId: widget.verificationId,
                      otpCode: _otpCodeController.text);
                  setState(() {
                    isLoading = false;
                  });
                  if (res == "Successfully signed in") {
                    Get.to(() => const HomePage());
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
