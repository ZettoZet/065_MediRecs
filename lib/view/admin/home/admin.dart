import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalexam/controller/penyakit_controller.dart';
import 'package:finalexam/controller/poli_controller.dart';
import 'package:finalexam/controller/records_controller.dart';
import 'package:finalexam/icons/custom_icons.dart';
import 'package:finalexam/login.dart';
import 'package:finalexam/view/admin/home/add_records.dart';
import 'package:finalexam/view/admin/home/records_admin.dart';
import 'package:finalexam/view/admin/penyakit/penyakit.dart';
import 'package:finalexam/view/admin/poli/poli.dart';
import 'package:finalexam/view/admin/profil/profil_dokter_admin.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  var pec = PenyakitController();
  var poc = PoliController();
  var rec = RecordsController();

  @override
  void initState() {
    pec.getPenyakit();
    poc.getPoli();
    rec.getRecords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                    color: Color.fromRGBO(0, 174, 255, 0.98), width: 3),
              ),
            ),
          ),
          StreamBuilder<List<DocumentSnapshot>>(
            stream: rec.stream3,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final List<DocumentSnapshot> data = snapshot.data!;
              return Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        onLongPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecordsAdmin(
                                id: data[index].id,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 10,
                          child: ListTile(
                            title: Text(data[index]['pasname']),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () {
                                //buat dialog delete data
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Delete Data'),
                                      content: const Text(
                                          'Are you sure want to delete this data?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            rec.recordsCollection
                                                .doc(data[index].id)
                                                .delete();
                                            rec.getRecords();
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Data has been deleted'),
                                                duration: Duration(seconds: 1),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          },
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 100,
              width: 310,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminHome(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Profil Dokter'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilDokterAdmin(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.health_and_safety),
                    title: const Text('Poli'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Poli(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(CustomIcons.disease),
                    title: const Text('Penyakit'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Penyakit(),
                        ),
                      );
                    },
                  ),
                  // ListTile(
                  //   leading: const Icon(CustomIcons.notes_medical),
                  //   title: const Text('Records'),
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => const RecordsAdmin(),
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddRecords(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
