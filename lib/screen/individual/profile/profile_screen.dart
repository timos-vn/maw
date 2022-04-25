import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:maw/screen/individual/profile/profile_bloc.dart';
import 'package:maw/screen/individual/profile/profile_state.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../themes/colors.dart';
import '../../../utils/const.dart';
import '../../../widgets/text_field_widget3.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin{

  late TabController tabController;
  late ProfileBloc _bloc;
  TextEditingController nameController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();

  TextEditingController phoneController = TextEditingController();
  FocusNode phoneFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = ProfileBloc();
    tabController = TabController(length: 3, vsync: this);
    // controller = AnimationController(
    //     duration: const Duration(milliseconds: 2000), vsync: this);
    // animation = Tween(begin: 0.0, end: 1.0).animate(controller)
    //   ..addListener(() {
    //     setState(() {
    //       // the state that has changed here is the animation object’s value
    //     });
    //   });
    // controller.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: BlocListener<ProfileBloc,ProfileState>(
        bloc: _bloc,
        listener: (context,state){

        },
        child: BlocBuilder(
          bloc: _bloc,
          builder: (BuildContext context, ProfileState state){
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 110,
                  width: double.infinity,
                  color: mainColor,
                  padding: const EdgeInsets.only(left: 16,right: 16,top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: ()=> Navigator.pop(context),
                        child: const SizedBox(
                            height:20,
                            width: 30,
                            child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 20,)),
                      ),
                      GestureDetector(
                        onTap: ()=> Navigator.pop(context),
                        child: const SizedBox(
                            height:20,
                            width: 30,
                            child: Icon(Icons.edit,color: Colors.white,size: 20,)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(24),
                            topLeft: Radius.circular(24)
                        ),
                        color: Colors.white
                    ),
                    child: buildBody(),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildExtension(){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 8),
          child: Row(
            children: [
              Icon(MdiIcons.bookmarkMinusOutline,color: mainColor,),
              const SizedBox(width: Const.kDefaultPadding * 0.65,),
              const Text('Tiện ích của tôi',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(left: 40,right: 40,top: 10,bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildMenu(MdiIcons.spotify, 'Gói dịch vụ',mainColor),
              buildMenu(MdiIcons.walletOutline, 'Ví voucher',mainColor),
              buildMenu(MdiIcons.cartOutline, 'Giỏ hàng',mainColor),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildBody(){

    return Stack(
      overflow: Overflow.visible,
      alignment: AlignmentDirectional.topCenter,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: Const.kDefaultPadding*2.5),
            const Text('Hoàng Thu Trang',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            const SizedBox(height: Const.kDefaultPadding*0.45),
            Container(
              padding: const EdgeInsets.only(top: 4,bottom: 4,left: 14,right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.grey.withOpacity(0.2)
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.stars,color: subColor,size: 20,),
                  const SizedBox(width: 10,),
                  const Text('Newbie',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),),
                ],
              ),
            ),
            const Divider(),
            Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,top: 0),
                      child: TabBar(
                        controller: tabController,
                        unselectedLabelColor: Colors.black.withOpacity(0.7),
                        labelColor: mainColor,
                        labelStyle: const TextStyle(fontWeight: FontWeight.w400,fontSize: 12),
                        isScrollable: false,
                        indicatorPadding: const EdgeInsets.all(0),
                        indicatorColor: Colors.orange,
                        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
                        indicator: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                style: BorderStyle.solid,
                                color: mainColor,
                                width: 2
                            ),
                          ),
                        ),
                        tabs: List<Widget>.generate(_bloc.listTabViewProfile.length, (int index) {
                          return Tab(
                            icon: Icon(_bloc.listIcon[index]),
                            text: _bloc.listTabViewProfile[index].toString(),
                          );
                        }),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                          controller: tabController,
                          children: List<Widget>.generate(_bloc.listTabViewProfile.length, (int index) {
                            for (int i = 0; i <= _bloc.listTabViewProfile.length; i++) {
                              if (index == 0) {
                                return buildProfile(context, index);
                              }else if(index == 1){
                                return buildPoint();
                              }else {
                                return buildAddContact();
                              }
                            }
                            return const Text('');
                          })),
                    ),
                  ],
                )
            )
          ],
        ),
        Positioned(
          top: -55,
          child: Stack(
            overflow: Overflow.visible,
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50), // Image border
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(45), // Image radius
                    child: CachedNetworkImage(
                      imageUrl: 'https://i.pinimg.com/564x/5e/93/14/5e9314a0f83f3f48e5d5fde1a77d3519.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const Positioned(
                bottom: 10,right: 0,
                child: Icon(Icons.camera_alt_outlined,color: Colors.black,),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildAddContact(){
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: height * .1,top: 20,left: 16,right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Thông tin người liên hệ',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            TextFieldWidgetInput(
              onChanged: (String? newValue) {  },
              labelText: 'Họ & tên', focusNode: nameFocusNode,
              onSubmitted: (String? newValue) {  },
              controller: nameController,
              readOnly: false, inputFormatters: const [],
            ),
            const SizedBox(height: 16,),
            TextFieldWidgetInput(
              onChanged: (String? newValue) {  },
              labelText: 'Số điện thoại', focusNode: phoneFocusNode,
              onSubmitted: (String? newValue) {  },
              controller: phoneController,
              readOnly: false, inputFormatters: const [],
            ),
            const SizedBox(height: 20,),
            TextFieldWidgetInput(
              onChanged: (String? newValue) {  },
              labelText: 'Email', focusNode: emailFocusNode,
              onSubmitted: (String? newValue) {  },
              controller: emailController,
              readOnly: false, inputFormatters: const [],
              textInputAction: TextInputAction.done,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPoint(){
    return Padding(
      padding: const EdgeInsets.only(left: 16,right: 16,top: 20),
      child: Column(
        children: [
          Card(
            shadowColor: Colors.grey,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(MdiIcons.chessBishop,color: mainColor,),
                      const SizedBox(width: 5,),
                      const Text('Điểm mua hàng',style: TextStyle(color: Colors.black),)
                    ],
                  ),
                  const SizedBox(height: 10,),
                  const Text('15/1000 điểm',style: TextStyle(color: Colors.blueGrey,fontSize: 12),),
                  const SizedBox(height: 5,),
                  LinearPercentIndicator(
                    lineHeight: 8.0,
                    percent: 0.5,
                    // _homeBloc.pieChart[index].percent,
                    animation: true,
                    animationDuration: 2000,
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: orange,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16,),
          Card(
            shadowColor: Colors.grey,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(MdiIcons.shareCircle,color: mainColor,),
                      const SizedBox(width: 5,),
                      const Text('Điểm giới thiệu',style: TextStyle(color: Colors.black),)
                    ],
                  ),
                  const SizedBox(height: 10,),
                  const Text('150/1000 điểm',style: TextStyle(color: Colors.blueGrey,fontSize: 12),),
                  const SizedBox(height: 5,),
                  LinearPercentIndicator(
                    lineHeight: 8.0,
                    percent: 0.8,
                    // _homeBloc.pieChart[index].percent,
                    animation: true,
                    animationDuration: 2000,
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: orange,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfile(BuildContext context, int index){
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildMenuLine('Số điện thoại', '0963004959'),
          buildMenuLine('Ngày sinh', '04-03-1995'),
          buildMenuLine('Giới tính', 'nữ'),
          buildMenuLine('Địa chỉ giao hàng', '262 Nguyễn Huy Tưởng, Thanh Xuân, Hà Nội'),
          buildMenuLine('Thông tin tài khoản (Dành cho CTV)', ''),
          buildMenuLine('Thông tin xuất hoá đơn (Nếu có)', ''),
        ],
      ),
    );
  }

  Widget buildMenu(IconData icon,String title, Color color){
    return Column(
      children: [
        Icon(icon,color: color,),
        const SizedBox(height: Const.kDefaultPadding * 0.75,),
        Text(title,style: const TextStyle(color: Colors.black,fontSize: 12),),
      ],
    );
  }

  Widget buildMenuLine(String title, String subtitle,){
    return Padding(
      padding: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 1,
                  child: Text(title, style: const TextStyle(color: Colors.grey,fontSize: 12),)),
              Expanded(
                  flex: 1,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(subtitle, style: const TextStyle(color: Colors.black,fontSize: 12),maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.end,))),
            ],
          ),
          const Divider()
        ],
      ),
    );
  }
}
