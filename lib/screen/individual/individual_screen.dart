import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:maw/screen/individual/profile/profile_screen.dart';
import 'package:maw/screen/order/order_screen.dart';
import 'package:maw/screen/service/service_screen.dart';
import 'package:maw/screen/ticket/ticket_screen.dart';
import 'package:maw/screen/voucher/voucher_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../themes/colors.dart';
import '../../utils/const.dart';
import '../../widgets/custom_rate.dart';

class IndividualScreen extends StatefulWidget {
  const IndividualScreen({Key? key}) : super(key: key);

  @override
  _IndividualScreenState createState() => _IndividualScreenState();
}

class _IndividualScreenState extends State<IndividualScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              width: double.infinity,
              color: mainColor,
              padding: const EdgeInsets.only(left: 16,right: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40), // Image border
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(30), // Image radius
                            child: CachedNetworkImage(
                              imageUrl: 'https://i.pinimg.com/564x/5e/93/14/5e9314a0f83f3f48e5d5fde1a77d3519.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: Const.kDefaultPadding * 0.55,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Hoàng Thu Trang',style: TextStyle(color: Colors.white),),
                            const SizedBox(height: Const.kDefaultPadding * 0.25,),
                            GestureDetector(
                              onTap: ()=> pushNewScreen(context, screen: const ProfileScreen(),withNavBar: false),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 30),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(24),border:Border.all(color: Colors.white,width: 0.8)),
                                child: const Center(child: Text('Xem thông tin',style: TextStyle(color: Colors.white,fontSize: 10),),),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.phone,color: Colors.white,),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.message,color: Colors.white,),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.notifications,color: Colors.white,),
                  ),
                ],
              ),
            ),
            buildOder(),
            Container(
              height: 5,
              width: double.infinity,
              color: Colors.grey.withOpacity(0.3),
            ),
            buildExtension(),
            Container(
              height: 5,
              width: double.infinity,
              color: Colors.grey.withOpacity(0.3),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 10),
              child: Column(
                children: [
                  InkWell(
                      onTap:()=> pushNewScreen(context, screen: const TicketScreen(),withNavBar: false),
                      child: buildMenuLine(MdiIcons.bookOpenPageVariantOutline, 'Quản lý ticket',mainColor)),
                  const Divider(),
                  InkWell(
                      onTap: (){
                        showDialog(context: context,
                            builder: (BuildContext context){
                              return const CustomRate(
                                title: "Phản hồi dịch vụ",
                                descriptions: "Xin vui lòng gửi đánh giá về chất lượng dịch vụ của chúng tôi",
                                text: "Gửi",
                                hintText: 'Góp ý cho chúng tôi tại đây',
                              );
                            }
                        );
                      },
                      child: buildMenuLine(MdiIcons.messageAlertOutline, 'Phản hồi dịch vụ',mainColor)),
                  const Divider(),
                  InkWell(
                      onTap: (){
                        showDialog(context: context,
                            builder: (BuildContext context){
                              return const CustomRate(
                                title: "Góp ý về sản phẩm",
                                descriptions: "Xin vui lòng gửi góp ý về sản phẩm của chúng tôi",
                                text: "Gửi",
                                hintText: 'Góp ý cho chúng tôi tại đây',
                              );
                            }
                        );
                      },
                      child: buildMenuLine(MdiIcons.emailOutline, 'Góp ý phát triển sản phẩm',mainColor)),
                ],
              ),
            ),
            Container(
              height: 5,
              width: double.infinity,
              color: Colors.grey.withOpacity(0.3),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16,bottom: 10),
              child: buildMenuLine(Icons.logout, 'Đăng xuất',Colors.grey),
            ),
          ],
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
              GestureDetector(
                  onTap:()=> pushNewScreen(context, screen: const ServiceScreen()),
                  child: buildMenu(MdiIcons.spotify, 'Gói dịch vụ',mainColor)),
              GestureDetector(
                  onTap:()=> pushNewScreen(context, screen: const VoucherScreen()),
                  child: buildMenu(MdiIcons.walletOutline, 'Ví voucher',mainColor)),
              buildMenu(MdiIcons.cartOutline, 'Giỏ hàng',mainColor),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildOder(){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 8),
          child: InkWell(
            onTap: ()=> pushNewScreen(context, screen: const OrderScreen(indexTab: 0,)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.more_time,color: mainColor,),
                    const SizedBox(width: Const.kDefaultPadding * 0.65,),
                    const Text('Đơn hàng',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  ],
                ),
                const Icon(Icons.navigate_next,color: Colors.black,),
              ],
            ),
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: ()=> pushNewScreen(context, screen: const OrderScreen(indexTab: 0,)),
                  child: buildMenu(MdiIcons.tooltipEditOutline, 'Chờ xác nhận',Colors.blueGrey)),
              GestureDetector(
                  onTap: ()=> pushNewScreen(context, screen: const OrderScreen(indexTab: 1,)),
                  child: buildMenu(MdiIcons.cartOutline, 'Đang thực hiện',Colors.blueGrey)),
              GestureDetector(
                  onTap: ()=> pushNewScreen(context, screen: const OrderScreen(indexTab: 2,)),
                  child: buildMenu(MdiIcons.checkboxMarkedOutline, 'Hoàn thành',Colors.blueGrey)),
              GestureDetector(
                  onTap: ()=> pushNewScreen(context, screen: const OrderScreen(indexTab: 3,)),
                  child: buildMenu(MdiIcons.cancel, 'Đã Huỷ',Colors.blueGrey)),
            ],
          ),
        ),
      ],
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

  Widget buildMenuLine(IconData icon,String title, Color color){
    return Padding(
      padding: const EdgeInsets.only(left: 16,right: 16,top: 5,bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon,color: color,size: 20,),
              const SizedBox(width: Const.kDefaultPadding * 0.55,),
              Text(title, style: const TextStyle(color: Colors.black),),
            ],
          ),
          const Icon(Icons.navigate_next,color: Colors.grey,),
        ],
      ),
    );
  }
}
