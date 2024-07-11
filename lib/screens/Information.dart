import 'package:flutter/material.dart';
import 'package:trukkertrakker/src/app.dart';

void main() => runApp(MyApp());

class InformationScreen extends StatefulWidget {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  // 各ボタンの押下回数を記録する変数
  int normalCount = 0;
  int tenMinutesCount = 0;
  int thirtyMinutesCount = 0;
  int moreThanThirtyCount = 0;
  int trafficJamCount = 0;

  // 現在の混雑状況を取得する関数
  String getCurrentStatus() {
    Map<String, int> countMap = {
      '平常': normalCount,
      '~10分': tenMinutesCount,
      '~30分': thirtyMinutesCount,
      '30分以上': moreThanThirtyCount,
      '渋滞': trafficJamCount,
    };

    // 初期状態では「平常」を返す
    if (countMap.values.every((count) => count == 0)) {
      return '平常';
    }

    // カウントが最も多いキー（状況）を探す
    String highestStatus =
        countMap.entries.reduce((a, b) => a.value > b.value ? a : b).key;
    return highestStatus;
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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size; // 画面サイズを得るための変数定義(size)
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(getAppBarHeight(context)),
          child: AppBar(
            centerTitle: false,
            title: Text(
              '配送状況',
              style: TextStyle(
                fontSize: getAppBarFontSize(context),
                height: 1.2,
                color: Colors.white,
              ),
            ),
            backgroundColor: Color(0xFFFFD800),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 15.0, top: MediaQuery.of(context).size.height * 0.03),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.2,
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
                      fontSize: getContainerFontSize(context),
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // テキストの色を白に設定
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15.0, bottom: 26.0),
                child: Text(
                  '今の配送状況をボタンを押して投票！',
                  style: TextStyle(
                    fontSize: 20,
                    height: 3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 均等に配置
                children: <Widget>[
                  _buildStatusButton('平常', Colors.lightGreen, normalCount, () {
                    setState(() {
                      normalCount++;
                    });
                  }),
                  _buildStatusButton('~10分', Colors.lightBlue, tenMinutesCount,
                      () {
                    setState(() {
                      tenMinutesCount++;
                    });
                  }),
                  _buildStatusButton(
                      '~30分', Colors.orangeAccent, thirtyMinutesCount, () {
                    setState(() {
                      thirtyMinutesCount++;
                    });
                  }),
                  _buildStatusButton(
                      '30分以上', Colors.redAccent, moreThanThirtyCount, () {
                    setState(() {
                      moreThanThirtyCount++;
                    });
                  }),
                  _buildStatusButton('渋滞', Colors.purpleAccent, trafficJamCount,
                      () {
                    setState(() {
                      trafficJamCount++;
                    });
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusButton(
      String label, Color color, int count, VoidCallback onPressed) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: getButtonHeight(context), // ボタンの高さを動的に設定
            child: ElevatedButton(
              onPressed: onPressed,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: getButtonFontSize(context), // フォントサイズを調整
                  color: Colors.white, // テキストの色を白に設定
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: color, // ボタンの背景色を設定
                shape: CircleBorder(),
              ),
            ),
          ),
          SizedBox(height: 8), // テキストとボタンの間にスペースを追加
          Text('$count'), // 押された回数を表示
        ],
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
    if (screenWidth < 600) {
      return 20.0; // Small screen width
    } else if (screenWidth < 900) {
      return 24.0; // Medium screen width
    } else {
      return 28.0; // Large screen width
    }
  }

  double getContainerFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return 28.0; // Small screen width
    } else if (screenWidth < 900) {
      return 36.0; // Medium screen width
    } else {
      return 44.0; // Large screen width
    }
  }

  double getButtonHeight(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return 40.0; // Small screen width
    } else if (screenWidth < 900) {
      return 50.0; // Medium screen width
    } else {
      return 60.0; // Large screen width
    }
  }

  double getButtonFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return 10.0; // Small screen width
    } else if (screenWidth < 900) {
      return 12.0; // Medium screen width
    } else {
      return 14.0; // Large screen width
    }
  }
}
