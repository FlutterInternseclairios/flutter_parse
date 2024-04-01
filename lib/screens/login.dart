import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parse/controller/back4app.dart';
import 'package:flutter_parse/screens/profile.dart';
import 'package:flutter_parse/screens/registration.dart';
import 'package:flutter_parse/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userNameController = TextEditingController();
  final emailIdController = TextEditingController();
  final passController = TextEditingController();

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
            InputField(
              controller: userNameController,
              hintText: "User Name",
            ),
            InputField(
              controller: emailIdController,
              hintText: "Email address",
            ),
            InputField(controller: passController, hintText: 'Password'),
            ElevatedButton(
              onPressed: () {
                Back4App().getProfileData(emailIdController.text);
                Back4App.signInUserParse(userNameController.text,emailIdController.text, passController.text,context).then((response) {
                  if(response.success) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const ProfileScreen()));
                  }
                });
              },
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 32),
              ),
            ),
            const SizedBox(height: 20),
            RichText(
                  text: TextSpan(
                      text: 'Don\'t have an account?',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      children: <TextSpan>[
                    TextSpan(
                        text: ' Sign up',
                        style: const TextStyle(
                            color: Colors.blueAccent, fontSize: 18),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterationScreen()));
                          })
                  ]))
          ],
        ),
      ),
    );
  }
}
