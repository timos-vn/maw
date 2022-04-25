import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:maw/screen/point/sales/sales_bloc.dart';
import 'package:maw/screen/point/sales/sales_state.dart';

import '../../../themes/colors.dart';
import '../../../widgets/custom_appbar.dart';


class SalesScreen extends StatefulWidget {
  const SalesScreen({Key? key}) : super(key: key);

  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen>{

  late SalesBloc _bloc;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = SalesBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SalesBloc,SalesState>(
      listener: (context,state){

      },
      bloc: _bloc,
      child: BlocBuilder<SalesBloc,SalesState>(
        bloc: _bloc,
        builder: (BuildContext context,SalesState state){
          return buildPage(context,state);
        },
      ),
    );
  }


  Widget buildPage(BuildContext context,SalesState state){
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: height * .05,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            appBar('Doanh số giới thiệu',context),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.blueGrey.withOpacity(0.5),
              ),
            ),
            Expanded(child: buildBody(height)),
          ],
        ),
      ),
    );
  }

  Widget buildBody(double height){
    return Padding(
      padding: EdgeInsets.only(bottom: height * .1,top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20,right: 20),
            height: 38,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('1 tháng',style: TextStyle(color: subColor),),
                Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 8),
                  child: Container(height: double.infinity,width: 1,color: Colors.blueGrey,),
                ),
                const Text('6 tháng',style: TextStyle(color: Colors.black),),
                Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 8),
                  child: Container(height: double.infinity,width: 1,color: Colors.blueGrey,),
                ),
                const Text('1 năm',style: TextStyle(color: Colors.black),),
                Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 8),
                  child: Container(height: double.infinity,width: 1,color: Colors.blueGrey,),
                ),
                const Text('Tất cả',style: TextStyle(color: Colors.black),),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 5,
            color: dark_text.withOpacity(0.3),
          ),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: Center(child: Text('Tổng doanh thu: 1.500.000 đ',style: TextStyle(color: subColor,fontWeight: FontWeight.bold),)),
          ),
          Expanded(
            child: Container(
              color: dark_text.withOpacity(0.3),
              child: ListView.separated(
                  padding: const EdgeInsets.only(top: 5,left: 0,right: 0,bottom: 0),
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context,index) =>
                      Container(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.only(top: 15,right: 16,left: 16,bottom: 15),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              const Divider(color: Colors.grey,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Chiến dịch: Giới thiệu tải app nhận thưởng',style: TextStyle(color: mainColor,fontSize: 12),),
                                  Text('Điểm: 60đ',style: TextStyle(color: subColor,fontSize: 12),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
              , separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: double.infinity,
                      height: 2,
                      // color: dark_text.withOpacity(0.3),
                    );
              },),
            ),
          )
        ],
      ),
    );
  }

}
