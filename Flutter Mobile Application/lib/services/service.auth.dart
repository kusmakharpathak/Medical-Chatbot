
import 'package:e_doctors/services/services.utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:e_doctors/services/services.check.dart';
import 'package:e_doctors/services/services.firebase.dart';

class AuthenticationService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void registerToFb({String password, String id, Map data, context}) {
    Flushbar(
      backgroundColor: Color.fromRGBO(17, 103, 69, 1),
      message:
      "Registering Process...",
      duration: Duration(seconds: 5),
    )..show(context);
    print(password);
    firebaseAuth
        .createUserWithEmailAndPassword(
            email: data['email'], password: password)
        .then((result) async {
      FirebaseServices().insert(id, result.user.uid, data);
      Utils.sendEmail(
          password: password,
          subject: 'E-Doctors Chat-Bot application Registration Details',
          data: data);
      Flushbar(
        backgroundColor: Color.fromRGBO(17, 103, 69, 1),
        message:
        "Registration Success...",
        duration: Duration(seconds: 5),
      )..show(context);
      await Future.delayed(const Duration(seconds: 1), (){});
      Navigator.of(context).pushReplacementNamed('/login');
    }).catchError((err) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                // ignore: deprecated_member_use
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }

  void signin({String email, String password, context}) {
    Flushbar(
      backgroundColor: Color.fromRGBO(17, 103, 69, 1),
      message:
          "Login...",
      duration: Duration(seconds: 5),
    )..show(context);
    firebaseAuth
        .signInWithEmailAndPassword(
            email: email, password: password)
        .then((result) {
          print(result.user.uid);
          Navigator.of(context).pop();
          Navigator.of(context).popAndPushNamed('/chat', arguments: result.user.uid);
    }).catchError((err) {
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
                        'Invalid Login',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
              content: Text(err.message),
              actions: [
                // ignore: deprecated_member_use
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }

   void logout(context) {
    firebaseAuth.signOut();
    Navigator.popAndPushNamed(context, '/login');
    Flushbar(
      backgroundColor: Color.fromRGBO(17, 103, 69, 1),
      message:
          "You have been Logout.\nThank You",
      duration: Duration(seconds: 5),
    )..show(context);
  }

  void changePwd() {
    firebaseAuth.sendPasswordResetEmail(email: firebaseAuth.currentUser.email);
  }
}
