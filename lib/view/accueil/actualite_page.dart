

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
      //appBar:header(context,"actualite"),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(child: Text('hello',style: TextStyle(color:Colors.white),)),
             /* Container(
                child:Icon(Icons.image)
              ),
              Container(
                child: TextField(),
              ),
              Container(
                child:Icon(Icons.whatshot)
              ),
              Container(
                child:Icon(Icons.photo)
              ),
*/
            ]
          ),
          Container(
            child: Center(
              child: Text(
                'actualite',
                style: TextStyle(
                  fontSize:20,
              ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
