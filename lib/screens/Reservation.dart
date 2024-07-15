import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TruckerTrekker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ReservationScreen(),
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110.0),
        child: AppBar(
          centerTitle: false,
          title: const Text(
            '予約',
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
                        const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    child: Text(
                      '予約',
                      style: TextStyle(
                        color:
                            _isReservationSelected ? Colors.white : Colors.blue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
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
                        const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
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

  const ReservationView({super.key, required this.onSubmit});

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
  final List<String> _warehouseLocations = [
    '東京港区倉庫',
    '東京千代田区倉庫',
    '東京中央区倉庫',
    '東京江戸区倉庫',
    '千葉船橋市倉庫'
  ];
  String? _selectedWarehouseLocation;

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
            title: const Text("確認"),
            content: const Text("この内容で予約を完了しますか？"),
            actions: <Widget>[
              TextButton(
                child: const Text("いいえ"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              //はいを押すと登録内容表示
              TextButton(
                child: const Text("はい"),
                onPressed: () {
                  final newReservation = Reservation(
                    name: _nameController.text,
                    phoneNumber: _phoneNumberController.text,
                    date: _dateController.text,
                    time: _timeController.text,
                    warehouseLocation: _selectedWarehouseLocation!,
                  );
                  widget.onSubmit(newReservation);
                  Navigator.of(context).pop(); // ダイアログを閉じる
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
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'お名前',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'お名前を入力してください';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                keyboardType: TextInputType.phone, // 数字キーボードを指定
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')), //数字のみ入力
                  LengthLimitingTextInputFormatter(11) //11文字
                ],
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  labelText: '電話番号',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '電話番号を入力してください';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
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
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _timeController,
                decoration: const InputDecoration(
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
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _selectedWarehouseLocation,
                decoration: const InputDecoration(
                  labelText: '倉庫場所',
                ),
                items: _warehouseLocations
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedWarehouseLocation = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '倉庫場所を選択してください';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32.0),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.black), // ボタンの背景色を設定
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0), // 角丸の半径を指定
                      ),
                    ),
                  ),
                  child: const Text(
                    '送信',
                    style: TextStyle(
                      color: Colors.white, // テキストの色を白に設定
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

  const ReservationDetailsScreen({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('予約詳細'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'お名前: ${reservation.name}',
              style: const TextStyle(fontSize: 22.0), // 文字の大きさを22に設定
            ),
            const SizedBox(height: 8.0),
            Text(
              '電話番号: ${reservation.phoneNumber}',
              style: const TextStyle(fontSize: 22.0), // 文字の大きさを22に設定
            ),
            const SizedBox(height: 8.0),
            Text(
              '日付: ${reservation.date}',
              style: const TextStyle(fontSize: 22.0), // 文字の大きさを22に設定
            ),
            const SizedBox(height: 8.0),
            Text(
              '時刻: ${reservation.time}',
              style: const TextStyle(fontSize: 22.0), // 文字の大きさを22に設定
            ),
            const SizedBox(height: 8.0),
            Text(
              '倉庫場所: ${reservation.warehouseLocation}',
              style: const TextStyle(fontSize: 20.0), // 文字の大きさを20に設定
            ),
          ],
        ),
      ),
    );
  }
}

class EditReservationScreen extends StatefulWidget {
  final Reservation reservation;

  const EditReservationScreen({super.key, required this.reservation});

  @override
  _EditReservationScreenState createState() => _EditReservationScreenState();
}

class EditReservationScreens extends StatefulWidget {
  final Reservation reservation;

  const EditReservationScreens({super.key, required this.reservation});

  @override
  _EditReservationScreenState createState() => _EditReservationScreenState();
}

class _EditReservationScreenState extends State<EditReservationScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _dateController;
  late TextEditingController _timeController;
  final List<String> _warehouseLocations = [
    '東京港区倉庫',
    '東京千代田区倉庫',
    '東京中央区倉庫',
    '東京江戸区倉庫',
    '千葉船橋市倉庫'
  ];
  String? _selectedWarehouseLocation;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.reservation.name);
    _phoneNumberController =
        TextEditingController(text: widget.reservation.phoneNumber);
    _dateController = TextEditingController(text: widget.reservation.date);
    _timeController = TextEditingController(text: widget.reservation.time);
    _selectedWarehouseLocation = widget.reservation.warehouseLocation;
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
        warehouseLocation: _selectedWarehouseLocation!,
      );
      Navigator.of(context).pop(editedReservation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('予約を編集'),
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
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'お名前',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'お名前を入力してください';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    LengthLimitingTextInputFormatter(11)
                  ],
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(
                    labelText: '電話番号',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '電話番号を入力してください';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _dateController,
                  decoration: const InputDecoration(
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
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _timeController,
                  decoration: const InputDecoration(
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
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: _selectedWarehouseLocation,
                  decoration: const InputDecoration(
                    labelText: '倉庫場所',
                  ),
                  items: _warehouseLocations
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedWarehouseLocation = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '倉庫場所を選択してください';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32.0),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      '更新',
                      style: TextStyle(
                        color: Colors.white,
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
class ListViewWidget extends StatelessWidget {
  final List<Reservation> reservations;

  const ListViewWidget({super.key, required this.reservations});

  void _deleteReservation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("削除"),
          content: const Text("この予約を削除しますか？"),
          actions: <Widget>[
            TextButton(
              child: const Text("キャンセル"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("削除"),
              onPressed: () {
                _removeReservation(context, index);
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _removeReservation(BuildContext context, int index) {
    // Ensure the context used to find _ReservationScreenState is correct
    final reservationScreenState =
        context.findAncestorStateOfType<_ReservationScreenState>();

    if (reservationScreenState != null) {
      reservationScreenState.setState(() {
        reservations.removeAt(index); // Remove the reservation from the list
      });
    }
  }

  void _editReservation(BuildContext context, int index) async {
    final editedReservation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditReservationScreen(
          reservation: reservations[index],
        ),
      ),
    );

    if (editedReservation != null) {
      final reservationScreenState =
          context.findAncestorStateOfType<_ReservationScreenState>();

      if (reservationScreenState != null) {
        reservationScreenState.setState(() {
          reservations[index] =
              editedReservation; // Update the edited reservation
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: reservations.length,
      itemBuilder: (context, index) {
        final reservation = reservations[index];

        return ListTile(
          tileColor: const Color.fromARGB(255, 173, 250, 237),
          title: Text(reservation.name),
          subtitle: Text('${reservation.date} ${reservation.time}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(reservation.warehouseLocation),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _editReservation(context, index),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () =>
                    _deleteReservation(context, index), // Call delete method
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
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
