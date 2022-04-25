import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    final clipCenterY = size.height * 0.1;
    double clipCenterY2 = size.height * 0.3;
    double clipCenterY3 = size.height * 0.5;
    double clipCenterY4 = size.height * 0.7;
    double clipCenterY5 = size.height * 0.9;


    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(0),
    ));


    final clipPath = Path();

    clipPath.addOval(Rect.fromCircle(
      center: Offset(0, clipCenterY),
      radius: 6,
    ));

    clipPath.addOval(Rect.fromCircle(
      center: Offset(4, clipCenterY),
      radius: 6,
    ));

    clipPath.addOval(Rect.fromCircle(
      center: Offset(0, clipCenterY2),
      radius: 6,
    ));

    clipPath.addOval(Rect.fromCircle(
      center: Offset(4, clipCenterY2),
      radius: 6,
    ));

    clipPath.addOval(Rect.fromCircle(
          center: Offset(0, clipCenterY3),
          radius: 6,
        ));

        clipPath.addOval(Rect.fromCircle(
          center: Offset(4, clipCenterY3),
          radius: 6,
        ));

        clipPath.addOval(Rect.fromCircle(
          center: Offset(0, clipCenterY4),
          radius: 6,
        ));

        clipPath.addOval(Rect.fromCircle(
          center: Offset(4, clipCenterY4),
          radius: 6,
        ));

        clipPath.addOval(Rect.fromCircle(
          center: Offset(0, clipCenterY5),
          radius: 6,
        ));

        clipPath.addOval(Rect.fromCircle(
          center: Offset(4, clipCenterY5),
          radius: 6,
        ));

    final ticketPath = Path.combine(
      PathOperation.reverseDifference,
      clipPath,
      path,
    );

    return ticketPath;
  }

  @override
  bool shouldReclip(TicketClipper oldClipper) => false;
}