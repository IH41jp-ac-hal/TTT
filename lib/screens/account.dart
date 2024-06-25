import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:trukkertrakker/src/app.dart';

void main() => runApp(MyApp());

class accountScreen extends StatelessWidget {
  const accountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TruckerTrekker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
=======
import 'package:trukkertrakker/screens/EditAccount.dart';
import 'package:trukkertrakker/src/app.dart';

// アカウント情報モデル
class AccountInfo {
  String name;
  String email;
  String profileImageUrl;
  String bio;

  AccountInfo({
    required this.name,
    required this.email,
    required this.profileImageUrl,
    required this.bio,
  });
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
      bio: 'こんにちは、山田太郎です。フルスタックエンジニアとして働いています。',
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
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                // プロフィール写真
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage(accountInfo.profileImageUrl),
                  ),
                ),
                SizedBox(height: 10.0),

                // 名前
                Text(
                  accountInfo.name,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.0),

                // メールアドレス
                Text(
                  accountInfo.email,
                  style: TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
                SizedBox(height: 20.0),

                // バイオ
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    accountInfo.bio,
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20.0),

                // 編集ボタン
                ElevatedButton(
                  onPressed: () async {
                    final updatedAccountInfo = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditAccountScreen(accountInfo: accountInfo),
                      ),
                    );

                    if (updatedAccountInfo != null) {
                      // アカウント情報を更新する
                      accountInfo.name = updatedAccountInfo.name;
                      accountInfo.email = updatedAccountInfo.email;
                      accountInfo.profileImageUrl =
                          updatedAccountInfo.profileImageUrl;
                      accountInfo.bio = updatedAccountInfo.bio;
                    }
                  },
                  child: Text('編集'),
                ),
              ],
            ),
          ),
        ),
>>>>>>> b237a1803f93961a7b290da88e55f2451b58a022
      ),
    );
  }
}
