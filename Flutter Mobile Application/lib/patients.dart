import 'package:flutter/material.dart';

class Patients {
  String fName;
  String lName;
  int age;
  String email;

  Patients({this.fName, this.lName, this.age, this.email});

  getFName() {
    return this.fName;
  }

  getLName() {
    return this.lName;
  }

  getAge() {
    return this.age;
  }

  Map<String, dynamic> json() {
    return {
      'fName': this.fName,
      'lName': this.lName,
      'age': this.age,
      'email': this.email,
    };
  }
}
