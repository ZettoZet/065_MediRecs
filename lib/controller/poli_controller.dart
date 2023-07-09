import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalexam/model/poli_model.dart';

class PoliController {
  final poliCollection = FirebaseFirestore.instance.collection('poli');

  final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();

  Stream<List<DocumentSnapshot>> get stream1 => streamController.stream;

  Future addPoli(PoliModel ctmodel) async {
    final poli = ctmodel.toMap();
    final DocumentReference docRef = await poliCollection.add(poli);
    final String docId = docRef.id;
    final PoliModel poliModel = PoliModel(
      id: docId,
      poliname: ctmodel.poliname,
    );

    await docRef.update(poliModel.toMap());
  }

  Future<List<DocumentSnapshot<Object?>>>? getPoli() async {

  final poli = await poliCollection.get();

  streamController.sink.add(poli.docs);
  return poli.docs;
}

  Future<void> deletePoli(String id) async {
    await poliCollection.doc(id).delete();
  }

  Future<void> updatePoli(PoliModel ctmodel) async {
    final poli = ctmodel.toMap();
    await poliCollection.doc(ctmodel.id).update(poli);
  }

  Future updatePoli2(String docId, PoliModel poliModel) async {
    final PoliModel updatedPoliModel = PoliModel(
      id: docId,
      poliname: poliModel.poliname,
    );

    final DocumentSnapshot documentSnapshot =
        await poliCollection.doc(docId).get();
    if (!documentSnapshot.exists) {
      // ignore: avoid_print
      print('Document with ID $docId does not exist');
      return;
    }
    final updatedPoli = updatedPoliModel.toMap();
    await poliCollection.doc(docId).update(updatedPoli);
    await getPoli();
    // ignore: avoid_print
    print('Updated poli with ID $docId');
  }
}
