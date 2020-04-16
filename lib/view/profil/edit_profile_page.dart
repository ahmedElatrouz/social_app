import 'package:flutter/material.dart';

class EditProfilPage extends StatefulWidget {
  @override
  _EditProfilPageState createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Preferences",
            style: TextStyle(fontSize: 24.0),
          ),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color: Colors.grey[100],
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person), title: Text('COMPTE')),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.lock),
                        title: Text('CONFIDENTIALITE')),
                   
                  ],
                ),
              )
            ]));
  }
}
