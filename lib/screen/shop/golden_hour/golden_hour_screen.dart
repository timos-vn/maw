import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../themes/colors.dart';
import '../../../widgets/custom_count_down_timer.dart';
import '../../../widgets/custom_paint.dart';
import '../detail_product/detail_product_screen.dart';
import 'golden_hour_bloc.dart';
import 'golden_hour_state.dart';

class GoldenHourScreen extends StatefulWidget {
  const GoldenHourScreen({Key? key}) : super(key: key);

  @override
  _GoldenHourScreenState createState() => _GoldenHourScreenState();
}

class _GoldenHourScreenState extends State<GoldenHourScreen>with TickerProviderStateMixin {

  late GoldenHourBloc _bloc;
  int levelClock = 180;
  late AnimationController _controller;
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = GoldenHourBloc();
    tabController = TabController(vsync:this,length:3);
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            seconds: levelClock)
    );
    // _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<GoldenHourBloc,GoldenHourState>(
      listener: (context,state){

      },
      bloc: _bloc,
      child: BlocBuilder<GoldenHourBloc,GoldenHourState>(
        bloc: _bloc,
        builder: (BuildContext context,GoldenHourState state){
          return buildPage(context,state);
        },
      ),
    );
  }

  Widget buildPage(BuildContext context,GoldenHourState state){
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: Colors.grey.withOpacity(0.1),
        padding: const EdgeInsets.only(top: 0,bottom: 0),
        child: Column(
          //padding: EdgeInsets.only(bottom: height * .1,),
          children: [
            Container(
                color: Colors.white,
                child: buildTitle(height)),
            Expanded(child: buildBody(height)),
          ],
        ),
      ),
    );
  }

  Widget buildTitle(double height){
    return Padding(
      padding: EdgeInsets.only(top: height * .05,left: 10,right: 18),
      child: Column(
        children: [
          Row(
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
                      Expanded(child: Text('Chương trình giờ vàng',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,)),
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
                padding: const EdgeInsets.only(left: 20,right: 12),
                child: Stack(
                  overflow: Overflow.visible,
                  children: [
                    Icon(Icons.shopping_cart_rounded,color: mainColor,),
                    Positioned(
                        top: -5,
                        right: -MediaQuery.of(context).size.width * .01,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(44)),
                            color: Colors.red,
                          ),
                          height: 10,width: 10,
                        )
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 25,),
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16),
            child: Row(
              children: [
                const Text(
                  'Thời gian còn lại:',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal),
                ),
                const SizedBox(width: 16,),
                CountDownTimer(
                  animation: StepTween(
                    begin: levelClock, // THIS IS A USER ENTERED NUMBER
                    end: 0,
                  ).animate(_controller),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8,),
          TabBar(
            controller: tabController,
            unselectedLabelColor: Colors.black.withOpacity(0.7),
            labelColor: mainColor,
            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
            isScrollable: false,
            indicatorPadding: const EdgeInsets.all(0),
            indicatorColor: Colors.orange,
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    style: BorderStyle.solid,
                    color: mainColor,
                    width: 2
                ),
              ),
            ),
            tabs: List<Widget>.generate(_bloc.listTabViewSale.length, (int index) {
              return Tab(
                text: _bloc.listTabViewSale[index].toString(),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget buildBody(double height){
    return Column(
      children: [
        const SizedBox(height: 8,),
        Expanded(
          child: TabBarView(
              controller: tabController,
              children: List<Widget>.generate(_bloc.listTabViewSale.length, (int index) {
                for (int i = 0; i <= _bloc.listTabViewSale.length; i++) {
                  if (i == index) {
                    return buildPageSale(context, index,height);
                  }
                }
                return const Text('');
              })),
        ),
      ],
    );
  }

  Widget buildPageSale(BuildContext context, int i,double height) {
    return ListView.separated(
      padding: EdgeInsets.only(bottom: height * .1),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => pushNewScreen(context, screen: const DetailProductScreen(),withNavBar: false),

                //Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailProductScreen())),
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 12,left: 16,right: 10,bottom: 10),
                    height: 150,
                    color: Colors.white,
                    child: Stack(
                      overflow: Overflow.visible,
                      children: [
                        Container(
                          height: 140,width: 130,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey
                              )
                          ),
                          child: CachedNetworkImage(
                            imageUrl: 'https://i.pinimg.com/564x/5e/93/14/5e9314a0f83f3f48e5d5fde1a77d3519.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: -8,
                          top: -10,
                          child: CustomPaint(
                            size: const Size(100, 20),
                            painter: ProductLikePaint(),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8,right: 8,top: 6,bottom: 10),
                              child: Center(child: Text('Discount $index%',style: const TextStyle(fontSize: 9,color: Colors.white),)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10,top: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Máy lọc nước điện giải lon kiềm Panasonic TK-AS45',style: TextStyle(color: Colors.black,fontSize: 13),maxLines: 2,overflow: TextOverflow.ellipsis,),
                          const SizedBox(height: 10,),
                          const Text('25.500.000đ',style: TextStyle(color: Colors.grey,fontSize: 11,decoration: TextDecoration.lineThrough)),
                          const SizedBox(height: 5,),
                          const Text('35.500.000đ',style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 15,width: 120,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(40.0))),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                                          child: TweenAnimationBuilder<double>(
                                            tween: Tween<double>(begin: 0.0, end: 1),
                                            duration: const Duration(milliseconds: 3500),
                                            builder: (context, value, _) => LinearProgressIndicator(
                                              value: index/10,
                                              minHeight: 15.0,
                                              color: Colors.red,
                                              backgroundColor: Colors.grey,
                                            ),
                                          )
                                      ),
                                      Positioned(
                                          top: 0,
                                          left: 0,
                                          bottom: 3,
                                          right: 0,
                                          child: Center(child: Text('Đã bán $index',style: const TextStyle(color: Colors.white,fontSize: 9),),)),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 10,left: 16,right: 16,bottom: 10),
                                  decoration: BoxDecoration(
                                      color: mainColor,
                                      borderRadius: const BorderRadius.all(Radius.circular(8))
                                  ),
                                  height: 35,
                                  child: const Center(
                                    child: Text('Mua ngay',style: TextStyle(color: Colors.white,fontSize: 12),textAlign: TextAlign.center,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => Container(height: 8,),
        itemCount: 5);
  }
}
