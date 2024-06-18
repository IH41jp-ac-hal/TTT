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
        body: Column(
          children: [
            Container(
              width: size.width, // 画面の幅を設定
              height: size.height * 0.4, // 画面の高さを設定
              color: Colors.blueGrey,
              // 混雑状況を最大のカウントに基づいて表示
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
              padding: const EdgeInsets.only(top: 23.0, bottom: 30.0),
              child: Text(
                '今の配送状況をボタンを押して投票！',
                style: TextStyle(
                    fontSize: 22, height: 4, fontWeight: FontWeight.bold),
              ),
            ),
<<<<<<< HEAD
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 均等に配置
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 60, // ボタンの高さを設定
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              normalCount++;
                            });
                          },
                          child: Text(
                            '平常',
                            style: TextStyle(
                                fontSize: 14, // フォントサイズを調整
                                color: Colors.white, // テキストの色を白に設定
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreen, // ボタンの背景色を赤に設定
                            shape: CircleBorder(),
                          ),
=======
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 均等に配置
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 60, // ボタンの高さを設定
                      child: ElevatedButton(
                        onPressed: () {
                          // ボタン1が押された時の処理
                        },
                        child: Text(
                          '平常',
                          style: TextStyle(
                              fontSize: 15, // フォントサイズを調整
                              color: Colors.white, // テキストの色を白に設定
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen, // ボタンの背景色を赤に設定
                          shape: CircleBorder(),
>>>>>>> 0355153d1f45f64c9d2cef23f414f8760d343fec
                        ),
                      ),
                      Text('$normalCount'), // 押された回数を表示
                    ],
                  ),
<<<<<<< HEAD
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 60, // ボタンの高さを設定
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              tenMinutesCount++;
                            });
                          },
                          child: Text(
                            '~10分',
                            style: TextStyle(
                                fontSize: 14, // フォントサイズを調整
                                color: Colors.white, // テキストの色を白に設定
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue, // ボタンの背景色を赤に設定
                            shape: CircleBorder(),
                          ),
=======
                  Expanded(
                    child: Container(
                      height: 60, // ボタンの高さを設定
                      child: ElevatedButton(
                        onPressed: () {
                          // ボタン2が押された時の処理
                        },
                        child: Text(
                          '~10分',
                          style: TextStyle(
                              fontSize: 15, // フォントサイズを調整
                              color: Colors.white, // テキストの色を白に設定
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue, // ボタンの背景色を赤に設定
                          shape: CircleBorder(),
>>>>>>> 0355153d1f45f64c9d2cef23f414f8760d343fec
                        ),
                      ),
                      Text('$tenMinutesCount'), // 押された回数を表示
                    ],
                  ),
<<<<<<< HEAD
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 60, // ボタンの高さを設定
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              thirtyMinutesCount++;
                            });
                          },
                          child: Text(
                            '~30分',
                            style: TextStyle(
                                fontSize: 14, // フォントサイズを調整
                                color: Colors.white, // テキストの色を白に設定
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.orangeAccent, // ボタンの背景色を赤に設定
                            shape: CircleBorder(),
                          ),
=======
                  Expanded(
                    child: Container(
                      height: 60, // ボタンの高さを設定
                      child: ElevatedButton(
                        onPressed: () {
                          // ボタン3が押された時の処理
                        },
                        child: Text(
                          '~30分',
                          style: TextStyle(
                              fontSize: 15, // フォントサイズを調整
                              color: Colors.white, // テキストの色を白に設定
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent, // ボタンの背景色を赤に設定
                          shape: CircleBorder(),
>>>>>>> 0355153d1f45f64c9d2cef23f414f8760d343fec
                        ),
                      ),
                      Text('$thirtyMinutesCount'), // 押された回数を表示
                    ],
                  ),
<<<<<<< HEAD
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 60, // ボタンの高さを設定
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              moreThanThirtyCount++;
                            });
                          },
                          child: Text(
                            '30分以上',
                            style: TextStyle(
                                fontSize: 14, // フォントサイズを調整
                                color: Colors.white, // テキストの色を白に設定
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent, // ボタンの背景色を赤に設定
                            shape: CircleBorder(),
                          ),
=======
                  Expanded(
                    child: Container(
                      height: 60, // ボタンの高さを設定
                      child: ElevatedButton(
                        onPressed: () {
                          // ボタン4が押された時の処理
                        },
                        child: Text(
                          '30分以上',
                          style: TextStyle(
                              fontSize: 15, // フォントサイズを調整
                              color: Colors.white, // テキストの色を白に設定
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent, // ボタンの背景色を赤に設定
                          shape: CircleBorder(),
>>>>>>> 0355153d1f45f64c9d2cef23f414f8760d343fec
                        ),
                      ),
                      Text('$moreThanThirtyCount'), // 押された回数を表示
                    ],
                  ),
<<<<<<< HEAD
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 60, // ボタンの高さを設定
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              trafficJamCount++;
                            });
                          },
                          child: Text(
                            '渋滞',
                            style: TextStyle(
                                fontSize: 14, // フォントサイズを調整
                                color: Colors.white, // テキストの色を白に設定
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.purpleAccent, // ボタンの背景色を赤に設定
                            shape: CircleBorder(),
                          ),
=======
                  Expanded(
                    child: Container(
                      height: 60, // ボタンの高さを設定
                      child: ElevatedButton(
                        onPressed: () {
                          // ボタン5が押された時の処理
                        },
                        child: Text(
                          '渋滞',
                          style: TextStyle(
                              fontSize: 15, // フォントサイズを調整
                              color: Colors.white, // テキストの色を白に設定
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent, // ボタンの背景色を赤に設定
                          shape: CircleBorder(),
>>>>>>> 0355153d1f45f64c9d2cef23f414f8760d343fec
                        ),
                      ),
                      Text('$trafficJamCount'), // 押された回数を表示
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
