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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(getAppBarHeight(context)),
        child: AppBar(
          centerTitle: false,
          title: Text(
            '予約',
            style: TextStyle(
              fontSize: getAppBarFontSize(context),
              height: 2,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xFFFFD800),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 15.0, top: MediaQuery.of(context).size.height * 0.03),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.2,
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
            padding: EdgeInsets.all(16.0),
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
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 50.0),
                    child: Text(
                      '予約受付',
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
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 50.0),
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
                    warehouseLocation: _selectedWarehouseLocation!,
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
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'お名前'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'お名前を入力してください';
                  }
                  return null;
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: '電話番号'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '電話番号を入力してください';
                  }
                  return null;
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: '日付',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '日付を入力してください';
                  }
                  return null;
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: '時刻',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () => _selectTime(context),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '時刻を入力してください';
                  }
                  return null;
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              DropdownButtonFormField<String>(
                value: _selectedWarehouseLocation,
                hint: Text('倉庫場所を選択'),
                onChanged: (newValue) {
                  setState(() {
                    _selectedWarehouseLocation = newValue;
                  });
                },
                items: _warehouseLocations.map((location) {
                  return DropdownMenuItem(
                    child: Text(location),
                    value: location,
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '倉庫場所を選択してください';
                  }
                  return null;
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.25,
                      vertical: getButtonHeight(context) * 0.5,
                    ),
                  ),
                  child: Text(
                    '予約する',
                    style: TextStyle(fontSize: getButtonFontSize(context) * 2, color: Colors.white),
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
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'お名前: ${reservation.name}',
              style: TextStyle(fontSize: getContainerFontSize(context)),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              '電話番号: ${reservation.phoneNumber}',
              style: TextStyle(fontSize: getContainerFontSize(context)),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              '日付: ${reservation.date}',
              style: TextStyle(fontSize: getContainerFontSize(context)),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              '時刻: ${reservation.time}',
              style: TextStyle(fontSize: getContainerFontSize(context)),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              '倉庫場所: ${reservation.warehouseLocation}',
              style: TextStyle(fontSize: getContainerFontSize(context)),
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reservations.length,
      itemBuilder: (context, index) {
        final reservation = reservations[index];
        return Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Card(
            elevation: 5,
            child: ListTile(
              title: Text(
                reservation.name,
                style: TextStyle(fontSize: getContainerFontSize(context)),
              ),
              subtitle: Text(
                '${reservation.date} ${reservation.time} - ${reservation.warehouseLocation}',
                style: TextStyle(fontSize: getContainerFontSize(context)),
              ),
            ),
          ),
        );
      },
    );
  }
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

  double getContainerFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 400) {
      return 28.0; // Small screen width
    } else if (screenWidth < 800) {
      return 36.0; // Medium screen width
    } else {
      return 44.0; // Large screen width
    }
  }

  double getButtonHeight(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 400) {
      return 40.0; // Small screen width
    } else if (screenWidth < 800) {
      return 50.0; // Medium screen width
    } else {
      return 60.0; // Large screen width
    }
  }

  double getButtonFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 400) {
      return 10.0; // Small screen width
    } else if (screenWidth < 800) {
      return 12.0; // Medium screen width
    } else {
      return 14.0; // Large screen width
    }
  }
