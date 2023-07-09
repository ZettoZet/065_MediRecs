import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecordsModel {
  String? id;
  final String? pasname;
  final String? poli;
  final String? penyakit;
  final Timestamp? timestamp;

  RecordsModel({
    this.id,
    this.pasname,
    this.poli,
    this.penyakit,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'pasname': pasname,
      'poli': poli,
      'penyakit': penyakit,
      'timestamp': timestamp ?? FieldValue.serverTimestamp(),
    };
  }

  factory RecordsModel.fromMap(Map<String, dynamic> map) {
    return RecordsModel(
      id: map['id'] != null ? map['id'] as String : null,
      pasname: map['pasname'] != null ? map['pasname'] as String : null,
      poli: map['poli'] != null ? map['poli'] as String : null,
      penyakit: map['penyakit'] != null ? map['penyakit'] as String : null,
      timestamp: map['timestamp'] != null
          ? (map['timestamp'] as Timestamp)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RecordsModel.fromJson(String source) =>
      RecordsModel.fromMap(json.decode(source) as Map<String, dynamic>);

      String getFormattedTimestamp() {
    if (timestamp != null) {
      final DateTime dateTime = timestamp!.toDate();
      final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
      return formatter.format(dateTime);
    }
    return '';
  }
}
