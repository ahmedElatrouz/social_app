import 'package:flutter/material.dart';


class ActualitePage extends StatefulWidget {
  @override
  _ActualitePageState createState() => _ActualitePageState();
}

class _ActualitePageState extends State<ActualitePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SocialApp2')
      ),
      body: Container(
        child: Text(
          'Helloooo',
          style: TextStyle(
            fontSize:50,
        ),
        ),
      ),
    );
  }
}
