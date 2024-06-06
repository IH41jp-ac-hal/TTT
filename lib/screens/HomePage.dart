import 'package:flutter/material.dart';
import 'package:trukkertrakker/src/app.dart';

void main() => runApp(MyApp());

 class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110.0),
        child: AppBar(
          centerTitle: false,
          title: Text(
            'TruckTrakker 仮メインページ',
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
                    image: AssetImage('assets/logo.png'), // 画像のパスを指定
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      //body
    ));
  }
}
 