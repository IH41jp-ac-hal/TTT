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
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth * 0.1;
    double buttonWidth = screenWidth * 0.4; // 画面幅の40%をボタンの幅として使用
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                'TruckerTrekker',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0), // 左右に40.0のパディング適応
                child: Column(
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: ValidateText.email,
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: 'メールアドレスを入力してください',
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      ),
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
                        hintText: 'パスワードを入力してください',
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      ),
                      onChanged: (text) {
                        setPassword(text);
                      },
                      obscureText: !isVisible,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: _login,
                      child: const Text(
                        'ログイン',
                        style: TextStyle(color: Color(0xFF84a2d4)),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(buttonWidth, 45), // レスポンシブなサイズ
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
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(buttonWidth, 45), // レスポンシブなサイズ
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: _loginAsGuest,
                      child: const Text(
                        'ゲストユーザー',
                        style: TextStyle(color: Color(0xFF84a2d4)),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(buttonWidth, 45), // レスポンシブなサイズ
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
