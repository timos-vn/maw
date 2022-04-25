import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../themes/colors.dart';
import '../../../widgets/custom_ticket.dart';
import '../../../widgets/hoz_list_view.dart';
import '../../../widgets/quantity_widget.dart';
import '../../../widgets/touchable_widget.dart';
import '../order_for_someone/order_for_someone_screen.dart';
import 'components/desc_product.dart';
import 'components/popup_recommend_to_friends.dart';
import 'components/review_product.dart';
import 'detail_product_bloc.dart';
import 'detail_product_event.dart';
import 'detail_product_state.dart';

class DetailProductScreen extends StatefulWidget {
  const DetailProductScreen({Key? key}) : super(key: key);

  @override
  _DetailProductScreenState createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> with TickerProviderStateMixin{

  late DetailProductBloc _bloc;
  late TabController tabController;
  List<String> listProduct = [
    "https://hc.com.vn/i/ecommerce/media/00033736_FEATURE_40133.jpg",
    "https://fpt123.net/uploads/images/may-loc-nuoc/karofi-e239.png",
    "https://hc.com.vn/i/ecommerce/media/GD.000340_FEATURE_43864.jpg"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = DetailProductBloc();
    tabController = TabController(vsync:this,length:2);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailProductBloc,DetailProductState>(
      listener: (context,state){

      },
      bloc: _bloc,
      child: BlocBuilder<DetailProductBloc,DetailProductState>(
        bloc: _bloc,
        builder: (BuildContext context,DetailProductState state){
          return buildPage(context,state);
        },
      ),
    );
  }

  Widget buildPage(BuildContext context,DetailProductState state){
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
              padding: const EdgeInsets.only(left: 10,right: 10,bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: ()=> Navigator.pop(context),
                    child: const SizedBox(
                        height:20,
                        width: 50,
                        child: Icon(Icons.arrow_back_ios,color: Colors.black,size: 20,)),
                  ),
                  const Text('Chi tiết sản phẩm',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 0),
                        child: Icon(Icons.help,color: mainColor,),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
                color: Colors.white,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CarouselSlider(
                      items: listProduct.map((index) {
                        return Builder(
                          builder: (BuildContext context) {
                            return TouchableWidget(
                              onPressed: () {},
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(0.0),
                              margin: const EdgeInsets.symmetric(horizontal: 0.0),
                              decoration: const BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.all(Radius.circular(0.0)),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0.0),
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
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    _buildIndicators(),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.only(left: 5,top: 5,right: 3,bottom: 3),
                        width: 140,
                        decoration: BoxDecoration(
                          color: subColor,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text('+5 điểm khi mua\n+5 điểm khi giới thiệu',style: TextStyle(color: Colors.white,fontSize: 11),maxLines: 2,overflow: TextOverflow.ellipsis,),
                          ],
                        ),
                      ),
                    )
                  ],
                )
            ),
            Expanded(child: buildBody(height)),
          ],
        ),
      ),
    );
  }

  _buildIndicators() {
    return Positioned(
      bottom: 12,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          child: WrapContentHozListView(
            list: listProduct,
            itemBuilder: (context, index) {
              return _buildIndicatorNormal(_bloc.indexBanner == index);
            },
          ),
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

  Widget buildBody(double height){
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(height: 1,width: double.infinity,color: Colors.blueGrey.withOpacity(0.5),),
                Container(
                  padding: const EdgeInsets.only(top: 20,left: 16,right: 16,bottom: 20),
                    width: double.infinity,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Bộ 3 lõi lọc 123 RO EuroAqua C Made in Russia',style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold,fontSize: 15),),
                        const SizedBox(height: 10,),
                        Row(
                          children: const [
                            Icon(MdiIcons.tag,color: Colors.grey,size: 20,),
                            SizedBox(width: 5,),
                            Text('Đại lý ENTERBUY',style: TextStyle(color: Colors.black,fontSize: 12),),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text('180.000đ',style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16,right: 16),
                                  child: DottedBorder(
                                    dashPattern: [5, 3],
                                    color:subColor,
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(2),
                                    padding: const EdgeInsets.only(top: 2,bottom: 2,left: 16,right: 8),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                      ),
                                      child: Center(child: Text('-5%',style: TextStyle(color: subColor,fontSize: 11),)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0,right: 8),
                                  child: DottedBorder(
                                    dashPattern: const [5, 3],
                                    color:subColor,
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(2),
                                    padding: const EdgeInsets.only(top: 2,bottom: 2,left: 16,right: 16),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                      ),
                                      child: Center(child: Text('Freeship',style: TextStyle(color: subColor,fontSize: 11),)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            QuantityWidget(
                              initQuantity: 1,//data.soLuong.round(),
                              valueChanged: (quantity) {
                                //_bloc.listChildItemSelected[i].soLuong = quantity;
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            Row(
                              children: [
                                Icon(MdiIcons.starOutline,color: subColor,size: 18,),
                                Icon(MdiIcons.starOutline,color: subColor,size: 18),
                                Icon(MdiIcons.starOutline,color: subColor,size: 18),
                                Icon(MdiIcons.starOutline,color: subColor,size: 18),
                                Icon(MdiIcons.starOutline,color: subColor,size: 18),
                              ],
                            ),
                            const SizedBox(width: 10,),
                            const Text('5.0',style: TextStyle(color: Colors.black,fontSize: 13),),
                            const SizedBox(width: 10,),
                            Container(height: 14,width: 1,color: Colors.grey,),
                            const SizedBox(width: 10,),
                            const Text('Đã bán 300',style: TextStyle(color: Colors.black,fontSize: 13),),
                          ],
                        ),
                      ],
                    )),
                Container(height: 3,width: double.infinity,color: Colors.blueGrey.withOpacity(0.5),),
                Container(
                  padding: const EdgeInsets.only(top: 20,left: 0,right: 4,bottom: 20),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: ()=> pushNewScreen(context, screen: const OrderForSomeOneScreen(),withNavBar: false),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(MdiIcons.cartOutline,color: mainColor,),
                              const SizedBox(height: 5,),
                              const Text('Đặt hàng hộ',style: TextStyle(color: Colors.black,fontSize: 12),),
                            ],
                          ),
                        ),
                      ),
                      Container(height: 40,width: 1,color: Colors.blueGrey,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.file_copy_outlined,color: mainColor,),
                            const SizedBox(height: 5,),
                            const Text('Mã giới thiệu',style: TextStyle(color: Colors.black,fontSize: 12),),
                          ],
                        ),
                      ),
                      Container(height: 40,width: 1,color: Colors.blueGrey,),
                      Expanded(
                        child: InkWell(
                          onTap: ()=> showDialog(
                              barrierDismissible: false,
                              context: context,builder: (context)=>RecommendToFriendScreen()),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(MdiIcons.accountMultipleOutline,color: mainColor,),
                              const SizedBox(height: 5,),
                              const Center(child: Text('Giới thiệu cho bạn bè',style: TextStyle(color: Colors.black,fontSize: 12),textAlign: TextAlign.center,)),
                            ],
                          ),
                        ),
                      ),
                      Container(height: 40,width: 1,color: Colors.blueGrey,),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.share,color: mainColor,),
                            const SizedBox(height: 5,),
                            const Center(child: Text('Chia sẻ\nmạng xã hội',style: TextStyle(color: Colors.black,fontSize: 12),textAlign: TextAlign.center)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.blueGrey.withOpacity(0.1),
                  padding: const EdgeInsets.only(top: 20,left: 16,right: 16,bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Voucher khả dụng',style: TextStyle(color: mainColor),),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 2,
                          padding: const EdgeInsets.only(top: 16,left: 0,right: 16,bottom: 0),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context,index){
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: ClipPath(
                                clipper: TicketClipper(),
                                child: Container(
                                  height: 55,
                                  width: 200,
                                  color: mainColor,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 20,top: 5,bottom: 5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: const [
                                              Text('Giảm 5%',style: TextStyle(color: Colors.white,fontSize: 10),),
                                              SizedBox(height: 3,),
                                              Text('Điều kiện',style: TextStyle(color: Colors.white,fontSize: 10),),
                                              SizedBox(height: 3,),
                                              Text('HSD: 04.03.2022',style: TextStyle(color: Colors.white,fontSize: 10),),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 1,
                                        color: subColor,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10,right: 10),
                                        child: Container(
                                          padding: const EdgeInsets.only(left: 10,right: 10,top: 6,bottom: 6),
                                          height: 25,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(Radius.circular(6)),
                                          ),
                                          child: Center(child: Text('Chọn',style: TextStyle(color: mainColor,fontSize: 11),),),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(height: 3,width: double.infinity,color: Colors.blueGrey.withOpacity(0.5),),
                Padding(
                  padding: const EdgeInsets.only(top: 20,left: 16,right: 16,bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quà tặng khi mua sản phẩm',style: TextStyle(color: mainColor),),
                      const SizedBox(height: 10,),
                      SizedBox(height: 80,child: giftsWhenBuy(height)),
                    ],
                  ),
                ),
                Container(height: 3,width: double.infinity,color: Colors.blueGrey.withOpacity(0.5),),
                Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: TabBar(
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
                      tabs: List<Widget>.generate(_bloc.listTabView.length, (int index) {
                        return Tab(
                          text: _bloc.listTabView[index].toString(),
                        );
                      }),
                    )
                ),
                SizedBox(
                  height: 350,
                  child: TabBarView(
                      controller: tabController,
                      children: List<Widget>.generate(_bloc.listTabView.length, (int index) {
                        for (int i = 0; i <= _bloc.listTabView.length; i++) {
                          if (index == 0) {
                            return const DESCProductScreen();
                          }else if(index == 1){
                            return const ReviewProductScreen();
                          }
                        }
                        return const Text('');
                      })),
                ),
              ],
            ),
          ),
        ),
        Container(height: 2,width: double.infinity,color: Colors.blueGrey.withOpacity(0.2),),
        Container(
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.only(left: 16,right: 16,top: 5,bottom: 5),
          // height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Icon(Icons.add_shopping_cart_outlined,color: subColor,),
                  const Text(
                    'Thêm vào giỏ hàng',style:  TextStyle(fontSize: 10),),
                ],
              ),
              const SizedBox(width: 50,),
              Expanded(
                child: InkWell(
                  onTap: () {

                  },
                  child: Card(
                    elevation: 2,
                    shadowColor: Colors.grey,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.shade200,
                                offset: const Offset(2, 4),
                                blurRadius: 5,
                                spreadRadius: 2)
                          ],
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [mainColor, mainColor])),
                      child: const Text(
                        'Mua ngay',
                        style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget giftsWhenBuy(double height){
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context,index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16,bottom: 0),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 30,
                    padding: const EdgeInsets.all(6),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)
                      ),
                      color: mainColor,
                    ),
                    child: const Center(child: Text('2.400.000đ',style: TextStyle(color: Colors.white,fontSize: 11),overflow: TextOverflow.ellipsis,maxLines: 1,)),
                  ),
                ),
                Container(
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                          color: mainColor
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 6,left: 8),
                        child: Text('E-Test $index',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 11),overflow: TextOverflow.ellipsis,maxLines: 1,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5,left: 8,bottom: 5,right: 8),
                        child: Text('($index chỉ tiêu)',style: const TextStyle(color: Colors.grey,fontSize: 11),overflow: TextOverflow.ellipsis,maxLines: 2,),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
    );
  }


}
