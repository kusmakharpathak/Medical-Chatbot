import 'package:e_doctors/patients.dart';
import 'package:e_doctors/services/service.auth.dart';
import 'package:e_doctors/services/services.utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final fName = TextEditingController();
  final lName = TextEditingController();
  final eMail = TextEditingController();
  Text dateOfBirth = Text('Choose Date of Birth');
  DateTime dob;
  String fname = 'Enter First Name';
  String lname = 'Enter Last Name';
  String email = 'Enter Your Email';
  Color fnamecolor = Colors.blue;
  Color lnamecolor = Colors.blue;
  Color emailcolor = Colors.blue;
  Color dobColor = Colors.blue;

  void _dobPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        setState(() {
          dateOfBirth = Text(
            'No Date Chosen!',
          );
          dobColor = Colors.red;
        });
      }
      setState(() {
        dob = pickedDate;
      });
    });
  }

  Future<void> _submitCommand() async {
    final form = formKey.currentState;
    if (fName.text.isEmpty) {
      setState(() {
        fname = "Enter your first name";
        fnamecolor = Colors.red;
      });
    }
    if (lName.text.isEmpty) {
      setState(() {
        lname = "Enter your first name";
        lnamecolor = Colors.red;
      });
    }
    if (eMail.text.isEmpty) {
      setState(() {
        email = "Enter your email name";
        emailcolor = Colors.red;
      });
    }
    if (dob == null) {
      setState(() {
        dobColor = Colors.red;
      });
    }

    if (form.validate()) {
      print(fName);
      form.save();
      String password = Utils.password();
      Map<String, dynamic> data = Patients(
        fName: fName.text.toLowerCase().trim(),
        lName: lName.text.toLowerCase().trim(),
        email: eMail.text.toLowerCase().trim(),
        age: DateTime.now().year - dob.year,
      ).json();
      AuthenticationService().registerToFb(
          password: password, id: 'Patients', data: data, context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromRGBO(100, 220, 255, 0.5),
                Color.fromRGBO(100, 250, 100, 0.1)
              ]),
        ),
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Register To E-Doctor',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                textAlign: TextAlign.center,
                controller: fName,
                keyboardType: TextInputType.text,
                showCursor: true,
                cursorWidth: 2,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: fname,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  fillColor: fnamecolor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                textAlign: TextAlign.center,
                controller: lName,
                keyboardType: TextInputType.text,
                showCursor: true,
                cursorWidth: 2,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: lname,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  fillColor: lnamecolor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                textAlign: TextAlign.center,
                controller: eMail,
                keyboardType: TextInputType.text,
                showCursor: true,
                cursorWidth: 2,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: email,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  fillColor: emailcolor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: _dobPicker,
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 55,
                  decoration: BoxDecoration(
                    color: dobColor,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: dobColor),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        LineIcons.calendar,
                        color: Colors.lightBlue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      dob == null
                          ? dateOfBirth
                          : Text(
                              '${DateFormat.yMMMd().format(dob)}',
                              textAlign: TextAlign.center,
                            ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    // print(fName.text);
                    // var date = DateTime.fromMillisecondsSinceEpoch(dob.millisecondsSinceEpoch-DateTime.now().millisecondsSinceEpoch);
                    // var formattedDate = DateFormat.M().format(date);
                    // print(formattedDate);
                    // print(dob.year-DateTime.now().year);
                    _submitCommand();
                  },
                  label: Text('SIGN UP'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () =>
                    Navigator.of(context).pushReplacementNamed('/login'),
                child: Text('Already Registered'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
