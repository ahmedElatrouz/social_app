import 'package:flutter/material.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/admin/profile_detail.dart';
import 'package:social_app/view/shared/progress.dart';



class ProfilesPage extends StatefulWidget {
  @override
  _ProfilesPageState createState() => _ProfilesPageState();
}

class _ProfilesPageState extends State<ProfilesPage> {
  TalentService talentService=TalentService();
  List<Talent> talents=[];
  bool isWaiting=false;
  List<Text> te=[];
  List<ProfileCard> profileCards=[];
  @override
  initState(){
    super.initState();
    isWaiting=true;
    getAllUsers();
  }

  getAllUsers()async{
    talents=await talentService.searchByName('a');
    for(Talent t in talents){
  profileCards.add(ProfileCard(talent: t,));
    }
          
    setState(() {
      isWaiting=false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Profiles'),
        automaticallyImplyLeading:false,
        backgroundColor:Colors.purple[300],
       // elevation: 0.0,
      ),
      backgroundColor: Colors.grey[200],
      body:isWaiting?circularProgress():ListView(
        
        children:profileCards,
      ) ,
    );
  }
}



class ProfileCard extends StatelessWidget {
  final Talent talent;

  const ProfileCard({Key key, this.talent}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap:(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileDetail(talent: talent,)));
        } ,
          child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
                            Radius.circular(5.0)),
                            color: Colors.white,
        ),
        
        margin: EdgeInsets.fromLTRB(5, 4, 5, 0),
        height: 100,
        child: Row(
          children:<Widget>[
            Container(
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
            Container(
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
            )

          ]
        ),
      ),
    );
  }
}