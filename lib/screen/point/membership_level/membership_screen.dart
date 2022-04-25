import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../themes/colors.dart';
import 'membership_bloc.dart';
import 'membership_state.dart';

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({Key? key}) : super(key: key);

  @override
  _MembershipScreenState createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen>{

  late MembershipBloc _bloc;
  late TabController tabController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = MembershipBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MembershipBloc,MembershipState>(
      listener: (context,state){

      },
      bloc: _bloc,
      child: BlocBuilder<MembershipBloc,MembershipState>(
        bloc: _bloc,
        builder: (BuildContext context,MembershipState state){
          return buildPage(context,state);
        },
      ),
    );
  }


  Widget buildPage(BuildContext context,MembershipState state){
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: height * .05,bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16,right: 10,bottom: 5),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: ()=> Navigator.pop(context),
                      child: Row(
                        children: const [
                          SizedBox(
                              height:20,
                              width: 30,
                              child: Icon(Icons.arrow_back_ios,color: Colors.black,size: 20,)),
                          Expanded(child: Text('Cấp bậc thành viên',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,)),
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
            ),
            Expanded(child: SingleChildScrollView(child: buildBody(height))),
          ],
        ),
      ),
    );
  }

  Widget buildBody(double height){
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: height * .1,top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6), // Image border
            child: SizedBox.fromSize(
              size: const Size.fromRadius(90), // Image radius
              child: Image.asset(
                'assets/images/membership/5_9.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Cấp bậc của quý khách là ',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                Text('Newbie'.toUpperCase(),style: TextStyle(color: subColor,fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          const Divider(color: Colors.blueGrey,),
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,top: 10),
            child: Column(
              children: [
                Row(
                  children: const [
                    Icon(MdiIcons.water,color: Colors.blueGrey,),
                    SizedBox(width: 15,),
                    Text('01.01.2022 - 06.06.2022',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                  child: Row(
                    children: const [
                      Icon(MdiIcons.water,color: Colors.blueGrey,),
                      SizedBox(width: 15,),
                      Text('Cấp bậc dự kiến tiếp theo',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10,left: (width * .05),right: (width * .05)),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildLevel('0'),
                      buildLevel('250'),
                      buildLevel('500'),
                      buildLevel('750'),
                      buildLevel('1000'),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 20,right: 20,top: 2),
                      height: 25,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.grey.withOpacity(0.4)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildDot(),
                          buildDot(),
                          buildDot(),
                          buildDot(),
                          buildDot()
                        ],
                      ),
                    ),
                    Positioned(
                      left: 0,top: 0,bottom: 0,right: null,
                      child: Container(
                        height: 25,
                        width: width * .18,//.18 - .38 - .58 - .75 - double.infitity + right: 0
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: mainColor
                        ),
                        child: const Center(
                          child: Text('Bạc',style: TextStyle(color: Colors.white,fontSize: 11),),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          buildDesc('- Newbie:','Khi đạt <250 mua hàng'),
          buildDesc('- Beginner:','Khi đạt 250 mua hàng'),
          buildDesc('- Fan:','Khi đạt 500 mua hàng'),
          buildDesc('- VIP:','Khi đạt 750 mua hàng'),
          buildDesc('- VVIP:','Khi đạt 1000 mua hàng'),
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 0,left: 16),
            child: Row(
              children: const [
                Icon(MdiIcons.water,color: Colors.blueGrey,),
                SizedBox(width: 15,),
                Text('Ưu đãi của từng cấp bậc',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          buildDesc('- Newbie:',''),
          buildDesc('- Beginner:',''),
          buildDesc('- Fan:',''),
          buildDesc('- VIP:',''),
          buildDesc('- VVIP:',''),
        ],
      ),
    );
  }

  Widget buildDot(){
    return SizedBox(width: 30,child: Icon(Icons.circle,size: 10,color:Colors.black.withOpacity(0.4),));
  }

  Widget buildLevel(String content){
    return SizedBox(width: 30,child: Center(child: Text(content,style: const TextStyle(color: Colors.blueGrey,fontSize: 12),)));
  }

  Widget buildDesc(String title, String subtitle){
    return Padding(
      padding: const EdgeInsets.only(top: 16,left: 20,right: 20),
      child: Row(
        children: [
          Text(title,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          const SizedBox(width: 4,),
          Text(subtitle,style: const TextStyle(color: Colors.blueGrey),),
        ],
      ),
    );
  }
}
