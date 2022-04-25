import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:maw/screen/point/point_bloc.dart';
import 'package:maw/screen/point/point_state.dart';
import 'package:maw/screen/point/sales/sales_screen.dart';
import 'package:maw/screen/point/share_app/share_app_screen.dart';
import 'package:maw/screen/point/share_product/share_product_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../themes/colors.dart';
import '../../themes/images.dart';
import 'component/partner_center.dart';
import 'contributor_level/contributor_screen.dart';
import 'history_point/history_point_screen.dart';
import 'history_profit/history_profit_screen.dart';
import 'membership_level/membership_screen.dart';

class PointScreen extends StatefulWidget {
  const PointScreen({Key? key}) : super(key: key);

  @override
  _PointScreenState createState() => _PointScreenState();
}

class _PointScreenState extends State<PointScreen> {

  late PointBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = PointBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PointBloc,PointState>(
      listener: (context,state){

      },
      bloc: _bloc,
      child: BlocBuilder<PointBloc,PointState>(
        bloc: _bloc,
        builder: (BuildContext context,PointState state){
          return buildPage(context,state);
        },
      ),
    );
  }

  Widget buildPage(BuildContext context,PointState state){
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 20),
            child: ListView(
              padding: const EdgeInsets.only(bottom: 60),
              children: [
                title(),
                GestureDetector(
                    onTap: ()=> pushNewScreen(context, screen: const MembershipScreen()),
                    child: membershipLevel()),
                const SizedBox(height: 5,),
                GestureDetector(
                    onTap: ()=> pushNewScreen(context, screen: const ContributorScreen()),
                    child: contributorLevel()),
                const SizedBox(height: 5,),
                Divider(color: mainColor,),
                accumulatePoint(),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    width: double.infinity,
                    height: 5,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                ),
                campaignInMonth(),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    width: double.infinity,
                    height: 5,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                ),
                myReferralMember(),
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Divider(color: Colors.blueGrey,),
                ),
                menuItem('Trung tâm đối tác',()=>pushNewScreen(context, screen: const PartnerCenterScreen())),
                menuItem('Lịch sử điểm',()=> pushNewScreen(context, screen: const HistoryPointScreen())),
                menuItem('Lịch sử hoa hồng',()=> pushNewScreen(context, screen: const HistoryProfitScreen())),
                codeShare('Mã giới thiệu', ()=> null)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding title(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 50,
            child:Image.asset(logo,fit:BoxFit.cover,),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
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
          )
        ],
      ),
    );
  }

  Padding membershipLevel(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 15),
      child: Card(
        shadowColor: Colors.grey,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Container(
              padding:const  EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                border: Border.all(color: mainColor,width: 1)
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  Row(
                    children: const [
                      Icon(MdiIcons.water,color: Colors.blueGrey,),
                      SizedBox(width: 15,),
                      Text('01.01.2022 - 06.06.2022',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      const Icon(MdiIcons.water,color: Colors.blueGrey,),
                      const SizedBox(width: 15,),
                      const Text('Cấp bậc của quý khách là ',style: TextStyle(color: Colors.black,fontSize: 12),),
                      Text('Newbie',style: TextStyle(color: subColor,fontSize: 12),),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6), // Image border
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(30), // Image radius
                              child: Image.asset(
                                'assets/images/membership/5_9.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6), // Image border
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(30), // Image radius
                              child: Image.asset(
                                'assets/images/membership/6_1.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6), // Image border
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(30), // Image radius
                              child: Image.asset(
                                'assets/images/membership/7_1.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6), // Image border
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(30), // Image radius
                              child: Image.asset(
                                'assets/images/membership/8_1.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6), // Image border
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(30), // Image radius
                              child: Image.asset(
                                'assets/images/membership/9_1.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(MdiIcons.water,color: Colors.blueGrey,),
                      SizedBox(width: 15,),
                      Text('Ưu đãi của cấp Newbie',style: TextStyle(color: Colors.black,fontSize: 12),),
                    ],
                  ),
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 40),
                        child: Text('- Giảm 5% khi mua sản phẩm\n- Miễn phí vận chuyển',style: TextStyle(color: Colors.grey,fontSize: 12),),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      const Icon(MdiIcons.water,color: Colors.blueGrey,),
                      const SizedBox(width: 15,),
                      const Text('Điểm hiện tại:',style: TextStyle(color: Colors.black,fontSize: 12),),
                      const SizedBox(width: 15,),
                      Container(
                        padding: const EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(6)),
                          border: Border.all(color: subColor),
                        ),
                        child: Text('200 điểm',style: TextStyle(color: subColor,fontSize: 11),),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: -16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: mainColor)
                    ),
                    padding: const EdgeInsets.all(2),
                    child: Container(
                        padding: const EdgeInsets.only(left: 16,right: 16,top: 5,bottom: 5),
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(child: Row(
                          children: [
                            const Text('Cấp bậc thành viên',style: TextStyle(color: Colors.white),),
                            const SizedBox(width: 8,),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(45),
                                    color: subColor
                                ),
                                child: const Icon(Icons.navigate_next_outlined,color: Colors.white,size: 18,)),
                          ],
                        ),)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding contributorLevel(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 15),
      child: Card(
        shadowColor: Colors.grey,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  border: Border.all(color: mainColor,width: 1)
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  Row(
                    children: const [
                      Icon(MdiIcons.water,color: Colors.blueGrey,),
                      SizedBox(width: 15,),
                      Text('01.01.2022 - 06.06.2022',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      const Icon(MdiIcons.water,color: Colors.blueGrey,),
                      const SizedBox(width: 15,),
                      const Text('Cấp bậc của quý khách là ',style: TextStyle(color: Colors.black,fontSize: 12),),
                      Text('Newbie',style: TextStyle(color: subColor,fontSize: 12),),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6), // Image border
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(30), // Image radius
                            child: Image.asset(
                              'assets/images/contributor/cp_9.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6), // Image border
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(30), // Image radius
                            child: Image.asset(
                              'assets/images/contributor/g_1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6), // Image border
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(30), // Image radius
                            child: Image.asset(
                              'assets/images/contributor/sl_1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      const Icon(MdiIcons.water,color: Colors.blueGrey,),
                      const SizedBox(width: 15,),
                      const Text('Hoa hồng hiện tại',style: TextStyle(color: Colors.black,fontSize: 12),),
                      Icon(Icons.volunteer_activism,color: subColor,),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      const Icon(MdiIcons.water,color: Colors.blueGrey,),
                      const SizedBox(width: 15,),
                      const Text('Điểm xếp hạng:',style: TextStyle(color: Colors.black,fontSize: 12),),
                      const SizedBox(width: 15,),
                      Container(
                        padding: const EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(6)),
                          border: Border.all(color: subColor),
                        ),
                        child: Text('200 điểm',style: TextStyle(color: subColor,fontSize: 11),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: -16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: mainColor)
                    ),
                    padding: const EdgeInsets.all(2),
                    child: Container(
                        padding: const EdgeInsets.only(left: 16,right: 16,top: 5,bottom: 5),
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(child: Row(
                          children: [
                            const Text('Cấp bậc Cộng tác viên',style: TextStyle(color: Colors.white),),
                            const SizedBox(width: 8,),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(45),
                                    color: subColor
                                ),
                                child: const Icon(Icons.navigate_next_outlined,color: Colors.white,size: 18,)),
                          ],
                        ),)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget accumulatePoint(){
    return Padding(
      padding: const EdgeInsets.only(left: 16,top: 16,bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 0,bottom: 16,right: 8),
            child: Text('Tích điểm dễ dàng cùng Enterbuy'.toUpperCase(),style: TextStyle(color: mainColor,fontWeight: FontWeight.bold),),
          ),
          SizedBox(
            height: 150,
            child: ListView.builder(
                padding: const EdgeInsets.only(top: 0,left: 0,right: 0,bottom: 0),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context,index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16,bottom: 0),
                    child: Container(
                      width: 140,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey
                          ),
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: 140,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),topRight: Radius.circular(10)
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: 'https://images4.alphacoders.com/109/1097913.jpg',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 10,bottom: 10,right: 10,left: 10),
                            child: Text('Mua hàng tích điểm',style: TextStyle(fontSize: 12,color: Colors.black),overflow: TextOverflow.ellipsis,maxLines: 2,),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            )
          )
        ],
      ),
    );
  }

  Widget campaignInMonth(){
    return Padding(
      padding: const EdgeInsets.only(left: 16,top: 16,bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Chiến dịch '.toUpperCase(),style: TextStyle(color: mainColor,fontWeight: FontWeight.bold),
                  ), Text(
                    'hot '.toUpperCase(),style: TextStyle(color: subColor,fontWeight: FontWeight.bold),
                  ), Text(
                    'trong tháng'.toUpperCase(),style: TextStyle(color: mainColor,fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios_sharp,color: Colors.grey,size: 20,)
            ],
          ),
          const SizedBox(height: 16,),
          SizedBox(
              height: 150,
              child: ListView.builder(
                  padding: const EdgeInsets.only(top: 0,left: 0,right: 0,bottom: 0),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context,index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16,bottom: 0),
                      child: Container(
                        width: 140,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey
                            ),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                height: 140,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),topRight: Radius.circular(10)
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: 'https://images4.alphacoders.com/109/1097913.jpg',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 10,bottom: 10,right: 10,left: 10),
                              child: Text('Mua hàng tích điểm',style: TextStyle(fontSize: 12,color: Colors.black),overflow: TextOverflow.ellipsis,maxLines: 2,),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              )
          )
        ],
      ),
    );
  }

  Widget myReferralMember(){
    return SizedBox(
      height: 125,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16,bottom: 16,right: 8,top: 16),
            child: Text('Thành viên giới thiệu của tôi'.toUpperCase(),style: TextStyle(color: mainColor,fontWeight: FontWeight.bold),),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 0,top: 0,bottom: 0,right: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: GestureDetector(
                    onTap:()=>pushNewScreen(context, screen: const ShareAppScreen()),
                      child: referralContent(MdiIcons.inboxArrowDown,'2','Giới thiệu tải app'))),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(width: 1,height: double.infinity,color: Colors.blueGrey,),
                    ),
                  ),
                  Expanded(child: GestureDetector(
                      onTap: ()=>pushNewScreen(context, screen: const ShareProductScreen()),
                      child: referralContent(Icons.shopping_cart,'1','Mua hàng'))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(width: 1,height: double.infinity,color: Colors.blueGrey,),
                  ),
                  Expanded(child: GestureDetector(
                      onTap: ()=>pushNewScreen(context, screen: const SalesScreen()),
                      child: referralContent(MdiIcons.inboxArrowDown,'2','Doanh số giới thiệu'))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget referralContent(IconData icons,String content,String subContent){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icons,color: Colors.grey,),
        const SizedBox(height: 5,),
        Text(content,style: TextStyle(color: subColor,fontWeight: FontWeight.bold),),
        const SizedBox(height: 5,),
        Center(child: Text(subContent,style: const TextStyle(color: Colors.black,fontSize: 12),maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,)),
      ],
    );
  }

  Widget menuItem(String title,VoidCallback onTap){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10,left: 16,bottom: 10,right: 8),
          child: InkWell(
            onTap: onTap,
            child: SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  const Icon(Icons.navigate_next,color: Colors.black,),
                ],
              ),
            ),
          ),
        ),
        const Divider(color: Colors.blueGrey,)
      ],
    );
  }

  Widget codeShare(String title,Function onTap){
    return Padding(
      padding: const EdgeInsets.only(left: 16,top: 16,bottom: 26,right: 16),
      child: GestureDetector(
        onTap: ()=>onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            const SizedBox(height: 16,),
            DottedBorder(
              dashPattern: const [5, 3],
              color: Colors.grey,
              borderType: BorderType.RRect,
              radius: const Radius.circular(10),
              padding: const EdgeInsets.only(bottom: 8),
              child: GestureDetector(
                //onTap: () => FocusScope.of(context).requestFocus(focusNodeContentName),
                child: Container(
                  padding: const EdgeInsets.only(top: 10,right: 10,left: 10),
                  height: 35,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(Icons.copy,color: Colors.white,),
                      Text('zakdawdmaowmdam123mk421',style: TextStyle(color: Colors.blueGrey),),
                      Icon(Icons.copy,color: Colors.grey,),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
