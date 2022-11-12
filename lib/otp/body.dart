import 'package:admin_fooddelivery/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/default_button.dart';
import '../utils/colors.dart';
import 'otp_form.dart';

class OtpBody extends StatefulWidget {
  final String phone;
  final String verificationId;
  const OtpBody({Key? key, required this.phone, required this.verificationId})
      : super(key: key);

  @override
  State<OtpBody> createState() => _OtpBodyState();
}

class _OtpBodyState extends State<OtpBody> {
  bool showForm = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 90),
              Text(
                "SMS Verification",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "We have sent an SMS code to " +
                    widget.phone.replaceRange(7, 11, "****"),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              showForm == true
                  ? buildTimer()
                  : const Text(
                      "The code has expired",
                      textAlign: TextAlign.center,
                    ),
              SizedBox(height: 20),
              showForm
                  ? OtpForm(verificationId: widget.verificationId)
                  : DefaultButton(
                      press: () {
                        Get.off(() => LoginPage());
                      },
                      text: "Resend OTP"),
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "The code will expire in ",
        ),
        TweenAnimationBuilder(
          tween: Tween(begin: 60.0, end: 0.0),
          duration: const Duration(seconds: 60),
          builder: (context, value, child) => Text(
            "00:${(value as double).toInt()}",
            style: TextStyle(
              color: AppColors.maincolor,
            ),
          ),
          onEnd: () {
            setState(() {
              showForm = false;
            });
          },
        ),
      ],
    );
  }
}
