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
        preferredSize: const Size.fromHeight(115.0),
        child: AppBar(
          centerTitle: false,
          title: Text(
            'TruckTrakker 仮メインページ',
            style: TextStyle(fontSize: 21, height: 4),
          ),
        ),
      ),
    ));
  }
}
