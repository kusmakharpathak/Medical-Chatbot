import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromRGBO(100, 220, 255, 0.5),
                  Color.fromRGBO(100, 250, 100, 0.1)
                ]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 40, bottom: 30),
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'Welcome to E-Doctor',
                                  style: TextStyle(
                                      fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                              ),
                              subtitle: Text(
                                'Get your medical report with best AI based health (medical) chat-bot',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 60),
                      child: FloatingActionButton.extended(
                        onPressed: () =>
                            Navigator.of(context).pushReplacementNamed('/login'),
                        label: Text('Get Started'),
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.60,
                child: Image.asset('assets/image/415.jpg'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
