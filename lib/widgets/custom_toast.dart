import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customToast(BuildContext context, IconData icon,String title){
  return Material(
    color: Colors.transparent,
    child: Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          width: 180.0,
          height: 150.0,
          color: Colors.black.withOpacity(0.8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 35.0,
                color: Colors.white,
              ),
              Padding(
                padding:const EdgeInsets.only(top: 10,left: 10,right: 10),
                child: Center(child: Text(title,style:const TextStyle(fontSize: 16,color: Colors.white),textAlign: TextAlign.center,)),
              )
            ],
          ),
        ),
      ),
    ),
  );
}