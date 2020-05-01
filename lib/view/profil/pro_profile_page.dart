import 'package:flutter/material.dart';

class ProProfilPage extends StatefulWidget {
  @override
  _ProProfilPageState createState() => _ProProfilPageState();
}

class _ProProfilPageState extends State<ProProfilPage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image:DecorationImage(image: AssetImage("assets/images/back.jpg"),fit:BoxFit.cover),
              ),
              height: MediaQuery.of(context).size.height / 4,
              child: Stack(children: <Widget>[
               /* ClipPath(
                  child: Container(color: Colors.black.withOpacity(0.8)),
                  clipper: GetClipper(),
                ),*/
                Positioned(
                  width: 320.0,
                  top: MediaQuery.of(context).size.height / 13,
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              image: DecorationImage(
                                  image: AssetImage('assets/images/3.jpg'),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(35.0)),
                              boxShadow: [
                                BoxShadow(blurRadius: 7.0, color: Colors.black)
                              ])),
                    ],
                  ),
                )
              ]),
            ),

            Column(
              
              children: <Widget>[
                SizedBox(height: 10.0),


                Text(
                  'Ahmed elatrouz',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),


                SizedBox(height: 7.0),



                Text(
                  'Morocco',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Montserrat'),
                ),


                SizedBox(height: 5.0),


                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  //height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'my name is ahmed and I am watching better call saul, my best serie is breaking bad, '
                    'I don\'t like game of thrones that much. Favorite anime is hunter x hunter + attack on titan.',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),


                SizedBox(height: 10.0),
                

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                   padding: EdgeInsets.symmetric(horizontal: 20),
                    // height: 1000,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  child: Text(
                    'Categorie: Music',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight:FontWeight.w500,
                      fontFamily: 'Signatra',
                      fontSize: 30
                    ),),
                  ),


                  SizedBox(height: 10.0),
                
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    // height: 1000,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: <Widget>[
                        for (int i = 0; i < 200; i++) Text('hello'),
                      ],
                    ))
              ],
            )
          ],
        ));
  }
}

class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width + 125, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
