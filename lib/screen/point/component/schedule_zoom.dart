import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maw/screen/point/point_bloc.dart';
import 'package:maw/screen/point/point_state.dart';
import 'package:maw/screen/point/point_event.dart';

import '../../../themes/colors.dart';
import '../../../utils/const.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';


class ScheduleZoomScreen extends StatefulWidget {
  final String title;
  const ScheduleZoomScreen({Key? key,required this.title}) : super(key: key);

  @override
  _ScheduleZoomScreenState createState() => _ScheduleZoomScreenState();
}

class _ScheduleZoomScreenState extends State<ScheduleZoomScreen> {

  late PointBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = PointBloc();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<PointBloc,PointState>(
        bloc: _bloc,
        listener: (context,state){

        },
        child: BlocBuilder<PointBloc,PointState>(
          bloc: _bloc,
          builder: (BuildContext context, PointState sate){
            return Container(
              padding: EdgeInsets.only(top: height * .05,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  appBar(widget.title,context),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.blueGrey.withOpacity(0.5),
                    ),
                  ),
                  Expanded(child: buildBody(height,context)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  buildBody(double height, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20,bottom: 10,left: 16),
            child: Align(alignment: Alignment.centerLeft,child: Text('Thông tin cá nhân:',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.start,)),
          ),
          buildInput('Tên'),
          buildInput('Địa chỉ'),
          buildInput('Điện thoại'),
          buildInput('Email'),
          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: Divider(color: Colors.grey.withOpacity(0.3),thickness: 5,),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Đặt lịch',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                Container(
                  padding: const EdgeInsets.only(left: 16,right: 10,top: 4,bottom: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: dark_text.withOpacity(0.3)
                  ),
                  child: Row(
                    children: const [
                      Center(child: Text('01/04/2022',style: TextStyle(color: Colors.black,fontSize: 12),),),
                      SizedBox(width: 5,),
                      Icon(Icons.arrow_drop_down,color: Colors.black,),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CheckedContainer(paddingV: 15,content: '08:00 - 09:00',checked: _bloc.checkingBonus == 0,onTap: ()=> _bloc.add(CheckingTimeSchedule(0)),checkedColor: subColor,),
                CheckedContainer(paddingV: 15,content: '09:00 - 10:00',checked: _bloc.checkingBonus == 1,onTap: ()=> _bloc.add(CheckingTimeSchedule(1)),checkedColor: subColor,),
                CheckedContainer(paddingV: 15,content: '10:00 - 11:00',checked: _bloc.checkingBonus == 2,onTap: ()=> _bloc.add(CheckingTimeSchedule(2)),checkedColor: subColor,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CheckedContainer(paddingV: 15,content: '11:00 - 12:00',checked: _bloc.checkingBonus == 3,onTap: ()=> _bloc.add(CheckingTimeSchedule(3)),checkedColor: subColor,),
                CheckedContainer(paddingV: 15,content: '12:00 - 13:00',checked: _bloc.checkingBonus == 4,onTap: ()=> _bloc.add(CheckingTimeSchedule(4)),checkedColor: subColor,),
                CheckedContainer(paddingV: 15,content: '13:00 - 14:00',checked: _bloc.checkingBonus == 5,onTap: ()=> _bloc.add(CheckingTimeSchedule(5)),checkedColor: subColor,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CheckedContainer(paddingV: 15,content: '14:00 - 15:00',checked: _bloc.checkingBonus == 6,onTap: ()=> _bloc.add(CheckingTimeSchedule(6)),checkedColor: subColor,),
                CheckedContainer(paddingV: 15,content: '15:00 - 16:00',checked: _bloc.checkingBonus == 7,onTap: ()=> _bloc.add(CheckingTimeSchedule(7)),checkedColor: subColor,),
                CheckedContainer(paddingV: 15,content: '16:00 - 17:00',checked: _bloc.checkingBonus == 8,onTap: ()=> _bloc.add(CheckingTimeSchedule(8)),checkedColor: subColor,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CheckedContainer(paddingV: 15,content: '17:00 - 18:00',checked: _bloc.checkingBonus == 9,onTap: ()=> _bloc.add(CheckingTimeSchedule(9)),checkedColor: subColor,),
                CheckedContainer(paddingV: 15,content: '18:00 - 19:00',checked: _bloc.checkingBonus == 10,onTap: ()=> _bloc.add(CheckingTimeSchedule(10)),checkedColor: subColor,),
                CheckedContainer(paddingV: 15,content: '19:00 - 20:00',checked: _bloc.checkingBonus == 11,onTap: ()=> _bloc.add(CheckingTimeSchedule(11)),checkedColor: subColor,),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20,bottom: 10,left: 16),
            child: Align(alignment: Alignment.centerLeft,child: Text('Bộ phận',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.start,)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
            child: Container(
              padding: const EdgeInsets.only(left: 16,right: 16,top: 3,bottom: 3),
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.grey.withOpacity(0.3),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Bộ phận kỹ thuật',style: TextStyle(color: Colors.black),),
                  Icon(Icons.arrow_drop_down,color: Colors.black,),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20,bottom: 10,left: 16),
            child: Align(alignment: Alignment.centerLeft,child: Text('Ghi chú',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.start,)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
            child: SizedBox(
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.0),
                      borderSide: const BorderSide(color: Colors.transparent, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: grey, width: 1),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: grey, width: 1),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    filled: true,
                    contentPadding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5),fontSize: 12),
                    hintText: "Type in your text",
                    fillColor: Colors.white70),
              ),
            )
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16,right: 16,top: 16),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: mainColor
                ),
                child: const Center(child: Text('Đặt lịch',style: TextStyle(color: Colors.white),),),
              )
          ),
        ],
      ),
    );
  }

  Widget buildInput(String title){
    return Padding(
      padding: const EdgeInsets.only(left: 16,right: 16,top: 5,bottom: 5),
      child: Row(
        children: [
          Expanded(child: Align(alignment: Alignment.bottomLeft,child: Text(title,style: const TextStyle(color: Colors.blueGrey,),textAlign: TextAlign.start,))),
          const SizedBox(width: Const.kDefaultPadding * 0.75,),
          const Expanded(flex: 4,child: SizedBox(height:30,child: TextField()))
        ],
      ),
    );
  }

}
