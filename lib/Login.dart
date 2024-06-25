import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'src/app.dart';
import 'firebase_options.dart';

// firebaseのrealtimedatabase用のimport
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as developer;
FirebaseDatabase database = FirebaseDatabase.instance;

void main() {
  runApp(
    LoginApp(),
  );
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase_Auth_App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const AuthAppPage(title: 'Firebase_Auth_App'),
    );
  }
}

class AuthAppPage extends StatefulWidget {
  const AuthAppPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<AuthAppPage> createState() => _AuthAppPageState();
}

class _AuthAppPageState extends State<AuthAppPage> {
  // Registration Field Email Address
  String registerUserEmail = "";
  // Registration Field Password
  String registerUserPassword = "";
  // Login field email address
  String loginUserEmail = "";
  // Login field password (login)
  String loginUserPassword = "";
  // View information about registration and login
  String DebugText = "";

//ログインボタンが押されたとき
  void get() async {
      final ref = FirebaseDatabase.instance.ref('users/1');
      final snapshot = await ref.get();
      if(snapshot.value != null){
        developer.log("value : ${snapshot.value}");
      }else{
        developer.log("value : null");
      }
    }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextFormField(
                // Set labels for text input
                decoration: InputDecoration(labelText: "Mail Address"),
                onChanged: (String value) {
                  setState(() {
                    registerUserEmail = value;
                  });
                },
              ),
              TextFormField(
                decoration:
                    InputDecoration(labelText: "6 character long Password"),
                // Mask not to show password
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    registerUserPassword = value;
                  });
                },
              ),
              const SizedBox(height: 1),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // User Registration
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final UserCredential result =
                        await auth.createUserWithEmailAndPassword(
                      email: registerUserEmail,
                      password: registerUserPassword,
                    );
                    // Registered User Information
                    final User user = result.user!;
                    setState(() {
                      DebugText = "Register OK：${user.email}";
                    });
                  } catch (e) {
                    // Failed User Information
                    setState(() {
                      DebugText = "Register Fail：${e.toString()}";
                    });
                  }
                },
                child: Text("User Registration"),
              ),
              const SizedBox(height: 1),
              TextFormField(
                decoration: InputDecoration(labelText: "Mail Address"),
                onChanged: (String value) {
                  setState(() {
                    loginUserEmail = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    loginUserPassword = value;
                  });
                },
              ),
              const SizedBox(height: 1),
              ElevatedButton(
                onPressed: () async {
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

                    get();

                  } catch (e) {
                    // Failed to login
                    setState(() {
                      DebugText = "Failed to Login：${e.toString()}";
                    });
                  }
                },
                child: Text("Login"),
              ),
              const SizedBox(height: 8),
              Text(DebugText),
            ],
          ),
        ),
      ),
    );
  }
}
