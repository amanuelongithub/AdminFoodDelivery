import 'dart:typed_data';

import 'package:admin_fooddelivery/screen/home_screen.dart';
import 'package:admin_fooddelivery/utils/colors.dart';
import 'package:admin_fooddelivery/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

import '../resources/firestore_method.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  Uint8List? _file;
  bool _isLoading = false;

  void postImage(
    String uid,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FireStoreMethods().uploadPost(
        _titleController.text,
        _contentController.text,
        _descriptionController.text,
        _priceController.text,
        _file!,
        uid,
      );
      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });

        Utils.showSnackBar("Posted seccessfully!");
        clearImage();
        Get.off(() => HomePage());
      } else {
        setState(() {
          _isLoading = false;
        });

        Utils.showSnackBar(res);
      }
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  _selectImag(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create Post '),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(10));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Post to",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: false,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
        backgroundColor: Colors.amber,
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
                  _selectImag(context);
                },
                child: Text(
                  "Add Image",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.amber),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9), // <-- Radius
                    ),
                    backgroundColor: Colors.black),
                onPressed: () {
                  postImage(_auth.currentUser!.uid);
                },
                child: Text(
                  "Post",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.amber),
                )),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            _isLoading
                ? LinearProgressIndicator(
                    color: AppColors.maincolor,
                  )
                : const Padding(
                    padding: EdgeInsets.only(
                      top: 0,
                    ),
                  ),
            const Divider(),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(
                        "assets/image/user.jpg",
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: _titleController,
                          showCursor: true,
                          cursorColor: Theme.of(context).primaryColor,
                          enableInteractiveSelection: true,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "Food title",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 126, 126, 126),
                                fontWeight: FontWeight.bold),
                            border: inputBorder,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 126, 126, 126),
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: _contentController,
                          showCursor: true,
                          cursorColor: Theme.of(context).primaryColor,
                          enableInteractiveSelection: true,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "Content",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 126, 126, 126),
                                fontWeight: FontWeight.bold),
                            border: inputBorder,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 126, 126, 126),
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: _descriptionController,
                          showCursor: true,
                          cursorColor: Theme.of(context).primaryColor,
                          enableInteractiveSelection: true,
                          textInputAction: TextInputAction.next,
                          maxLines: 8,
                          decoration: InputDecoration(
                            hintText: 'Write a caption...',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 126, 126, 126),
                                fontWeight: FontWeight.bold),
                            border: inputBorder,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 126, 126, 126),
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: _priceController,
                          showCursor: true,
                          cursorColor: Theme.of(context).primaryColor,
                          enableInteractiveSelection: true,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintText: "Price",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 126, 126, 126),
                                fontWeight: FontWeight.bold),
                            border: inputBorder,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 126, 126, 126),
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                          width: 300,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: Color.fromARGB(255, 126, 126, 126))),
                          child: _file == null
                              ? const Center(
                                  child: Icon(
                                  Icons.image,
                                  color: Color.fromARGB(255, 126, 126, 126),
                                  size: 80,
                                ))
                              : Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: MemoryImage(_file!),
                                          fit: BoxFit.contain)),
                                )),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Visibility(
                              visible: _file != null,
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            9), // <-- Radius
                                      ),
                                      backgroundColor: Colors.amber),
                                  onPressed: clearImage,
                                  child: Text(
                                    "Clear Image",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.black),
                                  )),
                              replacement: Container(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
