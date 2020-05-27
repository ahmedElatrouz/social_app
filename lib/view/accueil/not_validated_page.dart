import 'package:flutter/material.dart';

class NotValidatedPage extends StatefulWidget {
  @override
  _NotValidatedPageState createState() => _NotValidatedPageState();
}

class _NotValidatedPageState extends State<NotValidatedPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Text(" Votre profile n'est pas encore validé!!")
      ),
    );
  }
}