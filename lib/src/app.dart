import 'package:flutter/material.dart';
import 'package:trukkertrakker/screens/HomePage.dart';
import 'package:trukkertrakker/screens/Reservation.dart';
import 'package:trukkertrakker/screens/Information.dart';
import 'package:trukkertrakker/user/Login.dart';
import 'package:trukkertrakker/user/Sign.dart';
import 'package:trukkertrakker/screens/account.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TruckerTrekker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
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
    ReservationScreen(),
    InformationScreen(),
    AccountScreen(),
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
      bottomNavigationBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        selectedItemColor: Color(0xFFf2e5bc),
        unselectedItemColor: Color(0xFFffffff),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.newspaper, size: 40),
              label: 'ホーム',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month, size: 40),
              label: '予約',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_shipping, size: 40),
              label: '配送状況',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, size: 40),
              label: 'アカウント',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFF84a2d4),
        ),
      ),
    );
  }
}
