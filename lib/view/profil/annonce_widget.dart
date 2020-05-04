


import 'package:flutter/material.dart';
import 'package:social_app/model/Annonce.dart';

class AnnonceWidget extends StatefulWidget {
  

  final Annonce annonce;
  const AnnonceWidget({
    Key key,
    this.annonce,
  }) : super(key: key);

  @override
  _AnnonceWidgetState createState() => _AnnonceWidgetState();
}

class _AnnonceWidgetState extends State<AnnonceWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.symmetric(vertical: 1,horizontal: 0) ,
      decoration: BoxDecoration(
      color: Colors.white70,
      border:Border(bottom:BorderSide(color:Colors.grey[300],width: 2),top:BorderSide(color:Colors.grey[300],width: 2)),

     // borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
      padding: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(right:20,bottom: 20),
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/3.jpg'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(
                          Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 7.0,
                            color: Colors.black)
                      ])),
              Column(
                crossAxisAlignment: 
                  CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                  'nom' +' '+'prenom',
                  style: TextStyle(fontSize:18),
                  textAlign: TextAlign.start,),
                  Container(
                  child: Text('time',
                  //widget.annonce.date.day.toString()+'/'+widget.annonce.date.month.toString()+'/'+widget.annonce.date.year.toString(),
                  style: TextStyle(fontSize:12),
                  textAlign: TextAlign.start,),
              ),
                ],
              ),
              
              
            ],
          ),
          
          Container(
            width: MediaQuery.of(context).size.width-20,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              border:Border.all(color:Colors.grey[700],width: 0.5),
              borderRadius: BorderRadius.all(
                          Radius.circular(2.0)),
            ),
            child:widget.annonce.description!=null?Text(widget.annonce.description):Text("NaN")
            ),
        ],
      ),
    );
  }
}
