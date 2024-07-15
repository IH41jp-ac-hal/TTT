import 'package:flutter/material.dart';
import 'package:trukkertrakker/screens/firebase_service.dart';
import 'package:trukkertrakker/src/app.dart';

void main() => runApp(MyApp());

FirebaseService fbservice = FirebaseService();

class InformationScreen extends StatefulWidget {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  String? lastPressedButton;
  String? warehouseLocation;
  String currentStatus = '平常';
  Map<String, dynamic> statusCounts = {};

  @override
  void initState() {
    super.initState();
    getWarehouseLocationAndStatus();
  }

  Future<void> getWarehouseLocationAndStatus() async {
    String reservationId = '8b4XbiziuzCvRbcSmrM7'; // 実際の予約IDに置き換え
    String? location = await fbservice.getWarehouseLocation(reservationId);
    if (location != null) {
      setState(() {
        warehouseLocation = location;
      });

      // warehouseLocationに基づいて混雑状況を取得し、currentStatusを更新
      fbservice.getStatusUpdates(location).listen((snapshot) {
        if (snapshot.exists) {
          final data = snapshot.data() as Map<String, dynamic>;
          setState(() {
            currentStatus = data['currentStatus'] ?? '平常';
            statusCounts = data['statusCounts'] ?? {};
          });
        }
      });
    }
  }

  Color getBackgroundColor() {
    switch (currentStatus) {
      case '平常':
        return Colors.lightGreen;
      case '~10分':
        return Colors.lightBlue;
      case '~30分':
        return Colors.orangeAccent;
      case '30分以上':
        return Colors.redAccent;
      case '渋滞':
        return Colors.purpleAccent;
      default:
        return Colors.blueGrey;
    }
  }

  void resetLastPressedButton() {
    setState(() {
      lastPressedButton = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
                        image: AssetImage('assets/logo.png'),
                      )),
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.4,
                color: getBackgroundColor(),
                child: Center(
                  child: Text(
                    '現在の状況: $currentStatus',
                    style: TextStyle(
                        fontSize: 44,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15.0, bottom: 26.0),
                child: Text(
                  '今の配送状況をボタンを押して投票！',
                  style: TextStyle(
                      fontSize: 20, height: 3, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildStatusButton('平常', Colors.lightGreen, () async {
                    if (warehouseLocation != null) {
                      await fbservice.incrementButtonCount(
                          warehouseLocation!, '平常');
                      setState(() {
                        lastPressedButton = '平常';
                      });
                    } else {
                      // warehouseLocationがnullの場合の処理（エラーメッセージを表示するなど）
                      print('Warehouse location is not set.');
                    }
                  }),
                  _buildStatusButton('~10分', Colors.lightBlue, () {
                    setState(() {
                      lastPressedButton = '~10分';
                    });
                  }),
                  _buildStatusButton('~30分', Colors.orangeAccent, () {
                    setState(() {
                      lastPressedButton = '~30分';
                    });
                  }),
                  _buildStatusButton('30分以上', Colors.redAccent, () {
                    setState(() {
                      lastPressedButton = '30分以上';
                    });
                  }),
                  _buildStatusButton('渋滞', Colors.purpleAccent, () {
                    setState(() {
                      lastPressedButton = '渋滞';
                    });
                  }),
                ],
              ),
              if (lastPressedButton != null)
                Container(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                    onPressed: resetLastPressedButton,
                    child: Text('取り消し'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: statusCounts.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        '${entry.key}: ${entry.value}',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusButton(String label, Color color, VoidCallback onPressed) {
    bool isButtonActive =
        lastPressedButton == null || lastPressedButton == label;
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 60,
            child: ElevatedButton(
              onPressed: isButtonActive ? onPressed : null,
              child: Text(
                label,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: isButtonActive ? color : Colors.grey,
                shape: CircleBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
