import 'package:flutter/material.dart';

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
    return Form(
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
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('送信'),
            ),
          ],
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
            Text('お名前: ${reservation.name}'),
            SizedBox(height: 8.0),
            Text('電話番号: ${reservation.phoneNumber}'),
            SizedBox(height: 8.0),
            Text('日付: ${reservation.date}'),
            SizedBox(height: 8.0),
            Text('時刻: ${reservation.time}'),
            SizedBox(height: 8.0),
            Text('倉庫場所: ${reservation.warehouseLocation}'),
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
        return ListTile(
          title: Text(reservation.name),
          subtitle: Text('${reservation.date} ${reservation.time}'),
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
    );
  }
}
