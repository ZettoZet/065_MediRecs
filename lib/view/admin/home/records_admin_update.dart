// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalexam/controller/records_controller.dart';
import 'package:finalexam/model/records_model.dart';
import 'package:finalexam/view/admin/home/admin.dart';
import 'package:flutter/material.dart';

class RecordsAdminUpdate extends StatefulWidget {
  final RecordsModel recordsModel;
  const RecordsAdminUpdate({
    Key? key,
    required DocumentSnapshot<Object?> records,
    required this.recordsModel,
  }) : super(key: key);

  @override
  State<RecordsAdminUpdate> createState() => _RecordsAdminUpdateState();
}

class _RecordsAdminUpdateState extends State<RecordsAdminUpdate> {
  var recordsController = RecordsController();
  final formKey = GlobalKey<FormState>();
  String? pasname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Records'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: TextEditingController(
                  text: widget.recordsModel.pasname,
                ),
                decoration: const InputDecoration(
                  hintText: 'Records Name',
                ),
                onChanged: (value) => pasname = value,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: const Text('Update Records'),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    RecordsModel pem = RecordsModel(
                      id: widget.recordsModel.id,
                      pasname: pasname ?? widget.recordsModel.pasname,
                    );
                    recordsController.updateRecords(pem);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Records Updated'),
                        duration: Duration(seconds: 1),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminHome(),
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
