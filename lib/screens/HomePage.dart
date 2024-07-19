import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trukkertrakker/screens/Information.dart';
import 'package:trukkertrakker/screens/Reservation.dart';
import 'package:trukkertrakker/screens/account.dart';
import 'package:trukkertrakker/src/app.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePageScreen(),
    );
  }
}

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> valuesData = [
      '配送先#1',
      '配送先#2',
      '配送先#3',
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), // AppBairの高さをここで指定します
        child: AppBar(
          title: Row(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo.png'),
                  ),
                ),
              ),
              Text(
                'トラトレ',
                style: TextStyle(
                  fontSize: getAppBarFontSize(context),
                  color: Colors.white,
                ),
              ),
            ],
          ),
          backgroundColor: Color(0xFF84a2d4),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFFe6e6e6),
      body: CardSlider(
        cards: valuesData,
        bottomOffset: .0005,
        cardHeight: 0.75,
        itemDotOffset: 0.25,
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
    if (screenWidth < 400) {
      return 20.0; // Small screen width
    } else if (screenWidth < 800) {
      return 24.0; // Medium screen width
    } else {
      return 28.0; // Large screen width
    }
  }
}

class CardSlider extends StatefulWidget {
  final List<String> cards;
  final double bottomOffset;
  final double cardHeight;
  final double itemDotOffset;

  const CardSlider({
    Key? key,
    required this.cards,
    required this.bottomOffset,
    required this.cardHeight,
    required this.itemDotOffset,
  }) : super(key: key);

  @override
  _CardSliderState createState() => _CardSliderState();
}

class _CardSliderState extends State<CardSlider> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    _timer = Timer.periodic(Duration(seconds: 4), (Timer timer) {
      if (_currentPage < widget.cards.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.cards.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(36.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color(0xFFffffff),
            ),
            child: Center(
              child: Text(
                widget.cards[index],
                style: TextStyle(fontSize: 28, color: Color(0xFF333333)),
              ),
            ),
          ),
        );
      },
    );
  }
}
