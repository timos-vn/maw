import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class ImageMessage extends StatelessWidget {
  const ImageMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45, // 45% of total width
      child: AspectRatio(
        aspectRatio: 1.6,
        child: SizedBox(
          height: 140,
          child: CachedNetworkImage(
            imageUrl: 'https://images8.alphacoders.com/582/582746.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}