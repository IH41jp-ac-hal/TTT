import 'package:flutter/material.dart';
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
          preferredSize: Size.fromHeight(80.0), // AppBarの高さをここで指定します
          child: AppBar(
            title: Row(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/logo.png'),
                    ),
                  ),
                ),
                Text(
                  'アカウント',
                  style: TextStyle(
                    fontSize: getAppBarFontSize(context),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            backgroundColor: Color(0xFF00334d),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    right: 15.0,
                    top: MediaQuery.of(context).size.height * 0.03),
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
                  padding: EdgeInsets.only(
                      right: 15.0,
                      top: MediaQuery.of(context).size.height * 0.1),
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage(accountInfo.profileImageUrl),
                    backgroundColor: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 10.0),

                // 名前
                Text(
                  accountInfo.name,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0),

                // メールアドレス
                Text(
                  accountInfo.email,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
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
                  child: Text(
                    '編集',
                    style: TextStyle(color: Color(0xFF00334d)),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Color(0xFFe6e6e6),
      ),
    );
  }

  double getAppBarHeight(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight < 600) {
      return 80.0; // Small screen height
    } else if (screenHeight < 900) {
      return 100.0; // Medium screen height
    } else {
      return 110.0; // Large screen height
    }
  }

  double getAppBarFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 400) {
      return 20.0; // Small screen width
    } else if (screenWidth < 800) {
      return 24.0; // Medium screen width
    } else {
      return 28.0; // Large screen width
    }
  }
}
