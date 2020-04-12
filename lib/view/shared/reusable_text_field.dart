import 'package:flutter/material.dart';


class CreateField extends StatelessWidget {

  final Function change;
  final String fieldName;

  CreateField({@required this.change,@required this.fieldName});
  @override
  Widget build(BuildContext context) {
    
   return TextFormField(
     //si on est dans l'email field on change le clavier vers le type email
     keyboardType: fieldName == "Email"
         ? TextInputType.emailAddress
         : TextInputType.text,
     //si on est dans le field password l'ecriture devient obscure (pour que personne ne voit le password)
     obscureText: fieldName == "Password",
     validator: (val) => val.isEmpty ? 'cant be empty' : null,
     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
     decoration: InputDecoration(
       border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
       labelText: fieldName,
     ),
     onChanged: change,
   );
 }
}




class CreateLogInField extends StatelessWidget {

  final Function onChange;
  final String type;

  CreateLogInField({ @required this.type , @required this.onChange });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
  
  maxLines: 1,
  keyboardType: type == "Email" ? TextInputType.emailAddress : TextInputType.text,
  autofocus: false,
  onChanged: onChange,
  //validator: (val) => val.isEmpty || val.length<6 ? 'can\'t be empty' : null,
  obscureText: type == "Email" ? false : true,
  style: TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold),
  decoration: InputDecoration(
      hintText: type,
      hintStyle: TextStyle(color: Colors.black26),
      icon: Icon(
        type == "Email" ? Icons.mail : Icons.lock,
        color: Colors.grey,
        size: 35,
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30))),

   );
  }
}
