import 'package:finalexam/controller/records_controller.dart';
import 'package:finalexam/model/records_model.dart';
import 'package:finalexam/view/admin/home/admin.dart';
import 'package:finalexam/view/admin/home/records_admin_update.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class RecordsAdmin extends StatefulWidget {
  final String id;

  const RecordsAdmin({Key? key, required this.id}) : super(key: key);

  @override
  State<RecordsAdmin> createState() => _RecordsAdminState();
}

class _RecordsAdminState extends State<RecordsAdmin> {
  var rec = RecordsController();

  @override
  void initState() {
    rec.getRecords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Records'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const AdminHome();
                },
              ),
            );
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(245, 40, 145, 0.8),
        ),
        child: Column(
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('records')
                  .doc(widget.id)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final recordData =
                    snapshot.data!.data() as Map<String, dynamic>;
                final pasname = recordData['pasname'] != null
                    ? recordData['pasname'].toString().toUpperCase()
                    : '';
                final penyakit = recordData['penyakit'] != null
                    ? recordData['penyakit'].toString().toUpperCase()
                    : '';
                final poli = recordData['poli'] != null
                    ? recordData['poli'].toString().toUpperCase()
                    : '';
                final timestamp = recordData['timestamp'] as Timestamp?;
                final timestampdate = timestamp != null
                    ? DateFormat('dd-MM-yyyy').format(timestamp.toDate())
                    : '';
                final timestamptime = timestamp != null
                    ? DateFormat('HH:mm:ss').format(timestamp.toDate())
                    : '';

                return Padding(
                  padding: const EdgeInsets.fromLTRB(50, 50, 50, 100),
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        ListTile(
                          title: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Column(
                                children: [
                                  const Text(
                                    "Pasien",
                                    style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    pasname,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 16),
                          child: Divider(
                            color: Colors.black,
                            thickness: 2,
                          ),
                        ),
                        Column(
                          children: [
                            const Text(
                              "Poli",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              poli,
                              style: const TextStyle(
                                fontSize: 18.2,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                "Penyakit",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              penyakit,
                              style: const TextStyle(
                                fontSize: 18.2,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                "Created At",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              timestampdate,
                              style: const TextStyle(
                                fontSize: 18.2,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              timestamptime,
                              style: const TextStyle(
                                fontSize: 18.2,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: StreamBuilder<List<DocumentSnapshot>>(
        stream: rec.stream3,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          final List<DocumentSnapshot> data = snapshot.data!;

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecordsAdminUpdate(
                    recordsModel: RecordsModel.fromMap(
                        data[0].data() as Map<String, dynamic>),
                    records: data[0],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
