
import 'package:flutter/material.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/admin/profile_detail.dart';
import 'package:social_app/view/profil/profil_page.dart';
import 'package:social_app/view/shared/profile_card.dart';
import 'package:social_app/view/shared/progress.dart';



class ProfilesPage extends StatefulWidget {
  final bool validatedProfiles;

  const ProfilesPage({@required this.validatedProfiles});
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
    talents=await talentService.searchByIsValidated(widget.validatedProfiles);
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



