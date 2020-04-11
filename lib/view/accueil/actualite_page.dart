

import 'package:flutter/material.dart';

import 'package:social_app/view/shared/reusable_header.dart';

class ActualitePage extends StatefulWidget {

  static const String id = 'actualite_page';
  @override
  _ActualitePageState createState() => _ActualitePageState();
}

class _ActualitePageState extends State<ActualitePage> {



  @override
  Widget build(BuildContext context) {
    return  //Center(child: Text("actualite"));
    
     Scaffold(
      appBar:header(context,"actualite"),
      body: Container(
        child: Center(
          child: Text(
            'actualite',
            style: TextStyle(
              fontSize:20,
          ),
          ),
        ),
      ),
    );
  }
}
