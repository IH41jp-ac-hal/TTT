import 'package:flutter/material.dart';
import 'package:trukkertrakker/src/app.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignUpPage> {
  String? email;
  String? password;
  bool isVisible = false;

  void toggleShowPassword() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  void setEmail(String email) {
    this.email = email;
  }

  void setPassword(String password) {
    this.password = password;
  }

  void _signup() {
    if (email != null && password != null) {
      // Replace this with actual signup logic
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyStatefulWidget()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), // AppBarの高さをここで指定します
        child: AppBar(
          title: Text(
            'TruckerTrekker',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF84a2d4),
        ),
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
                      height: 1,
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
                      child: const Text(
                        'サインイン',
                        style: TextStyle(color: Color(0xFF84a2d4)),
                      ),
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
