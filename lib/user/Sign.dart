import 'package:flutter/material.dart';
import 'package:trukkertrakker/src/app.dart';

// firebase用のimport
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:developer' as developer;

FirebaseDatabase database = FirebaseDatabase.instance;

class SignUpPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignUpPage> {
  String? email;
  String? password;
  bool isVisible = false;

  // Registration Field Email Address
  String registerUserEmail = "";
  // Registration Field Password
  String registerUserPassword = "";
  // View information about registration and login
  String DebugText = "";

  void toggleShowPassword() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  void setEmail(String email) {
    registerUserEmail = email;
  }

  void setPassword(String password) {
    registerUserPassword = password;
  }

  void _signup() async {
    // if (email != null && password != null) {
    //   // Replace this with actual signup logic
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => MyStatefulWidget()),
    //   );
    // }
    try {
      // User Registration
      final FirebaseAuth auth = FirebaseAuth.instance;
      final UserCredential result = await auth.createUserWithEmailAndPassword(
        email: registerUserEmail,
        password: registerUserPassword,
      );
      // Registered User Information
      final User user = result.user!;
      setState(() {
        DebugText = "Register OK：${user.email}";
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyStatefulWidget()),
      );
    } catch (e) {
      // Failed User Information
      setState(() {
        DebugText = "Register Fail：${e.toString()}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //Initialize FireBase
    Firebase.initializeApp();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TruckerTrekker',
          style: TextStyle(color: const Color.fromARGB(255, 255, 0, 0)),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('新規会員登録', style: TextStyle(fontSize: 35)),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: ValidateText.email,
                      decoration: const InputDecoration(
                          filled: true, hintText: 'メールアドレス'),
                      onChanged: (text) {
                        setEmail(text);
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: ValidateText.password,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(isVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              toggleShowPassword();
                            },
                          ),
                          filled: true,
                          hintText: 'パスワード'),
                      onChanged: (text) {
                        setPassword(text);
                      },
                      obscureText: !isVisible,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: _signup,
                      child: const Text('サインイン'),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class ValidateText {
  static String? password(String? value) {
    if (value != null) {
      String pattern = r'^[a-zA-Z0-9]{6,}$';
      RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(value)) {
        return 'Please enter at least 6 alphanumeric characters';
      }
    }
  }

  static String? email(String? value) {
    if (value != null) {
      String pattern = r'^[0-9a-z_./?-]+@([0-9a-z-]+\.)+[0-9a-z-]+$';
      RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(value)) {
        return 'Please enter valid email address';
      }
    }
  }
}