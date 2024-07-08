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

class WarehouseLocation {
  final int id;
  final String location;

  WarehouseLocation({required this.id, required this.location});
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110.0),
        child: AppBar(
          centerTitle: false,
          title: Text(
            '予約',
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
  final List<WarehouseLocation> _warehouseLocations = [
    WarehouseLocation(id: 1, location: '東京港区倉庫'),
    WarehouseLocation(id: 2, location: '東京千代田区倉庫'),
    WarehouseLocation(id: 3, location: '東京中央区倉庫'),
    WarehouseLocation(id: 4, location: '東京江戸区倉庫'),
    WarehouseLocation(id: 5, location: '千葉船橋市倉庫'),
  ];
  WarehouseLocation? _selectedWarehouseLocation;

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

  //リマインダー仮
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("確認"),
            content: Text("この内容で予約を完了しますか？"),
            actions: <Widget>[
              TextButton(
                child: Text("いいえ"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text("はい"),
                onPressed: () {
                  final newReservation = Reservation(
                    name: _nameController.text,
                    phoneNumber: _phoneNumberController.text,
                    date: _dateController.text,
                    time: _timeController.text,
                    warehouseLocation: _selectedWarehouseLocation!.location,
                  );
                  widget.onSubmit(newReservation);
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReservationDetailsScreen(
                        reservation: newReservation,
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
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
                key: ValueKey('name'),
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
            key: ValueKey('phonenumber'),
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
                key: ValueKey('day'),
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
                key: ValueKey('time'),
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
              DropdownButtonFormField<WarehouseLocation>(
                decoration: InputDecoration(
                  labelText: '倉庫場所',
                ),
                items: _warehouseLocations.map((WarehouseLocation location) {
                  return DropdownMenuItem<WarehouseLocation>(
                    key: ValueKey('warehouse'),
                    value: location,
                    child: Text(location.location),
                  );
                }).toList(),
                onChanged: (WarehouseLocation? newValue) {
                  setState(() {
                    _selectedWarehouseLocation = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return '倉庫場所を選択してください';
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

//更新画面
class EditReservationScreen extends StatefulWidget {
  final Reservation reservation;

  EditReservationScreen({required this.reservation});

  @override
  _EditReservationScreenState createState() => _EditReservationScreenState();
}

class _EditReservationScreenState extends State<EditReservationScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _dateController;
  late TextEditingController _timeController;
  final List<WarehouseLocation> _warehouseLocations = [
    WarehouseLocation(id: 1, location: '東京港区倉庫'),
    WarehouseLocation(id: 2, location: '東京千代田区倉庫'),
    WarehouseLocation(id: 3, location: '東京中央区倉庫'),
    WarehouseLocation(id: 4, location: '東京江戸区倉庫'),
    WarehouseLocation(id: 5, location: '千葉船橋市倉庫'),
  ];
  WarehouseLocation? _selectedWarehouseLocation;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.reservation.name);
    _phoneNumberController =
        TextEditingController(text: widget.reservation.phoneNumber);
    _dateController = TextEditingController(text: widget.reservation.date);
    _timeController = TextEditingController(text: widget.reservation.time);
    _selectedWarehouseLocation = _warehouseLocations.firstWhere(
      (location) => location.location == widget.reservation.warehouseLocation,
      orElse: () => _warehouseLocations.first,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _dateController.dispose();
    _timeController.dispose();
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
      final editedReservation = Reservation(
        name: _nameController.text,
        phoneNumber: _phoneNumberController.text,
        date: _dateController.text,
        time: _timeController.text,
        warehouseLocation: _selectedWarehouseLocation?.location ?? '',
      );
      Navigator.of(context).pop(editedReservation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('予約を編集'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  key: ValueKey('name'),
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
                  key: ValueKey('phonenumber'),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    LengthLimitingTextInputFormatter(11)
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
                  key: ValueKey('day'),
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
                  key: ValueKey('time'),
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
                DropdownButtonFormField<WarehouseLocation>(
                  key: ValueKey('warehouse'),
                  value: _selectedWarehouseLocation,
                  items: _warehouseLocations.map((WarehouseLocation location) {
                    return DropdownMenuItem<WarehouseLocation>(
                      value: location,
                      child: Text(location.location),
                    );
                  }).toList(),
                  onChanged: (WarehouseLocation? newValue) {
                    setState(() {
                      _selectedWarehouseLocation = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return '倉庫場所を選択してください';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32.0),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: Text(
                      '更新',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//削除ボタン
class ListViewWidget extends StatefulWidget {
  final List<Reservation> reservations;

  ListViewWidget({required this.reservations});

  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  void _deleteReservation(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("削除"),
          content: Text("この予約を削除しますか？"),
          actions: <Widget>[
            TextButton(
              key: ValueKey('delete'),
              child: Text("キャンセル"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("削除"),
              onPressed: () {
                setState(() {
                  widget.reservations.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editReservation(int index) async {
    final editedReservation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditReservationScreen(
          reservation: widget.reservations[index],
        ),
      ),
    );

    if (editedReservation != null) {
      setState(() {
        widget.reservations[index] = editedReservation;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.reservations.length,
      itemBuilder: (context, index) {
        final reservation = widget.reservations[index];

        return ListTile(
          tileColor: Color.fromARGB(255, 173, 250, 237),
          title: Text(reservation.name),
          subtitle: Text('${reservation.date} ${reservation.time}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(reservation.warehouseLocation),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => _editReservation(index),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteReservation(index),
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
      separatorBuilder: (context, index) => Divider(),
    );
  }
}
