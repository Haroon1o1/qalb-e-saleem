import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageBuilder extends StatelessWidget {
  String imagePath;
   ImageBuilder({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Platform.isIOS
              ? Image.network(
                  imagePath,
                  height: 150,
                  width: MediaQuery.of(context).size.width * 0.87,
                  fit: BoxFit.fill,
                )
              : CachedNetworkImage(
                  imageUrl: imagePath,
                  width: MediaQuery.of(context).size.width * 0.87,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Container(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
    );
  }
  }
