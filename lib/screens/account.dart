import 'package:flutter/material.dart';
import 'package:trukkertrakker/screens/EditAccount.dart';
import 'package:trukkertrakker/src/app.dart';
import 'package:trukkertrakker/user/Setting.dart';

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

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late AccountInfo accountInfo;
  bool _gpsValue = false;

  @override
  void initState() {
    super.initState();
    // アカウント情報取得 (仮)
    accountInfo = AccountInfo(
      name: '山田　太郎',
      email: 'yamada@domain.com',
      profileImageUrl: 'assets/logo.png',
      bio: 'こんにちわ。○○運送です。よろしくお願います。',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110.0),
          child: AppBar(
            centerTitle: false,
            title: Text(
              'アカウント',
              style: TextStyle(fontSize: 18, height: 3),
            ),
            backgroundColor: Color.fromARGB(255, 9, 142, 163),
            actions: <Widget>[
              IconButton(
                highlightColor: Colors.red,
                icon: Icon(Icons.people),
                iconSize: 35,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingPage(
                        title: '位置情報取得',
                        value: _gpsValue,
                        onChanged: (bool value) {
                          setState(() {
                            _gpsValue = value;
                          });
                        },
                      ),
                    ),
                  );
                },
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
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(accountInfo.profileImageUrl),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('閉じる'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage(accountInfo.profileImageUrl),
                    ),
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
                      setState(() {
                        // アカウント情報を更新する
                        accountInfo = updatedAccountInfo;
                      });
                    }
                  },
                  child: Text('編集'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
