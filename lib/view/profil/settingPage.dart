



import 'package:flutter/material.dart';

import 'package:social_app/model/Talent.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/shared/constants.dart';

class SettingPage extends StatelessWidget {

 Talent talent;
final settings setting;
   SettingPage({
    @required this.talent,
    @required this.setting,
  }) ;


  
  getUser()async{
    talent=await TalentService().getCurrentUser();
  }

  Widget emailWidget(){
    return Container(
      
      
      decoration: BoxDecoration(

      ),
      child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:<Widget>[
            Container(
              width: 220,

                   child: TextFormField(
                      initialValue:talent.email
                    ),
                
                ),
                SizedBox(
                  height:20,
                ),
              Container(
                child: RaisedButton(
                  color: Colors.lightBlueAccent,
                  textColor: Colors.white,
                  child: Text('save'),
                  onPressed: ()=>print('on pressed')),
                ),
                SizedBox(
                  height:200,
                )
          ]
        ),
      ) ,
      );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kEditElementsText[setting][0]),
      ),
          body:emailWidget()//emailWidget()
    );
  }
}
