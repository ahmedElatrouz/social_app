import 'package:flutter/material.dart';

import 'package:social_app/model/Annonce.dart';
import 'package:social_app/model/Professionnel.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/services/annonceService.dart';
import 'package:social_app/services/professionelService.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/accueil/display_annonce.dart';
import 'package:social_app/view/shared/constants.dart';
import 'package:social_app/view/shared/progress.dart';


class ProProfilPage extends StatefulWidget {
  static const String id = 'proProfilPage';
  @override
  _ProProfilPageState createState() => _ProProfilPageState();
}

class _ProProfilPageState extends State<ProProfilPage> {
  Professionnel pro = Professionnel();
  bool isWaiting = false;
  bool isWaitingForAnnonces = false;
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
  String id = '';
  List<Widget> annoncesWidgets=[];
  @override
  initState() {
    super.initState();
    isWaiting = true;
    isWaitingForAnnonces = true;
    getProfileContent();
  }
  @override
  dispose(){
    isWaiting=false;
    super.dispose();
  }

  getProfileContent() async {
    pro = await professionelService.getCurrentPro();
    nom = pro.nom;
    prenom = pro.prenom;
    email = pro.email;
    nationalite = pro.nationalite;
    id = pro.proID;
    print(id);
    setState(() {
        isWaiting = false;
      });
    getProfilAnnonces();
        
  }

   getProfilAnnonces() async {
    //await annonceService.createAnnonce(Annonce(description: 'my first created annonce',proRef: pro.proID));
      List<Annonce> tempList=await annonceService.searchByUser(id);
      if(tempList.isNotEmpty)
    for(Annonce an in tempList){
      print('description:'+an.description);
      annoncesWidgets.add(DisplayAnnonce(annonce:an,prof: pro,userType: UserType.professionnel,));
    }
     setState(() {
       isWaitingForAnnonces=false;
     });
      
  }

  ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: isWaiting ? circularProgress() : buildProfileContent(context));
  }

  ListView buildProfileContent(BuildContext context) {
    return ListView(
      children: <Widget>[
        Stack(children: <Widget>[
          Column(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/Dance.jpg"),
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
            isWaitingForAnnonces?circularProgress():Container(
              child: Column(
                children: annoncesWidgets
              ),
            )
          ],
        )
      ],
    );
  }
}

