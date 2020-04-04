

import 'package:flutter/material.dart';
import 'package:social_app/view/shared/reusable_header.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context),
      body:Center(child: Text("profile page")) ,
     
    );
  }
}