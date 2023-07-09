import 'package:finalexam/controller/penyakit_controller.dart';
import 'package:finalexam/model/penyakit_model.dart';
import 'package:finalexam/view/admin/penyakit/penyakit.dart';
import 'package:flutter/material.dart';

class AddPenyakit extends StatefulWidget {
  const AddPenyakit({Key? key}) : super(key: key);

  @override
  State<AddPenyakit> createState() => _AddPenyakitState();
}

class _AddPenyakitState extends State<AddPenyakit> {
  var penyakitController = PenyakitController();
  final formKey = GlobalKey<FormState>();
  String? penname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Penyakit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Penyakit Name',
                ),
                onChanged: (value) => penname = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Penyakit Name must not be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: const Text('Add Penyakit'),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    PenyakitModel pm = PenyakitModel(
                      penname: penname!,
                    );
                    penyakitController.addPenyakit(pm).then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Penyakit(),
                        ),
                      );
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Penyakit Added'),
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
