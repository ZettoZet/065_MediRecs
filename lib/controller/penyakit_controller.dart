import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalexam/model/penyakit_model.dart';

class PenyakitController {
  final penyakitCollection = FirebaseFirestore.instance.collection('penyakit');

  final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();

  Stream<List<DocumentSnapshot>> get stream2 => streamController.stream;

  Future addPenyakit(PenyakitModel ctmodel) async {
    final penyakit = ctmodel.toMap();
    final DocumentReference docRef = await penyakitCollection.add(penyakit);
    final String docId = docRef.id;
    final PenyakitModel penyakitModel = PenyakitModel(
      id: docId,
      penname: ctmodel.penname,
    );

    await docRef.update(penyakitModel.toMap());
  }

  Future<List<DocumentSnapshot<Object?>>>? getPenyakit() async {

  final penyakit = await penyakitCollection.get();

  streamController.sink.add(penyakit.docs);
  return penyakit.docs;
}

  Future<void> deletePenyakit(String id) async {
    await penyakitCollection.doc(id).delete();
  }

  Future<void> updatePenyakit(PenyakitModel ctmodel) async {
    final penyakit = ctmodel.toMap();
    await penyakitCollection.doc(ctmodel.id).update(penyakit);
  }

  Future updatePenyakit2(String docId, PenyakitModel penyakitModel) async {
    final PenyakitModel updatedPenyakitModel = PenyakitModel(
      id: docId,
      penname: penyakitModel.penname,
    );

    final DocumentSnapshot documentSnapshot =
        await penyakitCollection.doc(docId).get();
    if (!documentSnapshot.exists) {
      // ignore: avoid_print
      print('Document with ID $docId does not exist');
      return;
    }
    final updatedPenyakit = updatedPenyakitModel.toMap();
    await penyakitCollection.doc(docId).update(updatedPenyakit);
    await getPenyakit();
    // ignore: avoid_print
    print('Updated penyakit with ID $docId');
  }
}
