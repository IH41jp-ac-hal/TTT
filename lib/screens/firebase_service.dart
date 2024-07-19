import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> incrementButtonCount(String warehouseId, String status) async {
    // Firestoreの参照を取得
    DocumentReference countRef = _db.collection('warehouse').doc('warehouse01');

    print(await countRef.get()); // await を追加して非同期で結果を取得

    // Firestoreのトランザクションを実行
    await _db.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(countRef);
      if (!snapshot.exists) {
        // 初めての更新なら1からスタート
        transaction
            .set(countRef, {'$status': 1}); // status をフィールド名として使うために {} を修正
      } else {
        int currentValue = snapshot.get(status) ?? 0; // status に対応するフィールドの値を取得
        print(currentValue);
        transaction.update(countRef, {status: currentValue + 1});
      }
    }).then((value) {
      print('Count updated successfully.');
    }).catchError((error) {
      print('Failed to update count: $error');
    });
  }

  Future<int> getButtonCount(String warehouseId, String status) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await _db
        .collection('warehouses')
        .doc(warehouseId)
        .collection('status')
        .doc(status)
        .get();

    if (snapshot.exists && snapshot.data() != null) {
      return snapshot.data()!['count'] ?? 0;
    } else {
      return 0;
    }
  }

  Stream<DocumentSnapshot> getStatusUpdates(String warehouseId) {
    // Firestoreの指定したドキュメントのストリームを取得
    return _db.collection('Warehouse').doc(warehouseId).snapshots();
  }
}
