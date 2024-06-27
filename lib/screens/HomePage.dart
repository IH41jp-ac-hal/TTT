import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trukkertrakker/src/app.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePageScreen(),
    );
  }
}

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> valuesData = [
      'hogehoegさん走行中。現在の走行状態を確認できる',
      '平野さぼり',
      '平野　樹',
    ];

    return Scaffold(
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
                    image: AssetImage('assets/logo.png'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: CardSlider(
        cards: valuesData,
        bottomOffset: .0005,
        cardHeight: 0.75,
        itemDotOffset: 0.25,
      ),
      //body
    );
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

    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < widget.cards.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
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
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 300, // Adjust width as necessary
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.blueAccent,
            ),
            child: Center(
              child: Text(
                widget.cards[index],
                style: TextStyle(fontSize: 28, color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}