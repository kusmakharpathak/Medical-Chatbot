import 'package:e_doctors/services/service.auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _email = TextEditingController();

  final _password = TextEditingController();

  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  final formKey = GlobalKey<FormState>();

  void _submitCommand() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      AuthenticationService()
          .signin(email: _email.text.toLowerCase().trim(), password: _password.text, context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromRGBO(100, 220, 255, 0.5),
                Color.fromRGBO(100, 250, 100, 0.1)
              ]),
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Login To E-Doctor',
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
                controller: _email,
                keyboardType: TextInputType.text,
                showCursor: true,
                cursorWidth: 2,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: 'email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  fillColor: Colors.blue,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                textAlign: TextAlign.center,
                controller: _password,
                keyboardType: TextInputType.text,
                showCursor: true,
                cursorWidth: 2,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: 'password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  fillColor: Colors.blue,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: FloatingActionButton.extended(
                  onPressed: ()=>_submitCommand(),
                  label: Text('LOGIN'),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () =>
                    Navigator.of(context).pushReplacementNamed('/register'),
                child: Text('Don\'t Have an Account! Register Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
