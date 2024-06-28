import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
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
  void initState() {
    super.initState();
    FlutterNativeSplash.remove(); // 起動完了時にスプラッシュ画面を終わらせる
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TruckerTrekker',
          style: TextStyle(color: const Color.fromARGB(255, 255, 0, 0)),
        ),
        backgroundColor: Colors.black,
      ),
      //キーボード開いたときのオーバーフロー抑える
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ログイン', style: TextStyle(fontSize: 35)),
                Text(
                  'メールアドレスとパスワードを入力してください',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: ValidateText.email,
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: 'Hirano@domain.com',
                  ),
                  onChanged: (text) {
                    setEmail(text);
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: ValidateText.password,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        isVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: toggleShowPassword,
                    ),
                    filled: true,
                    hintText: 'パスワード',
                  ),
                  onChanged: (text) {
                    setPassword(text);
                  },
                  obscureText: !isVisible,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('ログイン'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(144, double.infinity),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loginAsGuest,
                  child: const Text('ゲストでログイン'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _navigateToSignup,
                  child: const Text('新規会員登録'),
                ),
              ],
            ),
          ),
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
        return 'パスワードが間違ってます';
      }
    }
  }

  static String? email(String? value) {
    if (value != null) {
      String pattern = r'^[0-9a-z_./?-]+@([0-9a-z-]+\.)+[0-9a-z-]+$';
      RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(value)) {
        return '正しいメールアドレスを入力してください';
      }
    }
  }
}
