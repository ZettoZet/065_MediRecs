import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalexam/controller/penyakit_controller.dart';
import 'package:finalexam/controller/poli_controller.dart';
import 'package:finalexam/controller/records_controller.dart';
import 'package:finalexam/model/records_model.dart';
import 'package:finalexam/view/admin/home/admin.dart';
import 'package:flutter/material.dart';

class AddRecords extends StatefulWidget {
  const AddRecords({Key? key}) : super(key: key);

  @override
  State<AddRecords> createState() => _AddRecordsState();
}

class _AddRecordsState extends State<AddRecords> {
  var recordsController = RecordsController();
  var poc = PoliController();
  var pec = PenyakitController();
  final formKey = GlobalKey<FormState>();
  String? pasname;
  String? poli;
  String? penyakit;
  List<Map<String, dynamic>> poliOptions = [];
  List<Map<String, dynamic>> penyakitOptions = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Records'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Pasien Name',
                  ),
                  onChanged: (value) => pasname = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Pasien Name must not be empty';
                    }
                    return null;
                  },
                ),
                FutureBuilder<List<DocumentSnapshot>>(
                  future: poc.getPoli(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      poliOptions = snapshot.data!.map((doc) {
                        Map<String, dynamic> data =
                            doc.data() as Map<String, dynamic>;
                        return {
                          'poliname': data['poliname'],
                          'poli': data['poliname'],
                        };
                      }).toList();
                      return DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          hintText: 'Poli',
                        ),
                        value: poli,
                        onChanged: (value) {
                          setState(() {
                            poli = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return 'Poli must be selected';
                          }
                          return null;
                        },
                        items: poliOptions.isNotEmpty
                            ? poliOptions.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value['poliname'],
                                  child: Text(value['poliname']),
                                );
                              }).toList()
                            : const [
                                DropdownMenuItem<String>(
                                  value: 'empty',
                                  child: Text('empty'),
                                ),
                              ],
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                FutureBuilder<List<DocumentSnapshot>>(
                  future: pec.getPenyakit(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      penyakitOptions = snapshot.data!.map((doc) {
                        Map<String, dynamic> data =
                            doc.data() as Map<String, dynamic>;
                        return {
                          'penname': data['penname'],
                          'penyakit': data['penname'],
                        };
                      }).toList();
                      return DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          hintText: 'Penyakit',
                        ),
                        value: penyakit,
                        onChanged: (value) {
                          setState(() {
                            penyakit = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return 'Penyakit must be selected';
                          }
                          return null;
                        },
                        items: penyakitOptions.isNotEmpty
                            ? penyakitOptions.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value['penname'],
                                  child: Text(value['penname']),
                                );
                              }).toList()
                            : const [
                                DropdownMenuItem<String>(
                                  value: 'empty',
                                  child: Text('empty'),
                                ),
                              ],
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  child: const Text('Add Records'),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      RecordsModel rm = RecordsModel(
                        pasname: pasname!,
                        poli: poli!,
                        penyakit: penyakit!,
                        timestamp: Timestamp.now(),
                      );
                      recordsController.addRecords(rm).then((value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminHome(),
                          ),
                        );
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Records Added'),
                          duration: Duration(seconds: 1),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
