import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trukkertrakker/src/app.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TruckerTrekker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReservationScreen(),
    );
  }
}

class Reservation {
  final String name;
  final String phoneNumber;
  final String date;
  final String time;
  final String warehouseLocation;

  Reservation({
    required this.name,
    required this.phoneNumber,
    required this.date,
    required this.time,
    required this.warehouseLocation,
  });
}

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  bool _isReservationSelected = true;
  final List<Reservation> _reservations = [];

  void _addReservation(Reservation reservation) {
    setState(() {
      _reservations.add(reservation);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      color:
                          _isReservationSelected ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: Colors.blue),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    child: Text(
                      '予約',
                      style: TextStyle(
                        color:
                            _isReservationSelected ? Colors.white : Colors.blue,
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
                      color:
                          !_isReservationSelected ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: Colors.blue),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    child: Text(
                      '予約一覧',
                      style: TextStyle(
                        color: !_isReservationSelected
                            ? Colors.white
                            : Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _isReservationSelected
                ? ReservationView(onSubmit: _addReservation)
                : ListViewWidget(reservations: _reservations),
          ),
        ],
      ),
    );
  }
}

class ReservationView extends StatefulWidget {
  final Function(Reservation) onSubmit;

  ReservationView({required this.onSubmit});

  @override
  _ReservationViewState createState() => _ReservationViewState();
}

class _ReservationViewState extends State<ReservationView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _warehouseLocationController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _warehouseLocationController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _timeController.text = picked.format(context);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newReservation = Reservation(
        name: _nameController.text,
        phoneNumber: _phoneNumberController.text,
        date: _dateController.text,
        time: _timeController.text,
        warehouseLocation: _warehouseLocationController.text,
      );
      widget.onSubmit(newReservation);
      _formKey.currentState!.reset();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReservationDetailsScreen(
            reservation: newReservation,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'お名前',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'お名前を入力してください';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                keyboardType: TextInputType.phone, // 数字キーボードを指定
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')), //数字のみ入力
                  LengthLimitingTextInputFormatter(11) //11文字
                ],
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: '電話番号',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '電話番号を入力してください';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: '日付',
                ),
                readOnly: true,
                onTap: () {
                  _selectDate(context);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '日付を入力してください';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: '時刻',
                ),
                readOnly: true,
                onTap: () {
                  _selectTime(context);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '時刻を入力してください';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _warehouseLocationController,
                decoration: InputDecoration(
                  labelText: '倉庫場所',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '倉庫場所を入力してください';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32.0),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(
                    '送信',
                    style: TextStyle(
                      color: Colors.white, // テキストの色を白に設定
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.black), // ボタンの背景色を設定
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0), // 角丸の半径を指定
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReservationDetailsScreen extends StatelessWidget {
  final Reservation reservation;

  ReservationDetailsScreen({required this.reservation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('予約詳細'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'お名前: ${reservation.name}',
              style: TextStyle(fontSize: 22.0), // 文字の大きさを22に設定
            ),
            SizedBox(height: 8.0),
            Text(
              '電話番号: ${reservation.phoneNumber}',
              style: TextStyle(fontSize: 22.0), // 文字の大きさを22に設定
            ),
            SizedBox(height: 8.0),
            Text(
              '日付: ${reservation.date}',
              style: TextStyle(fontSize: 22.0), // 文字の大きさを22に設定
            ),
            SizedBox(height: 8.0),
            Text(
              '時刻: ${reservation.time}',
              style: TextStyle(fontSize: 22.0), // 文字の大きさを22に設定
            ),
            SizedBox(height: 8.0),
            Text(
              '倉庫場所: ${reservation.warehouseLocation}',
              style: TextStyle(fontSize: 20.0), // 文字の大きさを20に設定
            ),
          ],
        ),
      ),
    );
  }
}


class ListViewWidget extends StatelessWidget {
  final List<Reservation> reservations;

  ListViewWidget({required this.reservations});

  void _deleteReservation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("削除"),
          content: Text("この予約を削除しますか？"),
          actions: <Widget>[
            TextButton(
              child: Text("キャンセル"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("削除"),
              onPressed: () {
                Navigator.of(context).pop();
                // Remove reservation from the list
                _removeReservation(context, index);
              },
            ),
          ],
        );
      },
    );
  }

  void _removeReservation(BuildContext context, int index) {
    // Get the state of ReservationScreen
    final _reservationScreenState =
        context.findAncestorStateOfType<_ReservationScreenState>();

    // Remove reservation only if the state is retrieved successfully
    if (_reservationScreenState != null) {
      _reservationScreenState.setState(() {
        reservations.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true, // ここに追加する
      itemCount: reservations.length,
      itemBuilder: (context, index) {
        final reservation = reservations[index];
        
        //予約一覧の見出し
        return ListTile(
          //背景色
          tileColor: Color.fromARGB(255, 173, 250, 237),
          title: Text(reservation.name),
          subtitle: Text('${reservation.date} ${reservation.time}'),
          //削除ボタン
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(reservation.warehouseLocation),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () =>
                    _deleteReservation(context, index), // Call delete function
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReservationDetailsScreen(
                  reservation: reservation,
                ),
              ),
            );
          },
        );
      },
      separatorBuilder: (context, index) => Divider(), // ここで区切り線を追加する
    );
  }
}
