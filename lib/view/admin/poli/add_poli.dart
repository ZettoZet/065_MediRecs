import 'package:finalexam/controller/poli_controller.dart';
import 'package:finalexam/model/poli_model.dart';
import 'package:finalexam/view/admin/poli/poli.dart';
import 'package:flutter/material.dart';

class AddPoli extends StatefulWidget {
  const AddPoli({Key? key}) : super(key: key);

  @override
  State<AddPoli> createState() => _AddPoliState();
}

class _AddPoliState extends State<AddPoli> {
  var poliController = PoliController();
  final formKey = GlobalKey<FormState>();
  String? poliname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Poli'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Poli Name',
                ),
                onChanged: (value) => poliname = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Poli Name must not be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: const Text('Add Poli'),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    PoliModel pm = PoliModel(
                      poliname: poliname!,
                    );
                    poliController.addPoli(pm).then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Poli(),
                        ),
                      );
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Poli Added'),
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
    );
  }
}
