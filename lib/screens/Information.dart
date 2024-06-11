import 'package:flutter/material.dart';
import 'package:trukkertrakker/src/app.dart';

void main() => runApp(MyApp());

class InformationScreen extends StatelessWidget {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size; //画面サイズを得るための変数定義(size)
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
                        image: AssetImage('assets/logo.png'), //画像のパス指定
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
              color: Color.fromARGB(255, 201, 246, 0),
              child: Text(
                '混雑状況',
                style: TextStyle(
                    fontSize: 44, height: 4, fontWeight: FontWeight.bold),
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
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 均等に配置
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 75, // ボタンの高さを設定
                      child: ElevatedButton(
                        onPressed: () {
                          // ボタン1が押された時の処理
                        },
                        child: Text(
                          '平常',
                          style: TextStyle(
                            fontSize: 14, // フォントサイズを調整
                            color: Colors.white, // テキストの色を白に設定
                          ),
                          textAlign: TextAlign.center,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 75, // ボタンの高さを設定
                      child: ElevatedButton(
                        onPressed: () {
                          // ボタン1が押された時の処理
                        },
                        child: Text(
                          '~10分',
                          style: TextStyle(
                            fontSize: 14, // フォントサイズを調整
                            color: Colors.white, // テキストの色を白に設定
                          ),
                          textAlign: TextAlign.center,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 75, // ボタンの高さを設定
                      child: ElevatedButton(
                        onPressed: () {
                          // ボタン1が押された時の処理
                        },
                        child: Text(
                          '10~30分',
                          style: TextStyle(
                            fontSize: 14, // フォントサイズを調整
                            color: Colors.white, // テキストの色を白に設定
                          ),
                          textAlign: TextAlign.center,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 75, // ボタンの高さを設定
                      child: ElevatedButton(
                        onPressed: () {
                          // ボタン1が押された時の処理
                        },
                        child: Text(
                          '30分以上',
                          style: TextStyle(
                            fontSize: 14, // フォントサイズを調整
                            color: Colors.white, // テキストの色を白に設定
                          ),
                          textAlign: TextAlign.center,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 75, // ボタンの高さを設定
                      child: ElevatedButton(
                        onPressed: () {
                          // ボタン1が押された時の処理
                        },
                        child: Text(
                          '激込み',
                          style: TextStyle(
                            fontSize: 14, // フォントサイズを調整
                            color: Colors.white, // テキストの色を白に設定
                          ),
                          textAlign: TextAlign.center,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
