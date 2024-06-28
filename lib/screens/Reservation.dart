import 'package:flutter/material.dart';
import 'package:trukkertrakker/src/app.dart';

void main() => runApp(MyApp());

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  bool _isReservationSelected = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TruckerTrekker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('予約'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isReservationSelected = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _isReservationSelected ? Colors.blue : Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: Colors.blue),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                      child: Text(
                        '予約',
                        style: TextStyle(
                          color: _isReservationSelected ? Colors.white : Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isReservationSelected = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: !_isReservationSelected ? Colors.blue : Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: Colors.blue),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                      child: Text(
                        '予約一覧',
                        style: TextStyle(
                          color: !_isReservationSelected ? Colors.white : Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _isReservationSelected ? ReservationView() : ListViewWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class ReservationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('予約画面'),
    );
  }
}

class ListViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('予約一覧画面'),
    );
  }
}
// test