import 'package:finalexam/icons/custom_icons.dart';
import 'package:finalexam/login.dart';
import 'package:finalexam/view/admin/home/admin.dart';
import 'package:finalexam/view/admin/penyakit/penyakit.dart';
import 'package:finalexam/view/admin/poli/poli.dart';
import 'package:flutter/material.dart';

class ProfilDokterAdmin extends StatefulWidget {
  const ProfilDokterAdmin({Key? key}) : super(key: key);

  @override
  State<ProfilDokterAdmin> createState() => _ProfilDokterAdminState();
}

class _ProfilDokterAdminState extends State<ProfilDokterAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Dokter'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(245, 40, 145, 0.8),
        ),
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
    );
  }
}
