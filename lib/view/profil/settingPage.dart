

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/view/shared/constants.dart';






class SettingPage extends StatelessWidget {

final Talent talent;
final settings setting;

  const SettingPage({@required this.talent,@required this.setting});
  


  Widget emailWidget(){
    return Container(
      decoration: BoxDecoration(

      ),
      child:Column(
        children:<Widget>[
          Container(
            child: TextFormField(
              initialValue:talent.email
            )
            ),
        ]
      ) ,
      );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kEditElementsText[setting][0]),
      ),
          body: Text('hello')//emailWidget()
    );
  }
}