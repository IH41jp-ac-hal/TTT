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
  bool isButtonPressed = false; // ボタンが押されたかどうかのフラグ
  Map<String, int> buttonCounts = {
    '平常': 0,
    '~10分': 0,
    '~30分': 0,
    '30分以上': 0,
    '渋滞': 0,
  };

  @override
  void initState() {
    super.initState();
    _fetchButtonCounts();
  }

  Future<void> _fetchButtonCounts() async {
    int normalCount = await fbservice.getButtonCount('warehouseId', 'normal');
    int delay10Count =
        await fbservice.getButtonCount('warehouseId', 'delay_10');
    int delay30Count =
        await fbservice.getButtonCount('warehouseId', 'delay_30');
    int delayOver30Count =
        await fbservice.getButtonCount('warehouseId', 'delay_over30');
    int jamCount = await fbservice.getButtonCount('warehouseId', 'jam');

    setState(() {
      buttonCounts['平常'] = normalCount;
      buttonCounts['~10分'] = delay10Count;
      buttonCounts['~30分'] = delay30Count;
      buttonCounts['30分以上'] = delayOver30Count;
      buttonCounts['渋滞'] = jamCount;
    });
  }

  String getCurrentStatus() {
    String currentStatus = '平常';
    int maxCount = 0;

    buttonCounts.forEach((status, count) {
      if (count > maxCount) {
        maxCount = count;
        currentStatus = status;
      }
    });

    return currentStatus;
  }

  Color getBackgroundColor() {
    String currentStatus = getCurrentStatus();
    switch (currentStatus) {
      case '平常':
        return Color(0xFF7fff7f);
      case '~10分':
        return Color(0xFF7fbfff);
      case '~30分':
        return Color(0xFFffbf7f);
      case '30分以上':
        return Color(0xFFff7f7f);
      case '渋滞':
        return Color(0xFFbf7fff);
      default:
        return Colors.blueGrey;
    }
  }

  void resetLastPressedButton() {
    setState(() {
      lastPressedButton = null;
      isButtonPressed = false; // フラグをリセット
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: AppBar(
            title: Row(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/logo.png'), //画像
                    ),
                  ),
                ),
                Text(
                  '配送状況',
                  style: TextStyle(
                    fontSize: getAppBarFontSize(context), // フォントサイズ
                    color: Colors.white, // テキストカラー
                  ),
                ),
              ],
            ),
            backgroundColor: Color(0xFF84a2d4),
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
                    '現在の状況: ${getCurrentStatus()}',
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
                  _buildStatusButton('平常', Color(0xFF7fff7f), () async {
                    await fbservice.incrementButtonCount(
                        'warehouseId', 'normal');
                    setState(() {
                      lastPressedButton = '平常';
                      buttonCounts['平常'] = (buttonCounts['平常'] ?? 0) + 1;
                      isButtonPressed = true; // フラグをセット
                    });
                  }),
                  _buildStatusButton('~10分', Color(0xFF7fbfff), () async {
                    await fbservice.incrementButtonCount(
                        'warehouseId', 'delay_10');
                    setState(() {
                      lastPressedButton = '~10分';
                      buttonCounts['~10分'] = (buttonCounts['~10分'] ?? 0) + 1;
                      isButtonPressed = true; // フラグをセット
                    });
                  }),
                  _buildStatusButton('~30分', Color(0xFFffbf7f), () async {
                    await fbservice.incrementButtonCount(
                        'warehouseId', 'delay_30');
                    setState(() {
                      lastPressedButton = '~30分';
                      buttonCounts['~30分'] = (buttonCounts['~30分'] ?? 0) + 1;
                      isButtonPressed = true; // フラグをセット
                    });
                  }),
                  _buildStatusButton('30分以上', Color(0xFFff7f7f), () async {
                    await fbservice.incrementButtonCount(
                        'warehouseId', 'delay_over30');
                    setState(() {
                      lastPressedButton = '30分以上';
                      buttonCounts['30分以上'] = (buttonCounts['30分以上'] ?? 0) + 1;
                      isButtonPressed = true; // フラグをセット
                    });
                  }),
                  _buildStatusButton('渋滞', Color(0xFFbf7fff), () async {
                    await fbservice.incrementButtonCount('warehouseId', 'jam');
                    setState(() {
                      lastPressedButton = '渋滞';
                      buttonCounts['渋滞'] = (buttonCounts['渋滞'] ?? 0) + 1;
                      isButtonPressed = true; // フラグをセット
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusButton(String label, Color color, VoidCallback onPressed) {
    bool isButtonActive =
        (lastPressedButton == null || lastPressedButton == label) &&
            !isButtonPressed;
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
          SizedBox(height: 8),
          Text(
            '${buttonCounts[label] ?? 0} 回',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
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
