import 'package:flutter/material.dart';
import 'package:maw/themes/colors.dart';

Widget appBar(String title,BuildContext context){
  return Padding(
    padding: const EdgeInsets.only(left: 16,right: 10,bottom: 5),
    child: Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: ()=> Navigator.pop(context),
            child: Row(
              children: [
                const SizedBox(
                    height:20,
                    width: 30,
                    child: Icon(Icons.arrow_back_ios,color: Colors.black,size: 20,)),
                Expanded(child: Text(title,style: const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,)),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Icon(Icons.phone,color: mainColor,),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Icon(Icons.message,color: mainColor,),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Icon(Icons.notifications,color: mainColor,),
        ),
      ],
    ),
  );
}