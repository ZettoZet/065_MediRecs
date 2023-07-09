import 'dart:convert';

class PenyakitModel {
  String? id;
  final String penname;
  PenyakitModel({
    this.id,
    required this.penname,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'penname': penname,
    };
  }

  factory PenyakitModel.fromMap(Map<String, dynamic> map) {
    return PenyakitModel(
      id: map['id'] != null ? map['id'] as String : null,
      penname: map['penname'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PenyakitModel.fromJson(String source) => PenyakitModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
