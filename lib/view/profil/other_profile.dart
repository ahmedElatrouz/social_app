import 'package:flutter/material.dart';





class OtherProfile extends StatefulWidget {
  
  static const String id = 'otherProfilPage';
  @override
  _OtherProfileState createState() => _OtherProfileState();
}

class _OtherProfileState extends State<OtherProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[400],
      ),
      body: Center(child: Text("other profil page")),
    );
  }
}