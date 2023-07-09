// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalexam/controller/penyakit_controller.dart';
import 'package:finalexam/model/penyakit_model.dart';
import 'package:finalexam/view/admin/penyakit/penyakit.dart';
import 'package:flutter/material.dart';

class UpdatePenyakit extends StatefulWidget {
  final PenyakitModel penyakitModel;
  const UpdatePenyakit({
    Key? key,
    required DocumentSnapshot<Object?> penyakit,
    required this.penyakitModel,
  }) : super(key: key);

  @override
  State<UpdatePenyakit> createState() => _UpdatePenyakitState();
}

class _UpdatePenyakitState extends State<UpdatePenyakit> {
  var penyakitController = PenyakitController();
  final formKey = GlobalKey<FormState>();
  String? penname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Penyakit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: TextEditingController(
                  text: widget.penyakitModel.penname,
                ),
                decoration: const InputDecoration(
                  hintText: 'Penyakit Name',
                ),
                onChanged: (value) => penname = value,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: const Text('Update Penyakit'),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    PenyakitModel pem = PenyakitModel(
                      id: widget.penyakitModel.id,
                      penname: penname ?? widget.penyakitModel.penname,
                    );
                    penyakitController.updatePenyakit(pem);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Penyakit Updated'),
                        duration: Duration(seconds: 1),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Penyakit(),
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
