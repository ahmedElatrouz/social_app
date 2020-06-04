







import 'package:flutter/material.dart';

import 'package:social_app/model/Talent.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/authenticate/authenticate.dart';
import 'package:social_app/view/authenticate/login_page.dart';
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

  Widget textField(){
    String label;
    switch (setting) {
      
      case settings.editProfil:
        // TODO: Handle this case
        break;
      case settings.editEmail:
        label='addresse email';
        break;
      case settings.editTel:
        label='numero du telephone';
        break;
      case settings.editPassword:
       label='mot de passe';
        break;
      case settings.accesPrive:
        // TODO: Handle this case.
        break;
    }
     return Container(
                width: 220,
                     child: TextFormField(
                       obscureText: setting==settings.editPassword,
                       keyboardType:setting==settings.editPassword? TextInputType.emailAddress:TextInputType.text,
                       validator:(String value){
                         if (value.length == 0) {
                          return "Entrez votre $label";
                          }return null;
                       },
                       onSaved: (String value){
                         assignValue(value);
                          },
                        initialValue:initialValue(),
                      ),
                  
                  );

  }



 String initialValue(){
     switch (setting) {
      
      case settings.editProfil:
        // TODO: Handle this case
        break;
      case settings.editEmail:
        return talent.email;
        break;
      case settings.editTel:
        return  talent.tel;
        break;
      case settings.editPassword:
       return  talent.password;
        break;
      case settings.accesPrive:
        // TODO: Handle this case.
        break;
        default:return 'NaN';
    }
  }

  Widget profilWidget(){
    return Container(

    );
  }

  Widget settingWidget(context){
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
                margin: EdgeInsets.all(20),
                child: Text(
                  'pour des raisons de securité votre compte va se deconnecter apres la modification !!',
                  style: TextStyle(color:Colors.red),),
              ),
              Container(
                width: 220,
                     child: textField(),
                  
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
                             updateTalent(context);
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

  updateTalent(context)async{
   int r=await  TalentService().updateTalent(talent);
   if(r==1){
     //await TalentService().signOut();
     print( 'champ bien modifié !!');
     await TalentService().signOut();
     Navigator.popUntil(context,ModalRoute.withName(Authenticate.id));
   } 
   else print('champ non modifié!!') ;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kEditElementsText[setting][0]),
      ),
          body:SingleChildScrollView(child: settingWidget(context))//emailWidget()
    );
  }
}
