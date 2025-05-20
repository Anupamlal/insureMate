import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppPersonImageWidget extends StatelessWidget {

  final VoidCallback profileImageTap;
  final String currentUserImage;
  final double width;

  const AppPersonImageWidget({super.key, required this.currentUserImage, required this.profileImageTap, this.width = 40});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipOval(
      child: Material(
        child: InkWell(
          onTap: profileImageTap,
          child: CachedNetworkImage(
            width: width,
            height: width,
            imageUrl: currentUserImage,
            fadeInDuration: Duration(microseconds: 0),
            fadeOutDuration: Duration(microseconds: 0),
            placeholder: (context, url) => CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: Icon(Icons.person, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

}