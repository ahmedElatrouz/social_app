import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

 Widget cachedNetworkImage(String mediaUrl,context){
   return CachedNetworkImage(
     height: MediaQuery.of(context).size.height,
     imageUrl: mediaUrl,
     fit: BoxFit.contain,
     placeholder: (contect, url) =>
     Padding(
       child: CircularProgressIndicator(),
       padding: EdgeInsets.all(20),
     ),
     errorWidget: (context,url,error)=>
     Icon(Icons.error),
   );
 }