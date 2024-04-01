import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parse/controller/back4app.dart';
import 'package:flutter_parse/screens/login.dart';
import 'package:flutter_parse/widgets/input_field.dart';
import 'package:image_picker/image_picker.dart';

class RegisterationScreen extends StatefulWidget {
  const RegisterationScreen({super.key});

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  final userNameController = TextEditingController();
  final emailIdController = TextEditingController();
  final passController = TextEditingController();
  final ageController = TextEditingController();
  String userName ='', email='', password='';

  late File image;
  late XFile ximage;
  final picker = ImagePicker();
  

  @override
  void initState() {
    super.initState();
    Back4App().initParse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            InputField(controller: userNameController, hintText: "UserName"),
            InputField(controller: emailIdController, hintText: 'Email Address'),
            InputField(controller: passController, hintText: 'Password'),
            InputField(controller: ageController, hintText: 'Enter age'),
             Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.deepPurple),
                  child: TextButton(
                      onPressed: () {
                      showOptions();
                      },
                      child: const Text(
                        "Pick Image",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
            ElevatedButton(
             
              onPressed: () {
                 ximage = XFile(image.path);
                userName = userNameController.text;
                email = emailIdController.text;
                password = passController.text;
                var age = ageController.text;
                Back4App().registerUser(userName,
                    email, age, password,ximage,context);
                    setState(() {
                      
                    });
              },
              child: const Text(
                'Sign Up',
                style: TextStyle(fontSize: 22),
              ),
            ),
            const SizedBox(height: 20),
            RichText(
                  text: TextSpan(
                      text: 'Already have an account?',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      children: <TextSpan>[
                    TextSpan(
                        text: ' Sign In',
                        style: const TextStyle(
                            color: Colors.blueAccent, fontSize: 18),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LoginScreen()));
                          })
                  ]))
          ],
        ),
      ),
    );
  }
   //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    });
  }

//Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    });
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

}
