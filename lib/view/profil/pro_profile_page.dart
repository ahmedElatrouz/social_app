import 'package:flutter/material.dart';

import 'package:social_app/model/Annonce.dart';
import 'package:social_app/model/Professionnel.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/services/annonceService.dart';
import 'package:social_app/services/professionelService.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/shared/progress.dart';

List<Annonce> annonces = [
  Annonce(
      date: DateTime.now(),
      description: 'Opportunité pour rejoindre les acteurs de Breaking bad'),
       Annonce(
      date: DateTime.now(),
      description: 'Working with picasso!')
];

class ProProfilPage extends StatefulWidget {
  static const String id = 'proProfilPage';
  @override
  _ProProfilPageState createState() => _ProProfilPageState();
}

class _ProProfilPageState extends State<ProProfilPage> {
  Professionnel pro = Professionnel();
  bool isWaiting = false;
  ProfessionelService professionelService = ProfessionelService();
  Talent talent = Talent();
  TalentService talentService = TalentService();
  AnnonceService annonceService=AnnonceService();
  String nom = 'NaN';
  String prenom = 'NaN';
  String email = '';
  String nationalite = '';
  String description = '';
  String photoUrl = ' ';
  List<Widget> annoncesWidgets=[];
  @override
  initState() {
    super.initState();
    isWaiting = true;
    getProfileContent();
  }

  getProfileContent() async {
    pro = await professionelService.getCurrentUser();
    nom = pro.nom;
    prenom = pro.prenom;
    email = pro.email;
    nationalite = pro.nationalite;
    for(Annonce an in annonces){
annoncesWidgets.add(AnnonceWidget(annonce:an));

    }
        setState(() {
      isWaiting = false;
    });
  }

   /*getProfilAnnonces() async {
    try {
      annonces = await annonceService;
      postCount = posts.length;
      setState(() {
        isWaiting = false;
      });
    } catch (e) {
      print(e);
    }
  }*/

  ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: isWaiting ? circularProgress() : buildProfileContent(context));
  }

  ListView buildProfileContent(BuildContext context) {
        for(Annonce an in annonces){
annoncesWidgets.add(AnnonceWidget(annonce:an));

    }
    return ListView(
      children: <Widget>[
        Stack(children: <Widget>[
          Column(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/back.jpg"),
                    fit: BoxFit.cover),
              ),
              height: MediaQuery.of(context).size.height / 6,
            ),
            SizedBox(height: 10.0),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                nom + ' ' + prenom,
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              ),
            ),
          ]),
          Positioned(
            width: 320.0,
            top: MediaQuery.of(context).size.height / 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 20),
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        image: DecorationImage(
                            image: AssetImage('assets/images/3.jpg'),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(blurRadius: 7.0, color: Colors.black)
                        ])),
              ],
            ),
          ),
        ]),
        Column(
          children: <Widget>[
            SizedBox(height: 3.0),
            Text(
              nationalite,
              style: TextStyle(
                  fontSize: 15.0,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Montserrat'),
            ),
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              //height: 200,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              padding: EdgeInsets.all(20),
              child: Text(
                '   My name is ahmed and I am watching better call saul, my best serie is breaking bad, '
                'I don\'t like game of thrones that much. Favorite anime is hunter x hunter + attack on titan.',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            /*Container(
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
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Signatra',
                    fontSize: 30),
              ),
            ),*/
            SizedBox(height: 10.0),
            Column(
              children: annoncesWidgets
            )
          ],
        )
      ],
    );
  }
}

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
                  child: Text(
                  widget.annonce.date.day.toString()+'/'+widget.annonce.date.month.toString()+'/'+widget.annonce.date.year.toString(),
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
            child: Text(widget.annonce.description)
            ),
        ],
      ),
    );
  }
}
