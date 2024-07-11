import 'package:flutter/material.dart';
import 'package:trukkertrakker/screens/account.dart';
import 'package:trukkertrakker/user/Login.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String title;
  final bool value;
  final void Function(bool) onChanged;

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _gpsValue = false;
  bool _notificationValue = false;

  @override
  void initState() {
    super.initState();
    _gpsValue = widget.value;
  }

  Future<void> _showGPSConfirmationDialog(bool value) async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('確認'),
          content: Text('位置情報を取得してよろしいですか？'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('キャンセル'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('許可'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      setState(() {
        _gpsValue = value;
      });
      widget.onChanged(value);
    }
  }

  Future<void> _openLocationSettings() async {
    const String url = 'app-settings:';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      //エラー「位置情報設定を開けませんでした」
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          centerTitle: false,
          title: Text(
            '設定',
            style: TextStyle(fontSize: 18, height: 2),
          ),
          backgroundColor: Color.fromARGB(255, 9, 142, 163),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: ListTile(
              title: Text('アカウント',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 175, 235, 243),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AccountScreen()));
            },
            child: ListTile(
              title: Text('平野 樹'),
            ),
          ),
          // ログアウト
          Container(
            margin: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black,
                textStyle: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 16,
                ),
              ),
              onPressed: () async {
                bool? confirmLogout = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('確認'),
                      content: Text('本当にログアウトしてもよろしいですか？'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text('キャンセル'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Text('ログアウト'),
                        ),
                      ],
                    );
                  },
                );

                if (confirmLogout == true) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                }
              },
              child: Text('ログアウト'),
            ),
          ),
          Container(
            child: ListTile(
              title: Text('セッティング',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 175, 235, 243),
            ),
          ),
          SwitchListTile(
            title: const Text("GPS"),
            value: _gpsValue,
            onChanged: (bool value) {
              if (value) {
                _showGPSConfirmationDialog(value);
              } else {
                setState(() {
                  _gpsValue = value;
                });
                widget.onChanged(value);
              }
            },
            secondary: const Icon(Icons.gps_not_fixed_outlined),
          ),
          ListTile(
            title: const Text("デバイスの位置情報設定"),
            onTap: _openLocationSettings,
            leading: const Icon(Icons.location_on),
          ),
          SwitchListTile(
            title: const Text("通知"),
            value: _notificationValue,
            onChanged: (bool value) {
              setState(() {
                _notificationValue = value;
              });
            },
            secondary: const Icon(Icons.notifications_active_outlined),
          ),
          Container(
            child: ListTile(
              title: Text('サポート',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 175, 235, 243),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('ヘルプ　　　　　　　　　　　　　　　　＞'),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('フィードバック　　　　　　　　　　　　＞'),
            ),
          ),
        ],
      ),
    );
  }
}
