import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/repository/talentAuth.dart';
import 'package:social_app/services/postService.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/shared/constants.dart';
import 'package:social_app/view/shared/progress.dart';
import 'package:video_player/video_player.dart';

class UploadPost extends StatefulWidget {
  final witchPost post;
  final bool profilPic;
  final bool firstPost;
  final bool newPost;
  final String nom;
  UploadPost({this.profilPic, this.nom, this.firstPost,this.newPost,this.post});

  @override
  _UploadPostState createState() => _UploadPostState();
}

class _UploadPostState extends State<UploadPost> {
  
  TalentService talentService = TalentService();
  PostService postService = PostService();
  TalentAuth talentAuth = TalentAuth();
  Talent talent = Talent();
  String photoUrl = '';
  File image;
  File video;

  VideoPlayerController videoPlayerController;

  TextEditingController captionController = TextEditingController();
  bool isUploading = false;

  addImage() async {
    Navigator.pop(context);
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      this.image = image;
    });
    print(image);
  }

  addVideo() async {
    Navigator.pop(context);
    File video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    this.video = video;
    videoPlayerController = VideoPlayerController.file(video)
      ..initialize().then((_) {
        setState(() {});
        videoPlayerController.play();
      });
  }

  selectPost(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(
              widget.post == witchPost.profilePic ? 'add profil picture' : 'create post',
            ),
            children: <Widget>[
              SimpleDialogOption(
                child: Text('add an image'),
                onPressed: () => addImage(),
              ),
              if (widget.post != witchPost.profilePic)
                SimpleDialogOption(
                  child: Text('add a video'),
                  onPressed: () => addVideo(),
                )
            ],
          );
        });
  }

  Container buildSplashScrean() {
    return Container(
      color: Color(0xFF009688),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            'assets/images/upload.svg',
            height: 260,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Text('Upload post',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              color: Colors.deepOrange,
              onPressed: () => selectPost(context),
            ),
          )
        ],
      ),
    );
  }

  clearPost() {
    setState(() {
      image = null;
    });
  }

  handleSubmit() async {
    setState(() {
      isUploading = true;
    });
    if (image != null) {
      await postService.handleSubmitImage(image, captionController, talent.uid);
    }
    if (video != null) {
      print('video');
      await postService.handleSubmitVideo(video, captionController, talent.uid);
    }
    captionController.clear();

    setState(() {
      image = null;
      isUploading = false;
    });
  }

  handleSubmitProfileImage() async {
    setState(() {
      isUploading = true;
    });
    if (image != null) {
      await talentService.handleSubmitProfileImage(image, talent.uid);
    }
    setState(() {
      image = null;
      isUploading = false;
    });
  }

  handleSunmitFirstPost() async {
    String mediaUrl;
    setState(() {
      isUploading = true;
    });
    if (image != null) {
      mediaUrl = await talentAuth.handleSubmitFirstPost(image, widget.nom);
    }
    if (video != null) {
      mediaUrl = await talentAuth.handleSubmitFirstPost(image, widget.nom);
    }

    setState(() {
      image = null;
      isUploading = false;
    });
    Navigator.pop(context, mediaUrl);
  }

  Scaffold buildUploadForm() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: clearPost,
        ),
        title: Text(widget.post == witchPost.profilePic ? 'profile pic' : 'caption post',
            style: TextStyle(color: Colors.black)),
        actions: [
          if (widget.post != witchPost.firstPost)
            FlatButton(
              child: Text( widget.post == witchPost.profilePic ? 'Done' : 'Post',
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              onPressed: widget.post == witchPost.profilePic // isUploading
                  ? () => handleSubmitProfileImage()
                  : () => handleSubmit(),
            )
        ],
      ),
      body: ListView(
        children: <Widget>[
          isUploading ? linearProgress() : Text(''),
          if (image != null)
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 16 / 16,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 4,
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(image),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (video != null)
            videoPlayerController.value.initialized
                ? Container(
                    //height: 300,
                    // width: MediaQuery.of(context).size.width * 0.8,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: videoPlayerController.value.aspectRatio,
                        child: VideoPlayer(videoPlayerController),
                      ),
                    ),
                  )
                : Container(),
          SizedBox(
            height: 8,
          ),
          if (widget.post == witchPost.newPost)
            ListTile(
              leading: CircleAvatar(
              backgroundImage: photoUrl != ''
                  ? CachedNetworkImageProvider(photoUrl)
                  : AssetImage('assets/images/user_icon.png'),
                backgroundColor: Colors.blueGrey,
              ),
              title: Container(
                width: 250,
                child: TextField(
                  controller: captionController,
                  decoration: InputDecoration(
                    hintText: "write a discription...",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          if (widget.post == witchPost.firstPost)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
              child: RaisedButton(
                onPressed: () {
                  handleSunmitFirstPost();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Text('Done',
                    style: TextStyle(fontSize: 20.0, color: Colors.white)),
              ),
            )
        ],
      ),
    );
  }

  checkTalent() async {
    talent = await talentService.getCurrentUser();
    photoUrl = talent.photoProfile;
    print(photoUrl);
  }

  @override
  void initState() {
    checkTalent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return image == null ? buildSplashScrean() : buildUploadForm();
  }
}
