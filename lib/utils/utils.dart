import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }

  print('No image is selected ');
}

// void showOTPDialog({
//   required BuildContext context,
//   required TextEditingController codeController,
//   required VoidCallback onPressed,
// }) {
//   showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: const Text("Enter OTP"),
//       content: Column(
//         children: <Widget>[
//           TextField(
//             controller: codeController,
//           ),
//         ],
//       ),
//       actions: <Widget>[TextButton(onPressed: onPressed, child: Text("Done"))],
//     ),
//   );
// }

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String content) {
    final snackbar =
        SnackBar(duration: const Duration(seconds: 3), content: Text(content));

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }
}
