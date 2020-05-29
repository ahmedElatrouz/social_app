import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/profil/profil_page.dart';
import 'package:social_app/view/shared/constants.dart';

class ProfileCard extends StatefulWidget {
  final Talent talent;

  const ProfileCard({Key key, this.talent}) : super(key: key);

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  void _showDialog(context) {
    bool isWaiting=false;
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return ModalProgressHUD(
                  child: AlertDialog(
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
                child: Text("Valider "+widget.talent.nom+"?",style: TextStyle(
                  color:Colors.green
                ),),
                onPressed: ()async {
                  setState(() {
                    isWaiting=true;
                  });
                  
                  widget.talent.isValidated=true;
                 await  TalentService().updateTalent(widget.talent);
                 setState(() {
                    isWaiting=false;
                  });
                  
                 Navigator.of(context).pop();
                }),
               FlatButton(
                child: Text("Annuler"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
               
            ],
          ), inAsyncCall: isWaiting,
        );
      },
    );
  }

  goToProfile(context){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfilPage(
                  poster: widget.talent,visitor: UserType.admin,
                )));
  }

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
          widget.talent.nom+' '+widget.talent.prenom,
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
          widget.talent.nationalite,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 15
            ),
          
          ),
          Text(
          widget.talent.email,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 15
            ),
          
          ),
          
    ],)
        ),
       if(!widget.talent.isValidated) Container(
    width: MediaQuery.of(context).size.width/4,
    height: MediaQuery.of(context).size.height,
    color: Colors.greenAccent,
    child:Center(child: GestureDetector(
      onTap: ()=>_showDialog(context),
      child: Text('Valider')))
        )

      ]
    ),
        );
  }
}