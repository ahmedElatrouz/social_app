import 'package:flutter/material.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/profil/profil_page.dart';
import 'package:social_app/view/shared/constants.dart';

class ProfileCard extends StatelessWidget {
  final Talent talent;

  void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Row(
            children: <Widget>[
              Icon(Icons.delete_sweep),
              Text('Attention!!!'),
            ],
          ),
          content: Container(
            padding: EdgeInsets.all(7),
            child:Text('Etes-vous sure?') ,
            ),
          
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: new Text("Oui, je suis sur",style: TextStyle(
                color:Colors.red
              ),),
              onPressed: () {
                TalentService().deleteTalent(talent.uid);
              }),
             FlatButton(
              child: new Text("Annuler"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
             
          ],
        );
      },
    );
  }

  goToProfile(context){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfilPage(
                  poster: talent,visitor: UserType.admin,
                )));
  }




  const ProfileCard({Key key, this.talent}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
    borderRadius: BorderRadius.all(
                      Radius.circular(5.0)),
                      color: Colors.white,
        ),
        
        margin: EdgeInsets.fromLTRB(5, 4, 5, 0),
        height: 100,
        child: Row(
    children:<Widget>[
      GestureDetector(
        onTap:()=> goToProfile(context),
              child: Container(
          margin: EdgeInsets.only(right:10),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            
            borderRadius: BorderRadius.only(topLeft:
                       Radius.circular(5.0),bottomLeft:Radius.circular(5.0) ),
            //color: Colors.black,
            image: DecorationImage(image: AssetImage('assets/images/3.jpg'),fit: BoxFit.cover,)
            
          ),
          
          
          width:MediaQuery.of(context).size.width/5,
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width/2.1,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              talent.nom+' '+talent.prenom,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 15
                ),
              
              ),
              Text(
              'categorie',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 15
                ),
              
              ),
              Text(
              talent.nationalite,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 15
                ),
              
              ),
              Text(
              talent.email,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 15
                ),
              
              ),
              
        ],)
      ),
      Container(
        width: MediaQuery.of(context).size.width/4,
        height: MediaQuery.of(context).size.height,
        color: Colors.red[200],
        child:Center(child: GestureDetector(
          onTap: ()=>_showDialog(context),
          child: Text('Supprimer')))
      )

    ]
        ),
      );
  }
}