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