import 'package:app/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

TextEditingController _name = TextEditingController();
TextEditingController _snController = TextEditingController();
TextEditingController _adressController = TextEditingController();

void createBottomSheet(BuildContext context) {
  showModalBottomSheet(
      backgroundColor: Colors.blue[50],
      context: context,
      builder: (context) {
        return Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(),
            child: Form(
              child: Column(children: [
                Center(
                  child: Text(
                    "Create your items",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: _name,
                  decoration: InputDecoration(
                    labelText: "Name",
                    hintText: "eg.Elon",
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _snController,
                  decoration: InputDecoration(
                    labelText: "S.N",
                    hintText: "eg.1",
                  ),
                ),
                TextField(
                  controller: _adressController,
                  decoration: InputDecoration(
                    labelText: "Adress",
                    hintText: "eg.UK",
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      final id =
                          DateTime.now().microsecondsSinceEpoch.toString();
                      databaseReferance.child(id).set({
                        'name': _name.text,
                        'sn': _snController.text,
                        'address': _adressController.text,
                        'id': id
                      });
                      _name.clear();
                      _adressController.clear();
                      _snController.clear();
                      Navigator.pop(context);
                    },
                    child: Text("Add"))
              ]),
            ));
      });
}
