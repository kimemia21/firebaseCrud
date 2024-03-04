import 'package:app/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

TextEditingController _name = TextEditingController();
TextEditingController _snController = TextEditingController();
TextEditingController _adressController = TextEditingController();

void updateBottomSheet( context,   name,   sn,  adress, id) {
  _name.text = name;
  _snController.text = sn;
  _adressController.text = adress;
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
                    "Update your items",
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
                  controller: _snController,
                  keyboardType: TextInputType.number,
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
                      databaseReferance.child(id).update({
                        'name': _name.text,
                        'sn': _snController.text,
                        'address': _adressController.text,
                      });
                      _name.clear();
                      _adressController.clear();
                      _snController.clear();
                      Navigator.pop(context);
                    },
                    child: Text("Update"))
              ]),
            ));
      });
}
