import 'package:flutter/material.dart';
import 'package:trukkertrakker/src/app.dart';
import 'Sign.dart';

// firebase用のimport
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as developer;
FirebaseDatabase database = FirebaseDatabase.instance;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;
  bool isVisible = false;

  // Login field email address
  String loginUserEmail = "";
  // Login field password (login)
  String loginUserPassword = "";
  // View information about registration and login
  String DebugText = "";

  void toggleShowPassword() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  void setEmail(String email) {
    loginUserEmail = email;
  }

  void setPassword(String password) {
    loginUserPassword = password;
  }

  void _login() async {
    // if (email != null && password != null) {
    //   // Replace this with actual authentication logic
    //   if (email == "user@example.com" && password == "password123") {
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (context) => MyStatefulWidget()),
    //     );
    //   } else {
    //     // error message
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('無効なメールアドレスまたはパスワード')),
    //     );
    //   }
    // }

    try { 
        // Try login
        final FirebaseAuth auth = FirebaseAuth.instance;
        final UserCredential result =
            await auth.signInWithEmailAndPassword(
          email: loginUserEmail,
          password: loginUserPassword,
        );
        
        // Succeeded to login
        final User user = result.user!;
        setState(() {
          DebugText = "Succeeded to Login：${user.email}";
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyStatefulWidget()),
        );

      } catch (e) {
        
        // Failed to login
        setState(() {
          DebugText = "Failed to Login：${e.toString()}";
        });
      }
  }

  void _loginAsGuest() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyStatefulWidget()),
    );
  }

  void _navigateToSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
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
            Text('ログイン', style: TextStyle(fontSize: 35)),
            Text(
              'メールアドレスとパスワードを入力してください',
              style: TextStyle(fontSize: 15),
            ),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: ValidateText.email,
                      decoration: const InputDecoration(
                          filled: true, hintText: 'Hirano._.@domain.com'),
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
                      onPressed: _login,
                      child: const Text('ログイン'),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(144, double.infinity),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: _loginAsGuest,
                      child: const Text('ゲストでログイン'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextButton(
                      onPressed: _navigateToSignup,
                      child: const Text('新規会員登録'),
                    ),
                    const SizedBox(height: 8),
                    Text(DebugText),
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
