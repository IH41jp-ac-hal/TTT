import 'package:flutter/material.dart';
import 'package:trukkertrakker/src/app.dart';

void main() => runApp(MyApp());

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TruckerTrekker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
