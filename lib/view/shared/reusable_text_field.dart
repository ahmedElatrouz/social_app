import 'package:flutter/material.dart';

class CreateField extends StatelessWidget {
  final Function change;
  final String fieldName;

  CreateField({@required this.change, @required this.fieldName});
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
      style: TextStyle(fontSize: 17,color: Colors.black, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        border: UnderlineInputBorder(),//OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        labelText: fieldName,
      ),
      onChanged: change,
    );
  }
}

class CreateLogInField extends StatelessWidget {
  final Function onChange;
  final String type;

  CreateLogInField({@required this.type, @required this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.purple,
      maxLines: 1,
      keyboardType:
          type == "Email" ? TextInputType.emailAddress : TextInputType.text,
      autofocus: false,
      onChanged: onChange,
      //validator: (val) => val.isEmpty || val.length<6 ? 'can\'t be empty' : null,
      obscureText: type == "Email" ? false : true,
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.purple)),
          focusColor: Colors.black,
          fillColor: Colors.black,
          hoverColor: Colors.black,
          hintText: type,
          hintStyle: TextStyle(color: Colors.black38),
          icon: Icon(
            type == "Email" ? Icons.mail : Icons.lock,
            color: Colors.grey,
            size: 20,
          ),
          border: UnderlineInputBorder()),
          
          
    );
  }
}
