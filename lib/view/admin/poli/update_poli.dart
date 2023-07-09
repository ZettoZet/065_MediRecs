// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalexam/controller/poli_controller.dart';
import 'package:finalexam/model/poli_model.dart';
import 'package:finalexam/view/admin/poli/poli.dart';
import 'package:flutter/material.dart';

class UpdatePoli extends StatefulWidget {
  final PoliModel poliModel;
  const UpdatePoli({
    Key? key,
    required DocumentSnapshot<Object?> poli,
    required this.poliModel,
  }) : super(key: key);

  @override
  State<UpdatePoli> createState() => _UpdatePoliState();
}

class _UpdatePoliState extends State<UpdatePoli> {
  var poliController = PoliController();
  final formKey = GlobalKey<FormState>();
  String? poliname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Poli'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: TextEditingController(
                  text: widget.poliModel.poliname,
                ),
                decoration: const InputDecoration(
                  hintText: 'Poli Name',
                ),
                onChanged: (value) => poliname = value,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: const Text('Update Poli'),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    PoliModel pom = PoliModel(
                      id: widget.poliModel.id,
                      poliname: poliname ?? widget.poliModel.poliname,
                    );
                    poliController.updatePoli(pom);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Poli Updated'),
                        duration: Duration(seconds: 1),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Poli(),
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
