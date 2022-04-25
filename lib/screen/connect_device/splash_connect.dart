import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../themes/colors.dart';
import 'connect_hand/connect_hand_screen.dart';
import 'connect_wifi/component/connectivity_page.dart';


class SplashConnectScreen extends StatelessWidget {
  const SplashConnectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:Container(
          padding: const EdgeInsets.only(left: 16,right: 16),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Image.asset('assets/images/splash1.png')),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Kết nối thiết bị',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                  InkWell(
                      onTap:()=> Navigator.pop(context),
                      child: SizedBox(
                          width: 40,
                          child: Text('Thoát',style: TextStyle(color: subColor,),))),
                ],
              ),
              const SizedBox(height: 20,),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12,right: 12,top: 16,bottom: 16),
                  child: Row(
                    children: [
                      const Icon(MdiIcons.gestureTap,color: Colors.grey,size: 70,),
                      const SizedBox(width: 6,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Lưu ý',style: TextStyle(color: subColor,fontWeight: FontWeight.bold,fontSize: 14),),
                            const SizedBox(height: 5,),
                            const Text('Rút điện nguồn. Bấm và giữ reset của bộ wifi khoảng 5s, đồng thời cắm nguồn điện trở lại để tìm kiếm thiết bị.',style: TextStyle(color: Colors.black,fontSize: 12),maxLines: 3,),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const  SizedBox(height: 40,),
              GestureDetector(
                onTap: ()=>pushNewScreen(context, screen: const ConnectivityPage()),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(24),color: mainColor),
                  child: const Center(child: Text('Kết nối thiết bị qua wifi',style: TextStyle(color: Colors.white),)),
                ),
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: ()=> pushNewScreen(context, screen: const ConnectHandScreen()),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(24),color: Colors.grey.withOpacity(0.3)),
                  child: const Center(child: Text('Kết nối thiết bị thủ công',style: TextStyle(color: Colors.black),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
