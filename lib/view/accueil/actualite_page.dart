


import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/model/Post.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/services/postService.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/shared/reusable_header.dart';
final postRef = Firestore.instance.collection('Posts');

class ActualitePage extends StatefulWidget {

  static const String id = 'actualite_page';
  @override
  _ActualitePageState createState() => _ActualitePageState();
}

class _ActualitePageState extends State<ActualitePage> {

  Talent talent;
  List<Post> usersPosts=[];
  List<PostWidget> postWidgets=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getUserAndPosts();
  }
  /*getUserAndPosts()async{
    talent=await TalentService().getCurrentUser();
    var doc=await postRef.getDocuments();

    List<Post> posts=doc.documents.map((doc)=>Post.fromMap(doc.data)).toList();
    for(Post post in posts){
      usersPosts.add(post);
    }
    generateList();
    
  }*/
  generateList()async{
    for(Post post in usersPosts){
      //Talent poster=await TalentService().searchById(post.talentId);
      postWidgets.add(PostWidget(post: post,/*poster: poster,*/context: context,));
    }
  }
  @override
  Widget build(BuildContext context) {
    return  //Center(child: Text("actualite"));
    
     Scaffold(
      appBar: header(context,"actualite"),
      backgroundColor: Color(0xFFFFFFFF),
      body:ListView(
        children:postWidgets
      ) /*Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(child: Text('hello',style: TextStyle(color:Colors.black),)),
             /* Container(
                child:Icon(Icons.image)
              ),
              Container(
                child: TextField(),
              ),
              Container(
                child:Icon(Icons.whatshot)
              ),
              Container(
                child:Icon(Icons.photo)
              ),
*/
            ]
          ),
          Container(
            child: Center(
              child: Text(
                'actualite',
                style: TextStyle(
                  fontSize:20,
              ),
              ),
            ),
          ),
        ],
      ),*/
    );
  }







}

class PostWidget extends StatelessWidget {
  final Post post;
   Talent poster=Talent(nom:'ahmed',prenom:'elatrouz',);

   PostWidget({
    @required this.post,
    //@required this.poster,
    @required this.context, 
  }) ;
  

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return
      Container(
        margin: EdgeInsets.symmetric(horizontal:20),
        decoration: BoxDecoration(
          color: Color(0xFFF0F0F0),
          border:Border.all(color: Colors.blueGrey,width: 1 ),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Padding(
        padding: EdgeInsets.all(20),
        child: InkWell(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(
                    poster.photo,
                  ),
                ),

                contentPadding: EdgeInsets.all(0),
                title: Text(
                  poster.nom+poster.prenom,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  post.description,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 11,
                  ),
                ),
              ),

              Container(
                foregroundDecoration: BoxDecoration(
                borderRadius:BorderRadius.all(Radius.circular(30)),
                ),
                decoration: BoxDecoration(
                  
                ),
                child:post.photoUrl!=null?CachedNetworkImageProvider(post.photoUrl):Image.asset(
                  'assets/images/ahmed.jpg',
                  
                  height: 170,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
            
            ],
          ),
          onTap: (){},
        ),
    ),
    
      );
    
  }
}
