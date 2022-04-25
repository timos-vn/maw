import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:maw/screen/point/register_contributor/register_contributor_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../themes/colors.dart';
import 'contributor_bloc.dart';
import 'contributor_state.dart';

class ContributorScreen extends StatefulWidget {
  const ContributorScreen({Key? key}) : super(key: key);

  @override
  _ContributorScreenState createState() => _ContributorScreenState();
}

class _ContributorScreenState extends State<ContributorScreen>{

  late ContributorBloc _bloc;
  late TabController tabController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = ContributorBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContributorBloc,ContributorState>(
      listener: (context,state){

      },
      bloc: _bloc,
      child: BlocBuilder<ContributorBloc,ContributorState>(
        bloc: _bloc,
        builder: (BuildContext context,ContributorState state){
          return buildPage(context,state);
        },
      ),
    );
  }


  Widget buildPage(BuildContext context,ContributorState state){
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
                          Expanded(child: Text('Cấp bậc cộng tác viên',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,)),
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
                'assets/images/contributor/cp_9.png',
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
                Text('Đồng'.toUpperCase(),style: TextStyle(color: subColor,fontWeight: FontWeight.bold),),
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
          buildDesc('- Đồng:','Khi đạt 1000 điểm giới thiệu'),
          buildDesc('- Bạc:','Khi đạt 2000 điểm giới thiệu'),
          buildDesc('- Vàng:','Khi đạt 3000 điểm giới thiệu'),
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 0,left: 16),
            child: Row(
              children: const [
                Icon(MdiIcons.water,color: Colors.blueGrey,),
                SizedBox(width: 15,),
                Text('Kỳ hạn đánh giá:',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                SizedBox(width: 15,),
                Text('06 tháng',style: TextStyle(color: Colors.blueGrey),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30,bottom: 0,left: 16),
            child: Column(
              children: [
                const Text('Bạn cũng có thể đăng ký trở thành CTV của MAW',style: TextStyle(color: Colors.blueGrey,fontSize: 12),),
                const SizedBox(height: 10,),
                GestureDetector(
                  onTap: ()=> pushNewScreen(context, screen: const RegisterContributorScreen(),withNavBar: false),
                  child: Container(
                    width: 150,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: subColor
                    ),
                    child: const Center(child: Text('Đăng ký ngay',style: TextStyle(color: Colors.white),),),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 0,left: 16),
            child: Row(
              children: const [
                Icon(MdiIcons.water,color: Colors.blueGrey,),
                SizedBox(width: 15,),
                Text('Hoa hồng của từng cấp bậc',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          buildDesc('- Đồng:',''),
          buildDesc('- Bạc:',''),
          buildDesc('- Vàng:',''),
        ],
      ),
    );
  }

  Widget buildDesc(String title, String subtitle){
    return Padding(
      padding: const EdgeInsets.only(top: 16,left: 40,right: 20),
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
