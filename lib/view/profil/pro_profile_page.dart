import 'package:flutter/material.dart';
import 'package:social_app/model/Professionnel.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/services/professionelService.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/shared/progress.dart';

class ProProfilPage extends StatefulWidget {
  static const String id = 'proProfilPage';
  @override
  _ProProfilPageState createState() => _ProProfilPageState();
}

class _ProProfilPageState extends State<ProProfilPage> {
  Professionnel pro=Professionnel();
  bool isWaiting=false;
  ProfessionelService professionelService=ProfessionelService();
  Talent talent=Talent();
  TalentService talentService=TalentService();
   String nom = 'NaN';
  String prenom = 'NaN';
  String email = '';
  String nationalite = '';
  String description = '';
  String photoUrl = ' ';
  
    @override
  initState() {
    super.initState();
    isWaiting = true;
    getProfileContent();
  }

  getProfileContent() async {
   
     
     pro = await professionelService.getCurrentUser();
// pro = await professionelService.getCurrentUser();
 
    if(pro.nom!=null)nom = pro.nom;
    nom = pro.nom;
    prenom = pro.prenom;
    email = pro.email;
    nationalite = pro.nationalite;
    setState((){
    isWaiting=false;
   });                   
   
  }

 /* getProfilAnnonces() async {
    try {
      annonces = await postService.getProfilPosts(talent.uid, postCount);
      postCount = posts.length;
      setState(() {
        isWaiting = false;
      });
    } catch (e) {
      print(e);
    }
  }
*/
  ScrollController controller;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body:isWaiting?circularProgress(): buildProfileContent(context));
  }

  ListView buildProfileContent(BuildContext context) {
    return ListView(
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
                nom + ' '+prenom,
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              ),


              SizedBox(height: 7.0),



              Text(
                nationalite,
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
      );
  }
}

