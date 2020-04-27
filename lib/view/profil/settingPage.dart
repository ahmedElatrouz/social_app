



import 'package:flutter/material.dart';

import 'package:social_app/model/Talent.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/shared/constants.dart';

class SettingPage extends StatelessWidget {

 Talent talent;
 bool isPasswordVerified=false;
 GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
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
        child: Form(
          key: this._formKey,
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:<Widget>[
              Container(
                width: 220,
                     child: TextFormField(
                       keyboardType: TextInputType.emailAddress,
                       validator:(String value){
                         if (value.length == 0) {
                          return "Entrez une addresse email";
                          }return null;
                       },
                       onSaved: (String value){
                         assignValue(value);
                         talent.email=value;
                                                },
                        initialValue:talent.email,
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
                    onPressed: (){
                        if (_formKey.currentState.validate()) {
                          if(_formKey.currentState.validate()){
                             _formKey.currentState.save();
                             updateTalent();
                          }
                         
                          }
                    }),
                  ),
                  
                  SizedBox(
                    height:200,
                  )
            ]
          ),
        ),
      ) ,
      );
  }

  assignValue(var value){
       switch (setting) {
      
      case settings.editProfil:
        // TODO: Handle this case
        break;
      case settings.editEmail:
        talent.email=value;
        break;
      case settings.editTel:
        talent.tel=value;
        break;
      case settings.editPassword:
        talent.password=value;
        break;
      case settings.accesPrive:
        // TODO: Handle this case.
        break;
    }
  }

  updateTalent()async{
   int r=await  TalentService().updateTalent(talent);
   if(r==1){
     //await TalentService().signOut();
     return 'champ bien modifié !!';
   } 
   else return 'champ non modifié!!';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kEditElementsText[setting][0]),
      ),
          body:SingleChildScrollView(child: emailWidget())//emailWidget()
    );
  }
}
