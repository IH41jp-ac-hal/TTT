import 'package:flutter/material.dart';
import 'package:trukkertrakker/src/app.dart';

// アカウント情報モデル
class AccountInfo {
  final String name;
  final String email;
  final String profileImageUrl;

  AccountInfo(
      {required this.name, required this.email, required this.profileImageUrl});
}

void main() => runApp(MyApp());

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // アカウント情報取得 (仮)
    final accountInfo = AccountInfo(
      name: '山田 太郎',
      email: 'yamada.taro@example.com',
      profileImageUrl: 'assets/logo.png',
    );

    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110.0),
          child: AppBar(
            centerTitle: false,
            title: Text(
              'アカウント',
              style: TextStyle(fontSize: 19, height: 4),
            ),
            backgroundColor: Color.fromARGB(255, 9, 142, 163),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 15.0, top: 23.0),
                child: Container(
                  width: 114,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/logo.png'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              // プロフィール写真
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage(accountInfo.profileImageUrl),
              ),
              SizedBox(height: 20.0),

              // 名前
              Text(
                accountInfo.name,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),

              // メールアドレス
              Text(
                accountInfo.email,
                style: TextStyle(fontSize: 16.0),
              ),

              // 編集ボタン
              ElevatedButton(
                onPressed: () {
                  // 編集画面に遷移 or ダイアログを表示
                },
                child: Text('編集'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
