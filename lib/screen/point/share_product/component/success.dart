import 'package:flutter/material.dart';

import '../../../../themes/colors.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 6),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 15,right: 16,left: 16,bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Nguyễn Văn A',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black),),
                  Text('Ngày giới thiệu: 20/08/2021',style: TextStyle(color: Colors.grey,fontSize: 11),),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                children: const [
                  Icon(Icons.phone,color: Colors.grey,size: 16,),
                  SizedBox(width: 5,),
                  Text('0963 004 959',style: TextStyle(color: Colors.grey,fontSize: 12),),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                children: const [
                  Text('Tên sản phẩm: ',style: TextStyle(color: Colors.grey,fontSize: 12),),
                  SizedBox(width: 5,),
                  Text('Ô mô ma tic',style: TextStyle(color: Colors.black,fontSize: 12),),
                ],
              ),
              const Divider(color: Colors.grey,),
              Text('Chiến dịch: Giới thiệu tải app nhận thưởng',style: TextStyle(color: mainColor,fontSize: 12),),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Sale phụ trách: HML',style: TextStyle(color: Colors.grey,fontSize: 12),),
                  Text('Điểm: 60đ',style: TextStyle(color: subColor,fontSize: 12),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
