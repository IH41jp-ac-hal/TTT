import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String?> getWarehouseLocation(String reservationId) async {
    DocumentSnapshot snapshot =
        await _db.collection('reservations').doc(reservationId).get();
    if (snapshot.exists) {
      return snapshot['warehouseLocation'];
    }
    return null;
  }

  Future<void> incrementButtonCount(String warehouseId, String status) async {
    DocumentReference countRef =
        _db.collection('warehouse_status').doc(warehouseId);

    await _db.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(countRef);
      if (!snapshot.exists) {
        transaction.set(countRef, {
          'currentStatus': status,
          'statusCounts': {status: 1}
        });
      } else {
        Map<String, dynamic> statusCounts =
            Map<String, dynamic>.from(snapshot['statusCounts']);
        int currentValue = statusCounts[status] ?? 0;
        statusCounts[status] = currentValue + 1;
        transaction.update(
            countRef, {'currentStatus': status, 'statusCounts': statusCounts});
      }
    }).then((value) {
      print('Count updated successfully.');
    }).catchError((error) {
      print('Failed to update count: $error');
    });
  }

  Stream<DocumentSnapshot> getStatusUpdates(String warehouseId) {
    return _db.collection('warehouse_status').doc(warehouseId).snapshots();
  }

  Future<Map<String, dynamic>> getStatusCounts(String warehouseId) async {
    DocumentSnapshot snapshot =
        await _db.collection('warehouse_status').doc(warehouseId).get();
    if (snapshot.exists) {
      return snapshot['statusCounts'];
    }
    return {};
  }
}
