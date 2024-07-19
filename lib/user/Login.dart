import 'package:flutter/material.dart';
import 'package:trukkertrakker/src/app.dart';
import 'Sign.dart';

// firebase用のimport
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer' as developer;

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
      final UserCredential result = await auth.signInWithEmailAndPassword(
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

  void _loginWithGoogle() {
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => MyStatefulWidget()),
    // );
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
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(1.0), // AppBarの高さをここで指定します
      //   child: AppBar(
      //     title: Row(
      //       children: [
      //         Container(
      //           width: 90,
      //           height: 90,
      //           decoration: const BoxDecoration(
      //             // image: DecorationImage(
      //             //   image: AssetImage('assets/logo.png'), //画像
      //             // ),
      //           ),
      //         ),
      //       ],
      //     ),
      //     backgroundColor: Color(0xFF84a2d4),
      //   ),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('TruckerTrekker', style: TextStyle(fontSize: 115, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF), height: 0.9)),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: ValidateText.email,
                      decoration: const InputDecoration(
                          filled: true, hintText: 'メールアドレスを入力してください'),
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
                          hintText: 'パスワードを入力してください'),
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
                      child: const Text(
                        'ログイン',
                        style: TextStyle(color: Color(0xFF84a2d4)),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(144, double.infinity),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: _loginAsGuest,
                      child: const Text(
                        'ゲストでログイン',
                        style: TextStyle(color: Color(0xFF84a2d4)),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // サインイン画面を表示する
                        signInWithGoogle();
                      },
                      child: const Text('Googleでログイン'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: _navigateToSignup,
                      child: const Text(
                        '新規会員登録',
                        style: TextStyle(color: Color(0xFF84a2d4)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(DebugText),
                  ],
                )),
          ],
        ),
      ),
      backgroundColor: Color(0xFF84a2d4),
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

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}