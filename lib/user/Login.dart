import 'package:flutter/material.dart';
import 'package:trukkertrakker/src/app.dart';
import 'Sign.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  void _login() {
    if (email != null && password != null) {
      // Replace this with actual authentication logic
      if (email == "user@example.com" && password == "password123") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyStatefulWidget()),
        );
      } else {
        // error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('無効なメールアドレスまたはパスワード')),
        );
      }
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
