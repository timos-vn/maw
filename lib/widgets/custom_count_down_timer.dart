import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CountDownTimer extends AnimatedWidget {
  CountDownTimer({Key? key, required this.animation}) : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '';

    return Row(
      children: [
        Container(
          height: 20,
          width: 30,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
            child: Center(
              child: Text(
                "${clockTimer.inHours.remainder(60).toString().padLeft(2, '0')}",
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4,right: 4),
          child: Text(':',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
        ),
        Container(
          height: 20,
          width: 30,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
            child: Center(
              child: Text(
                "${clockTimer.inMinutes.remainder(60).toString().padLeft(2, '0')}",
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4,right: 4),
          child: Text(':',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
        ),
        Container(
          height: 20,
          width: 30,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
            child: Center(
              child: Text(
                "${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}