import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/shared/progress.dart';
import 'package:social_app/view/shared/reusable_header.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {

bool isWaiting=true;
Talent talent=new Talent(nom:'NaN',email:'NaN');
TalentService talentService;


  @override
  initState(){
    super.initState();
    talentService=TalentService();
    getTalent();
  }

  getTalent()async{
    
    try{
      talent=await talentService.getCurrentUser();
    }catch(e){
      print(e);
    }
    
    
    setState(() {
      isWaiting=false;
    });
  }
  Widget profileView(){
    
   return  ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF009688),
                
                borderRadius: new BorderRadius.only(
                    bottomLeft:  const  Radius.circular(60.0),
                    bottomRight: const  Radius.circular(60.0))
              ),
              
              child: Column(children: <Widget>[
                SizedBox(
                  height: 3,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/3.jpg'),
                  radius: 60,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(talent.nom,
                    style:
                        TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                Text(talent.email,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38)),    
                Text('Category',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45)),
                SizedBox(
                  height: 8,
                )
                
              ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text('new post',style: TextStyle(fontSize: 25),),
                  ),
                  )
              ],
            ),

            Text(
              'Posts',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),
            ),
            Container(
              child: Wrap(
                children: <Widget>[
                  for (int i = 0; i < 10; i++)
                    Container(
                      height: MediaQuery.of(context).size.width / 3,
                      width: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/images/3.jpg'),
                        fit: BoxFit.cover,
                      )),
                    )
                ],
              ),
            )
          ],
        );
  }

  
  @override
  Widget build(BuildContext context) {
   
   return Scaffold(
     appBar: header(context, "profil"),
     body:isWaiting?circularProgress():profileView()
     
     );
     
  }

}