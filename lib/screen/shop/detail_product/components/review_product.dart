import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../themes/colors.dart';

class ReviewProductScreen extends StatefulWidget {
  const ReviewProductScreen({Key? key}) : super(key: key);

  @override
  _ReviewProductScreenState createState() => _ReviewProductScreenState();
}

class _ReviewProductScreenState extends State<ReviewProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8,right: 0,top: 16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    color: Colors.grey.withOpacity(0.2)
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 12),
                  child: const Text('Bình luân (255)',style: TextStyle(color: Colors.black,fontSize: 11),),
                ),
                const SizedBox(width: 10,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      color: Colors.grey.withOpacity(0.2)
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 12),
                  child: const Text('Bình luân có hình ảnh (17)',style: TextStyle(color: Colors.black,fontSize: 11),),
                )
              ],
            ),
            const SizedBox(height: 7,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    color: Colors.grey.withOpacity(0.2)
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 12),
                  child: Row(
                    children: [
                      const Text('5',style: TextStyle(color: Colors.grey,fontSize: 11),),
                      Icon(Icons.star,size: 12,color: subColor,),const SizedBox(width: 5,),
                      const Text('(79)',style: TextStyle(color: Colors.black,fontSize: 11),),
                    ],
                  ),
                ),
                const SizedBox(width: 5,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      color: Colors.grey.withOpacity(0.2)
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 12),
                  child: Row(
                    children: [
                      const Text('4',style: TextStyle(color: Colors.grey,fontSize: 11),),
                      Icon(Icons.star,size: 12,color: subColor,),const SizedBox(width: 5,),
                      const Text('(1124)',style: TextStyle(color: Colors.black,fontSize: 11),),
                    ],
                  ),
                ),
                const SizedBox(width: 5,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      color: Colors.grey.withOpacity(0.2)
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 12),
                  child: Row(
                    children: [
                      const Text('3',style: TextStyle(color: Colors.grey,fontSize: 11),),
                      Icon(Icons.star,size: 12,color: subColor,),const SizedBox(width: 5,),
                      const Text('(0)',style: TextStyle(color: Colors.black,fontSize: 11),),
                    ],
                  ),
                ),
                const SizedBox(width: 5,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      color: Colors.grey.withOpacity(0.2)
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 12),
                  child: Row(
                    children: [
                      const Text('2',style: TextStyle(color: Colors.grey,fontSize: 11),),
                      Icon(Icons.star,size: 12,color: subColor,),const SizedBox(width: 5,),
                      const Text('(2)',style: TextStyle(color: Colors.black,fontSize: 11),),
                    ],
                  ),
                ),
                const SizedBox(width: 5,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      color: Colors.grey.withOpacity(0.2)
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 12),
                  child: Row(
                    children: [
                      const Text('1',style: TextStyle(color: Colors.grey,fontSize: 11),),
                      Icon(Icons.star,size: 12,color: subColor,),
                      const SizedBox(width: 5,),
                      const Text('(1)',style: TextStyle(color: Colors.black,fontSize: 11),),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.grey,),
            Expanded(child: listComment()),
          ],
        ),
      ),
    );
  }

  Widget listComment(){
    return ListView.separated(
        itemBuilder: (BuildContext context, int index){
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
                width: 40,
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://i.pinimg.com/736x/92/26/5c/92265c40c8e428122e0b32adc1994594.jpg'),
                ),
              ),
              const SizedBox(width: 6,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ẩn danh',style:  TextStyle(fontWeight: FontWeight.w600,fontSize: 13),),
                    const SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(MdiIcons.star,color: grey ,size: 11,),//_list[index].soSao >= 1? Colors.orange :
                        Icon(MdiIcons.star,color: grey ,size: 11,),
                        Icon(MdiIcons.star,color: grey ,size: 11,),
                        Icon(MdiIcons.star,color: grey ,size: 11,),
                        Icon(MdiIcons.star,color: grey ,size: 11,),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    const Text('hihi',//_list[index].noiDung??
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,fontSize: 12,
                          fontStyle: FontStyle.italic),
                      maxLines: 5,overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5,),
                    const Text('04/03/1995',style:  TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.normal,color: Colors.grey,fontSize: 12),),
                    //Jiffy(_list[index].ngayDanhGia).format(Const.DATE_TIME_FORMAT)??
                  ],
                ),
              ),
              GestureDetector(
                //onTap:()=>showDialog(_list[index],index),
                child: const SizedBox(
                    height:20,
                    child: Icon(Icons.more_horiz,color: Colors.red,)),
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index)=>Column(
          children: const [
            SizedBox(height: 5,),
            Divider(),
            SizedBox(height: 5,),
          ],
        ),
        itemCount: 1
    );
  }
}
