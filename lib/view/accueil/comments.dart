import 'package:flutter/material.dart';

class Comments extends StatefulWidget {
  final String annonceID;
  final String proId;
  Comments({@required this.proId,@required this.annonceID});
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  String annonceID = 'nan';
  String proID = 'nan';

  @override
  void initState() {
    annonceID = widget.annonceID;
    proID = widget.proId;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Comments'),),
    );
  }
}