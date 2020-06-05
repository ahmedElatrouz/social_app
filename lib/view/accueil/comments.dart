import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/model/Commentaire.dart';
import 'package:social_app/model/Notification.dart';
import 'package:social_app/model/Professionnel.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/repository/commentaireRepositoryImpl.dart';
import 'package:social_app/services/commentaireService.dart';
import 'package:social_app/services/notificationService.dart';
import 'package:social_app/services/professionelService.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/shared/constants.dart';
import 'package:social_app/view/shared/progress.dart';
import 'package:social_app/view/shared/reusable_header.dart';
import 'package:timeago/timeago.dart' as timeago;

class Comments extends StatefulWidget {
  final UserType userType;
  final String annonceID;
  final String proID;
  Comments({this.proID, this.annonceID,@required this.userType});
  @override
  _CommentsState createState() => _CommentsState(
        annonceID: this.annonceID,
        proID: this.proID,
      );
}

class _CommentsState extends State<Comments> {
  CommentaireService commentaireService = CommentaireService();
  TextEditingController commentController = TextEditingController();
  final String annonceID;
  final String proID;
  _CommentsState({this.proID, this.annonceID});
  ProfessionelService proService = ProfessionelService();
  Professionnel pro;
  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    getCurrentPro();
  }

  getCurrentPro() async {
    pro = await proService.getCurrentPro();
    if (pro != null) print(pro.nom);
  }

  buildComment() {
    return StreamBuilder(
        stream:
            commentRef.where('annonce_ID', isEqualTo: annonceID).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }
          List<Comment> comments = [];
          snapshot.data.documents.forEach((doc) {
            comments.add(Comment.fromDocument(doc));
          });
          return ListView(
            children: comments,
          );
        });
  }

  addComment() async {
    Talent talent = await TalentService().getCurrentUser();
    Commentaire commentaire = Commentaire(
      annonceID: annonceID,
      contenue: commentController.text,
      date: DateTime.now(),
      talentID: talent.uid,
      nomTalent: talent.nom,
      photoProfile: talent.photoProfile,
    );
    int r = 0;
    r = await commentaireService.createCommentaire(commentaire);
    print(r);
    await addCommentToNotification(talent);
    if (r == 1) commentController.clear();
  }

  addCommentToNotification(talent) async {
    Notifications notif =new Notifications(
        date: DateTime.now(),
        talent: talent,
        annonceId: widget.annonceID,
        proId: widget.proID);
    int r = await notificationService.createNotification(notif);
    print(r);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, 'Comments', 'Commentaires'),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: buildComment(),
          ),
          Divider(),
          if (widget.userType==UserType.talent)
            ListTile(
              title: TextFormField(
                controller: commentController,
                decoration: InputDecoration(
                  hintText: 'Write a comment ...',
                ),
              ),
              trailing: FlatButton.icon(
                  onPressed: addComment,
                  icon: Icon(
                    Icons.send,
                    color: Colors.blueAccent,
                    size: 30,
                  ),
                  label: Text('')),
            )
        ],
      ),
    );
  }
}

class Comment extends StatelessWidget {
  final String nom;
  final String comment;
  final Timestamp date;
  final String photoProfile;

  Comment({this.comment, this.nom, this.date, this.photoProfile});

  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment(
      nom: doc['nomTalent'],
      comment: doc['contenue'],
      date: doc['date'],
      photoProfile: doc['photoProfile'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Row(
            children: <Widget>[
              Text(
                nom,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                timeago.format(date.toDate()),
                style: TextStyle(
                  color: Colors.black38,
                ),
              ),
            ],
          ),
          leading: CircleAvatar(
            backgroundImage: photoProfile != null
                ? CachedNetworkImageProvider(photoProfile)
                : AssetImage('assets/images/3.jpg'),
          ),
          subtitle: Text(
            comment,
            style: TextStyle(fontSize: 18),
          ),
        ),
        Divider(),
      ],
    );
  }
}
