import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:maw/screen/connect_device/splash_connect.dart';
import 'package:maw/screen/notification/notification_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../themes/colors.dart';
import '../../themes/images.dart';
import '../../widgets/custom_paint.dart';
import '../../widgets/hoz_list_view.dart';
import '../../widgets/touchable_widget.dart';
import 'detail_device/detail_device_screen.dart';
import 'home_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late HomeBloc _bloc;
  late CarouselController carouselController;
  FocusNode focusNodeContentName = FocusNode();
  TextEditingController inputCodeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carouselController = CarouselController();
    _bloc = HomeBloc();
    _bloc.add(GetPrefs());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc,HomeState>(
        listener: (context,state){

        },
      bloc: _bloc,
      child: BlocBuilder<HomeBloc,HomeState>(
        bloc: _bloc,
        builder: (BuildContext context,HomeState state){
          return buildPage(context,state);
        },
      ),
    );
  }



  Widget buildPage(BuildContext context,HomeState state){
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 20),
            child: ListView(
              padding: const EdgeInsets.only(bottom: 60),
              children: [
                title(),
                image.isNotEmpty ?
                Padding(
                  padding: const EdgeInsets.only(left: 12,right: 12,top: 0),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: ()=>carouselController.previousPage(),
                          child: const Icon(Icons.arrow_back_ios_sharp,color: Colors.black,)),
                      Expanded(
                        child: GestureDetector(
                          onTap: ()=> pushNewScreen(context, screen: const DetailDeviceScreen()),
                          child: SizedBox(
                            height: 230,
                            child: CarouselSlider.builder(
                              carouselController: carouselController,
                              options: CarouselOptions(
                                height: 230,
                                viewportFraction: 1,),
                              itemCount: image.length,
                              itemBuilder: (context,index,realIndex){
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: 80,
                                        child: Image.asset(image[index],fit: BoxFit.cover,)),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 10,bottom: 10),
                                      child: Text('Máy ion kiềm K8',style: TextStyle(color: Colors.black),),
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Icon(MdiIcons.alert,color: Colors.red,size: 18,),
                                        SizedBox(width: 3,),
                                        Text('Có gì đó không ổn!',style: TextStyle(color: Colors.red),),
                                      ],
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 14,bottom: 14),
                                      child: Text('Thiết bị của bạn đã đến hạn thay lõi',style: TextStyle(color: Colors.grey,fontSize: 12),),
                                    ),
                                    buildButtonMaintenance()
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: ()=>carouselController.nextPage(),
                          child: const Icon(Icons.arrow_forward_ios_sharp,color: Colors.black,))
                    ],
                  ),
                )
                    :
                buildAddDevice(),
                buildRequestPending(),
                buildPointUsing(),
                buildVoucherForU(),
                buildVoucher(),
                buildInputCode()
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<String> image = [];
  // List<String> image = [image_water,image_water,image_water];

  Padding title(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Xin chào, ${_bloc.userName}!',style: const TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
              const Padding(
                padding: EdgeInsets.only(top: 3),
                child: Text('Chào mừng đến với MAW',style: TextStyle(fontSize: 13,color: Colors.blueGrey),),
              )
            ],
          ),
         Row(
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
               child: InkWell(
                   onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const NotificationScreen())),
                   child: Icon(Icons.notifications,color: mainColor,)),
             ),
           ],
         )
        ],
      ),
    );
  }

  Widget buildAddDevice(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: InkWell(
        onTap: ()=>pushNewScreen(context, screen: const SplashConnectScreen(),withNavBar: false),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              overflow: Overflow.visible,
              children: [
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 60,
                        child: Image.asset(image_water,fit: BoxFit.cover,)),
                    Padding(
                      padding: const EdgeInsets.only(left: 13,bottom: 48),
                      child: CustomPaint(
                          painter: CustomChatBubble( color: Colors.grey.withOpacity(0.18)),
                          child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                              child: Column(
                                children: [
                                  Text(
                                    'Bạn chưa có thiết bị',
                                    style: TextStyle(color: Colors.black.withOpacity(0.4),fontSize: 12),
                                  ),
                                  const SizedBox(height: 5,),
                                  const Text(
                                    'Bạn hãy thêm thiết bị để đặt lịch bảo trì',
                                    style: TextStyle(color: Colors.black,fontSize: 12),
                                  ),
                                ],
                              ))),
                    ),
                    const SizedBox(
                        height: 60,width: 60,),
                  ],
                ),
                Positioned(
                  left: 0,bottom: -30,right: 0,
                  child: Column(
                    children: [
                      Icon(MdiIcons.plusCircle,color: subColor,size: 35,),
                      const SizedBox(height: 10,),
                      const Text(
                        'Thêm thiết bị',
                        style: TextStyle(color: Colors.grey,fontSize: 11),
                      ),
                    ],
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget buildButtonMaintenance (){
    return Container(
      height: 35,
      width: 160,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        border: Border.all(color: Colors.deepOrangeAccent)
      ),
      child: const Align( alignment: Alignment.center,
        child: Text('Bảo trì tất cả thiết bị',style: TextStyle(color: Colors.deepOrangeAccent,fontSize: 12),textAlign: TextAlign.center,),
      ),
    );
  }

  Widget buildRequestPending(){
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16,bottom: 16,right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Yêu cầu đang thực hiện'.toUpperCase(),style: TextStyle(color: mainColor,fontWeight: FontWeight.bold),),
                Row(
                  children: const [
                    Text('Xem thêm',style: TextStyle(color: Colors.grey,fontSize: 11),),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_forward_ios_sharp,color: Colors.grey,size: 13,)
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey.withOpacity(0.2),
            child: ListView.builder(
                padding: const EdgeInsets.only(top: 10,left: 16,right: 16,bottom: 0),
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context,index) =>
                    Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.only(top: 15,right: 10,left: 10,bottom: 15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Ten/ma sp',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black),),
                                Text('x1',style: TextStyle(color: Colors.grey),),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Ngay lap don',style: TextStyle(color: Colors.grey),),
                                Text('1.800.000',style: TextStyle(color: mainColor,fontSize: 13),),
                              ],
                            ),
                            const Divider(color: Colors.grey,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Icon(MdiIcons.accountBox,color: Colors.grey,size: 18,),
                                    SizedBox(width: 5,),
                                    Text('NV MAW',style: TextStyle(color: Colors.grey,fontSize: 12),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(MdiIcons.vanUtility,color: subColor,size: 18,),
                                    const SizedBox(width: 5,),
                                    const Text('Chuan bi giao hang',style: TextStyle(color: Colors.grey,fontSize: 12),),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                )
            ),
          )
        ],
      ),
    );
  }

  Widget buildPointUsing(){
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 8),
            child: Text('Điểm tiêu dùng'.toUpperCase(),style: TextStyle(color: mainColor,fontWeight: FontWeight.bold),),
          ),
          Center(
            child: CircularPercentIndicator(
              radius: 65.0,
              lineWidth: 11.0,
              animationDuration: 2200,
              animation: true,
              percent: 0.15,
              center: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('15',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            //letterSpacing: 2
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text('/100',
                          style: TextStyle(
                            color: subColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            //letterSpacing: 2
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              circularStrokeCap: CircularStrokeCap.butt,
              progressColor: orange,
              backgroundColor: Colors.grey.withOpacity(0.5),
            ),
          ),
          const Center(
            child: Text(
              '"Mua sắm 0 đồng với chính sách giới thiệu tích điểm"',
              style: TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
                fontSize: 12
              ),
            ),
          ),
          const SizedBox(height: 15,),
          Center(
            child: Container(
              padding: const EdgeInsets.only(top: 10,left: 16,right: 16,bottom: 10),
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: const BorderRadius.all(Radius.circular(24))
              ),
              height: 35,
              width: 150,
              child: const Center(
                child: Text('Giới thiệu ngay',style: TextStyle(color: Colors.white,fontSize: 13),),
              ),
            ),
          ),
          const SizedBox(height: 10,)
        ],
      ),
    );
  }

  Widget buildVoucherForU(){
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16,bottom: 16,right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('Voucher của'.toUpperCase(),style: TextStyle(color: mainColor,fontWeight: FontWeight.bold),),
                    Text(' ${_bloc.userName}'.toUpperCase(),style: const TextStyle(color: Colors.deepOrangeAccent,fontWeight: FontWeight.bold),),
                  ],
                ),
                Row(
                  children: const [
                    Text('Xem thêm',style: TextStyle(color: Colors.grey,fontSize: 11),),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_forward_ios_sharp,color: Colors.grey,size: 13,)
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 140,
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 0,left: 16,right: 0,bottom: 0),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 4,
                itemBuilder: (context,index) => Container(
                  padding: const EdgeInsets.only(right: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                  imageUrl: 'https://muahangdambao.com/wp-content/uploads/2021/04/offer-la-gi-04.jpg',
                                  fit: BoxFit.contain,
                              ),
                              Positioned(
                                top: 0,right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: subColor,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                    )
                                  ),
                                  child: const Center(
                                    child: Text('11-20/02/2022',style: TextStyle(color: Colors.white,fontSize: 11),),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Center(
                        child: Text('Voucher $index',style: const TextStyle(color: Colors.black,fontSize: 12),),
                      ),
                    ],
                  ),
                ),
            ),
          )
        ],
      ),
    );
  }

  List<String> listVoucher = [
    "https://wallpapercave.com/wp/wp5578722.jpg",
    "https://c4.wallpaperflare.com/wallpaper/835/696/883/women-legs-fashion-model-wallpaper-preview.jpg",
    "https://hdwallpaperim.com/wp-content/uploads/2017/08/22/169840-women-model-brunette-street-fashion-red_lipstick-brown_eyes-748x499.jpg"
  ];

  Widget buildVoucher(){
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16,bottom: 16,right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Khuyến mãi'.toUpperCase(),style: TextStyle(color: mainColor,fontWeight: FontWeight.bold),),
                    Row(
                      children: const [
                        Text('Xem thêm',style: TextStyle(color: Colors.grey,fontSize: 11),),
                        SizedBox(width: 5,),
                        Icon(Icons.arrow_forward_ios_sharp,color: Colors.grey,size: 13,)
                      ],
                    ),
                  ],
                ),
              ),
              CarouselSlider(
                items: listVoucher.map((index) {
                  return Builder(
                    builder: (BuildContext context) {
                      return TouchableWidget(
                        onPressed: () {},
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(0.0),
                        margin: const EdgeInsets.symmetric(horizontal: 6.0),
                        decoration: const BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: CachedNetworkImage(
                            imageUrl: index,
                            fit: BoxFit.fill,
                            height: MediaQuery.of(context).size.height ,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
                carouselController: CarouselController(),
                options: CarouselOptions(
                  height: 155.0,
                  // aspectRatio: 19/8.5,
                  viewportFraction: 1.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  // enlargeCenterPage: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  onPageChanged: (index, reason) {
                    _bloc.add(IndexBanner(indexBanner: index));
                    // setState(() {
                    //   _currentIndexData3 = index;
                    // });
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
          _buildIndicators(),
        ],
      ),
    );
  }

  _buildIndicators() {
    return Positioned(
      bottom: 12,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: WrapContentHozListView(
          list: listVoucher,
          itemBuilder: (context, index) {
            return _buildIndicatorNormal(_bloc.indexBanner == index);
          },
        ),
      ),
    );
  }

  _buildIndicatorNormal(bool isSelected) {
    return Container(
      height: isSelected ? 5 : 4,
      width: isSelected ? 18 : 16,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isSelected ? kWhite : kWhite_50,
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
    );
  }

  Widget buildInputCode(){
    return Padding(
      padding: const EdgeInsets.only(top: 16,bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16,bottom: 16,right: 8),
            child: Text('Nhập mã giới thiệu'.toUpperCase(),style: TextStyle(color: mainColor,fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16),
            child: DottedBorder(
              dashPattern: const [5, 3],
              color: Colors.grey,
              borderType: BorderType.RRect,
              radius: const Radius.circular(2),
              padding: const EdgeInsets.only(bottom: 8),
              child: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(focusNodeContentName),
                child: Container(
                  height: 35,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          maxLines: 5,
                          // obscureText: true,
                          controller: inputCodeController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.all(7),
                            hintText: '',
                            hintStyle: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                          ),
                          // focusNode: focusNodeContent,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.left,
                          style:  const TextStyle(fontSize: 14),
                          //textInputAction: TextInputAction.none,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 16,top: 10),
                        child: Icon(Icons.send_outlined,color: Colors.deepOrangeAccent,size: 22,),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
