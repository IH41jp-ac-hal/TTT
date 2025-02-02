import 'package:flutter/material.dart';
import 'package:trukkertrakker/screens/HomePage.dart';
import 'package:trukkertrakker/screens/Browse.dart';
import 'package:trukkertrakker/screens/Information.dart';
import 'package:trukkertrakker/screens/Library.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TruckerTrekker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  static const _screens = [
    HomePageScreen(),
    BrowseScreen(),
    InformationScreen(),
    LibraryScreen(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'トップ'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: '予約'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_shipping), label: '配送状況'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Library'),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
