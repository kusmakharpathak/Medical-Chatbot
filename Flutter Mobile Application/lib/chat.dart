import 'package:e_doctors/services/service.auth.dart';
import 'package:e_doctors/services/services.firebase.dart';
import 'package:e_doctors/services/services.utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icon.dart';
import 'package:uuid/uuid.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final myMessage = TextEditingController();
  String mes = '';
  int date_time = DateTime.now().millisecondsSinceEpoch;
  Query _ref;
  Map data;
  Map userdata;
  String id = '';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        id = ModalRoute.of(context).settings.arguments;
      });
      print("id: $id");
    });
    Future.delayed(const Duration(microseconds: 1), () {
      print("id: $id");
      FirebaseServices()
          .read('Symptoms')
          .orderByChild("id")
          .equalTo(id.toString())
          .once()
          .then((DataSnapshot snapshot) {
        setState(() {
          data = snapshot.value;
        });
      });

      _ref = FirebaseServices()
          .read('Symptoms')
          .orderByChild("id")
          .equalTo(id.toString());

      FirebaseServices()
          .readSingle('Patients', id.toString())
          .once()
          .then((DataSnapshot snapshot) {
        setState(() {
          userdata = snapshot.value;
        });
      });
    });
  }

  var url = 'https://chatbotapp.azurewebsites.net/connect?message';

  Future<String> send_msg(symptoms) async {
    if (symptoms == "") {
    } else {
      setState(() {
        myMessage.clear();
      });
      var uuid = Uuid();
      http.Response response = await http.get('$url=$symptoms');
      Map<String, dynamic> message = {
        'id': id,
        'a': symptoms,
        'b': response.body,
        'time': DateTime.now().millisecondsSinceEpoch
      };
      FirebaseServices().insert('Symptoms', uuid.v4(), message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: userdata != null
            ? Text(
                "Welcome ${userdata['fName'][0].toUpperCase()}${userdata['fName'].substring(1)} ${userdata['lName'][0].toUpperCase()}${userdata['lName'].substring(1)}")
            : Text("Welcome"),
        actions: [
          IconButton(
              icon: LineIcon.powerOff(),
              onPressed: () {
                AuthenticationService().logout(context);
              })
        ],
      ),
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
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: data != null
                    ? Container(
                        child: FirebaseAnimatedList(
                          query: _ref,
                          itemBuilder: (BuildContext context,
                              DataSnapshot snapshot,
                              Animation<double> anumation,
                              int index) {
                            String _id = snapshot.key;
                            Map cont = snapshot.value;
                            return Container(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.topRight,
                                    padding: EdgeInsets.only(
                                        top: 10, left: 120, right: 10),
                                    child: Card(
                                      color: Colors.blueGrey,
                                      child: ListTile(
                                        title: Text(cont['a'].toString()),
                                        subtitle: Text(
                                          Utils.formatTimestamp(cont['time']),
                                          textAlign: TextAlign.end,
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.only(
                                        top: 10, left: 10, right: 120),
                                    child: Card(
                                      color: Colors.blueAccent,
                                      child: ListTile(
                                        title: Text(cont['b'].toString()),
                                        subtitle: Text(
                                          Utils.formatTimestamp(cont['time']),
                                          textAlign: TextAlign.end,
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    : Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          backgroundColor: Color.fromRGBO(17, 103, 69, 1),
                        ),
                      ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        textAlign: TextAlign.left,
                        controller: myMessage,
                        keyboardType: TextInputType.text,
                        showCursor: true,
                        cursorWidth: 2,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          hintText: 'Message',
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
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        print(myMessage.text);
                        send_msg(myMessage.text);
                      },
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).viewInsets.bottom,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
