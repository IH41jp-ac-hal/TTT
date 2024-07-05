import 'package:flutter/material.dart';
import 'package:trukkertrakker/src/app.dart';

void main() => runApp(MyApp());

class InformationScreen extends StatefulWidget {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  // どのボタンが押されたかを記録する変数
  String? lastPressedButton;

  // 現在の混雑状況を取得する関数
  String getCurrentStatus() {
    // どのボタンも押されていない場合は「平常」を返す
    if (lastPressedButton == null) {
      return '平常';
    }
    return lastPressedButton!;
  }

  // 状況に応じた背景色を返す関数
  Color getBackgroundColor() {
    String currentStatus = getCurrentStatus();
    switch (currentStatus) {
      case '平常':
        return Colors.lightGreen;
      case '~10分':
        return Colors.lightBlue;
      case '~30分':
        return Colors.orangeAccent;
      case '30分以上':
        return Colors.redAccent;
      case '渋滞':
        return Colors.purpleAccent;
      default:
        return Colors.blueGrey;
    }
  }

  // 押されたボタンを取り消す関数
  void resetLastPressedButton() {
    setState(() {
      lastPressedButton = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size; // 画面サイズを得るための変数定義(size)
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110.0),
          child: AppBar(
            centerTitle: false,
            title: Text(
              '配送状況',
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
                        image: AssetImage('assets/logo.png'), // 画像のパス指定
                      )),
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: size.width, // 画面の幅を設定
                height: size.height * 0.4, // 画面の高さを設定
                color: getBackgroundColor(), // 混雑状況に基づいた背景色を設定
                child: Center(
                  child: Text(
                    '現在の状況: ${getCurrentStatus()}',
                    style: TextStyle(
                        fontSize: 44,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white), // テキストの色を白に設定
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15.0, bottom: 26.0),
                child: Text(
                  '今の配送状況をボタンを押して投票！',
                  style: TextStyle(
                      fontSize: 20, height: 3, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 均等に配置
                children: <Widget>[
                  _buildStatusButton('平常', Colors.lightGreen, () {
                    setState(() {
                      lastPressedButton = '平常';
                    });
                  }),
                  _buildStatusButton('~10分', Colors.lightBlue, () {
                    setState(() {
                      lastPressedButton = '~10分';
                    });
                  }),
                  _buildStatusButton('~30分', Colors.orangeAccent, () {
                    setState(() {
                      lastPressedButton = '~30分';
                    });
                  }),
                  _buildStatusButton('30分以上', Colors.redAccent, () {
                    setState(() {
                      lastPressedButton = '30分以上';
                    });
                  }),
                  _buildStatusButton('渋滞', Colors.purpleAccent, () {
                    setState(() {
                      lastPressedButton = '渋滞';
                    });
                  }),
                ],
              ),
              if (lastPressedButton != null)
                Container(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                    onPressed: resetLastPressedButton,
                    child: Text('取り消し'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusButton(String label, Color color, VoidCallback onPressed) {
    bool isButtonActive =
        lastPressedButton == null || lastPressedButton == label;
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 60, // ボタンの高さを設定
            child: ElevatedButton(
              onPressed: isButtonActive ? onPressed : null,
              child: Text(
                label,
                style: TextStyle(
                    fontSize: 14, // フォントサイズを調整
                    color: Colors.white, // テキストの色を白に設定
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isButtonActive ? color : Colors.grey, // ボタンの背景色を設定
                shape: CircleBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
