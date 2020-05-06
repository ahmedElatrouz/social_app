import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/shared/custom_image.dart';
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
      te.add(Text(t.prenom));
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
        automaticallyImplyLeading:false,
        backgroundColor:Colors.white,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body:isWaiting?circularProgress():ListView(
        children:profileCards
      ) ,
    );
  }
}



class ProfileCard extends StatelessWidget {
  final Talent talent;

  const ProfileCard({Key key, this.talent}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
                          Radius.circular(20.0)),
                          color: Colors.purple,
      ),
      
      margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
      height: 100,
      child: Row(
        children:<Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              
              borderRadius: BorderRadius.all(
                          Radius.circular(20.0)),
              //color: Colors.black,
              image: DecorationImage(image: AssetImage('assets/images/3.jpg'),fit: BoxFit.cover,)
              
            ),
            
            
            width:MediaQuery.of(context).size.width/3,
          ),
        ]
      ),
    );
  }
}