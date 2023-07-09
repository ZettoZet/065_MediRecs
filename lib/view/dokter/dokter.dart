import 'package:flutter/material.dart';

class DokterHome extends StatefulWidget {
  const DokterHome({Key? key}) : super(key: key);

  @override
  State<DokterHome> createState() => _DokterHomeState();
}

class _DokterHomeState extends State<DokterHome> {
  int _selectedIndex = 0;

  static const List<Widget> _menuOptions = <Widget>[
    Text('Home'),
    Text('Settings'),
    Text('Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Home'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(79, 255, 145, 0.8),
        ),
        child: Center(
          child: _menuOptions.elementAt(_selectedIndex),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                _onMenuItemSelected(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                _onMenuItemSelected(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                _onMenuItemSelected(2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onMenuItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  } 
}
