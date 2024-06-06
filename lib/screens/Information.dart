import 'package:flutter/material.dart';
import 'package:trukkertrakker/src/app.dart';

void main() => runApp(MyApp());

class InformationScreen extends StatelessWidget {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        body: Container(
          width: MediaQuery.of(context).size.width, // 画面の幅を設定
          height: MediaQuery.of(context).size.height * 0.4, // 画面の高さを設定
          color: Color.fromARGB(255, 201, 246, 0),
          child: Text(
            '混雑状況',
            style:
                TextStyle(fontSize: 44, height: 4, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
