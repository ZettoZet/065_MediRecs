import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalexam/model/records_model.dart';

class RecordsController {
  final recordsCollection = FirebaseFirestore.instance.collection('records');
  final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();
  Stream<List<DocumentSnapshot>> get stream3 =>  recordsCollection.snapshots().map((snapshot) => snapshot.docs);
  Future addRecords(RecordsModel ctmodel) async {
    final records = ctmodel.toMap();
    final DocumentReference docRef = await recordsCollection.add(records);
    final String docId = docRef.id;
    final RecordsModel recordsModel = RecordsModel(
      id: docId,
      pasname: ctmodel.pasname,
      poli: ctmodel.poli,
      penyakit: ctmodel.penyakit,
    );

    await docRef.update(recordsModel.toMap());
  }

  Future<List<String?>> getRecords() async {
    final records = await recordsCollection.get();
    final poliOptions = records.docs
        .map((doc) => RecordsModel.fromMap(doc.data()).poli)
        .toList();
    return poliOptions;
  }

  Future<void> deleteRecords(String id) async {
    await recordsCollection.doc(id).delete();
  }

  Future<void> updateRecords(RecordsModel ctmodel) async {
    final records = ctmodel.toMap();
    await recordsCollection.doc(ctmodel.id).update(records);
  }

  Future updateRecords2(String docId, RecordsModel recordsModel) async {
    final RecordsModel updatedRecordsModel = RecordsModel(
      id: docId,
      pasname: recordsModel.pasname,
      poli: recordsModel.poli,
      penyakit: recordsModel.penyakit,
    );

    final DocumentSnapshot documentSnapshot =
        await recordsCollection.doc(docId).get();
    if (!documentSnapshot.exists) {
      // ignore: avoid_print
      print('Document with ID $docId does not exist');
      return;
    }
    final updatedRecords = updatedRecordsModel.toMap();
    await recordsCollection.doc(docId).update(updatedRecords);
    await getRecords();
    // ignore: avoid_print
    print('Updated records with ID $docId');
  }
}
