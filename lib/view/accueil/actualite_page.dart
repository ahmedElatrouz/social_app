

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
      appBar: header(context,"actualite"),
      backgroundColor: Color(0xFFFFFFFF),
      body:ListView(
        children: <Widget>[
          SizedBox(
              height:10,
            ),
          postWidget(),
          SizedBox(
              height:10,
            ),
          postWidget(),
          SizedBox(
              height:10,
            ),
          postWidget(),
        ],
      ) /*Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(child: Text('hello',style: TextStyle(color:Colors.black),)),
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
      ),*/
    );
  }







  Widget postWidget(){
    return
      Container(
        margin: EdgeInsets.symmetric(horizontal:20),
        decoration: BoxDecoration(
          color: Color(0xFFF0F0F0),
          border:Border.all(color: Colors.blueGrey,width: 1 ),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Padding(
        padding: EdgeInsets.all(20),
        child: InkWell(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/images/ahmed.jpg",
                  ),
                ),

                contentPadding: EdgeInsets.all(0),
                title: Text(
                  "ahmed lbastos",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  "marrakech,lbit diali",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 11,
                  ),
                ),
              ),

              Container(
                foregroundDecoration: BoxDecoration(
                borderRadius:BorderRadius.all(Radius.circular(30)),
                ),
                decoration: BoxDecoration(
                  
                ),
                child: Image.asset(
                  "assets/images/ahmed.jpg",
                  height: 170,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
            
            ],
          ),
          onTap: (){},
        ),
    ),
    
      );
    
  }







}
