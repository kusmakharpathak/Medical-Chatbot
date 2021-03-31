import 'package:firebase_database/firebase_database.dart';
import 'package:line_icons/line_icons.dart';
import 'package:e_doctors/services/services.firebase.dart';
import 'package:flutter/material.dart';

class Check {
  void status(String uuid, context) {
    FirebaseServices().readSingle('user', uuid).once().then(
      (DataSnapshot snapshot) {
        if (snapshot.value['status'] == false) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: ListTile(
                    title: Icon(
                      LineIcons.parking,
                      color: Colors.red,
                      size: 50,
                    ),
                    subtitle: Text(
                      'Account Disable',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  content: Text(
                      'Your account has been disable please contact Smartlink'),
                  actions: [
                    FlatButton(
                      child: Text("Ok"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        } else {

          Navigator.pushReplacementNamed(context, '/home', arguments: {
            'uuid' : uuid,
            'role': snapshot.value['role'],
            'f_name': snapshot.value['first_name'],
            'l_name': snapshot.value['last_name'],
          });
        }
      },
    );
  }
}
