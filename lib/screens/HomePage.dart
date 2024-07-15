import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trukkertrakker/screens/Information.dart';
import 'package:trukkertrakker/screens/Reservation.dart';
import 'package:trukkertrakker/screens/account.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePageScreen(),
    );
  }
}

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> valuesData = [
      '予約画面',
      '配送状況',
      'アカウント情報',
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110.0),
        child: AppBar(
          centerTitle: false,
          title: const Text(
            'TruckTrakker 仮メインページ',
            style: TextStyle(fontSize: 19, height: 4),
          ),
          backgroundColor: const Color.fromARGB(255, 9, 142, 163),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 15.0, top: 23.0),
              child: Container(
                width: 114,
                decoration: const BoxDecoration(
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

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < widget.cards.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
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
          child: GestureDetector(
            onTap: () {
              if (widget.cards[index] == '配送状況') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InformationScreen()),
                );
              } else if (widget.cards[index] == '予約画面') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReservationScreen()),
                );
              } else if (widget.cards[index] == 'アカウント情報') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AccountScreen()));
              }
            },
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.blueAccent,
              ),
              child: Center(
                child: Text(
                  widget.cards[index],
                  style: const TextStyle(fontSize: 28, color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
