import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:maw/screen/map/water_test/water_test_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../themes/colors.dart';
import '../../widgets/custom_radio_button.dart';
import 'component/news_water.dart';
import 'expert_lib/expert_lib_screen.dart';
import 'map_bloc.dart';
import 'map_event.dart';
import 'map_state.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  late MapBloc _bloc;

  CameraPosition initialCameraPosition = const CameraPosition(
      zoom: 16.0,
      tilt: 80,
      bearing: 30,
      target: LatLng(21.005014967725078, 105.81377066191367)
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = MapBloc(context);
    _bloc.add(GetPrefs());
    // _bloc.add(GetListWaterFactory());
    // _bloc.add(GetListWaterTestingCenter());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MapBloc,MapState>(
      listener: (context,state){

      },
      bloc: _bloc,
      child: BlocBuilder<MapBloc,MapState>(
        bloc: _bloc,
        builder: (BuildContext context,MapState state){
          return buildPage(context,state);
        },
      ),
    );
  }

  Widget buildPage(BuildContext context,MapState state){
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 300,
                    // child: GoogleMap(
                    //   myLocationEnabled: true,
                    //   compassEnabled: false,
                    //   myLocationButtonEnabled: false,
                    //   tiltGesturesEnabled: false,
                    //   zoomGesturesEnabled: true,
                    //   zoomControlsEnabled: false,
                    //   // polylines: _polylines,
                    //   // markers: _markers,
                    //   mapType: MapType.normal,
                    //   initialCameraPosition: initialCameraPosition,
                    //   onMapCreated: (GoogleMapController controller) {
                    //     // _controller.complete(controller);
                    //     // showPinsOnMap();
                    //     // setPolylines();
                    //   },
                    // ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                      left: 0,
                    child: Container(
                      color: text_gray_c.withOpacity(0.4),
                      height: 100,
                      child: Padding(
                        padding: EdgeInsets.only(top: height * .04,left: 24,right: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.help,color: mainColor,),
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
                                  child: Icon(Icons.notifications,color: mainColor,),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16,right: 16,top: 16,bottom: height * .01),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Tìm kiếm',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                          const SizedBox(height: 12,),
                          GestureDetector(
                            onTap: (){
                              showFilter(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.only(left: 16,right: 16,top: 2),
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                                  color: Colors.grey.withOpacity(0.3)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text('Tìm kiếm sản phẩm',style: TextStyle(fontSize: 12),),
                                  Icon(Icons.search_outlined,color: Colors.grey.withOpacity(0.8),),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40,left: 8,right: 8),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.search_outlined,color: mainColor,),
                                        const SizedBox(width: 10,),
                                        const Text('Gần đây',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                    const Text('Xem thêm',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 11),),
                                  ],
                                ),
                                const Divider()
                              ],
                            ),
                          ),
                          ListView.builder(
                              padding: const EdgeInsets.only(top: 2,left: 0,right: 0,bottom: 0),
                              shrinkWrap: true,
                              itemCount: 2,
                              itemBuilder: (context,index) =>
                                  Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white,
                                    ),
                                    padding: const EdgeInsets.only(top: 5,right: 6,left: 10,bottom: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Text('Title',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black),),
                                            SizedBox(height: 3,),
                                            Text('Subtitle',style: TextStyle(color: Colors.grey,fontSize: 12),),
                                          ],
                                        ),
                                        const Icon(Icons.navigate_next,color: Colors.grey,),
                                      ],
                                    ),
                                  )
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.only(top: 16,left: 8,right: 8),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: ()=> pushNewScreen(context, screen: const WaterTestScreen(),withNavBar: false),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.book,color: mainColor,),
                                          const SizedBox(width: 10,),
                                          const Text('Đăng ký xét nghiệm nước',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                      const Icon(Icons.navigate_next,color: Colors.grey,),
                                    ],
                                  ),
                                ),
                                const Divider()
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16,left: 8,right: 8),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap:()=> pushNewScreen(context, screen: const NewsWaterScreen(),withNavBar: false),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(MdiIcons.newspaper,color: mainColor,),
                                          const SizedBox(width: 10,),
                                          const Text('Tin tức mới về nước sinh hoạt',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                      const Icon(Icons.navigate_next,color: Colors.grey,),
                                    ],
                                  ),
                                ),
                                const Divider()
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16,left: 8,right: 8),
                            child: InkWell(
                              onTap: ()=> pushNewScreen(context, screen:const  ExpertLibScreen(),withNavBar: false),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.menu_book_sharp,color: mainColor,),
                                          const SizedBox(width: 10,),
                                          const Text('Thư viện chuyên gia',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                      const Icon(Icons.navigate_next,color: Colors.grey,),
                                    ],
                                  ),
                                  const Divider()
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              )
            ],
          ),
        ],
      ),
    );
  }

  int _value = 1;

  void showFilter(BuildContext context){
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (builder){
          return FractionallySizedBox(
            heightFactor: 0.7,
            child: StatefulBuilder(
              builder: (BuildContext context,StateSetter myState){
                return Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 48),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0,left: 16,right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(Icons.check,color: Colors.white,),
                                  const Text('Tìm kiếm',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800),),
                                  InkWell(
                                      onTap: ()=> Navigator.pop(context),
                                      child: const Icon(Icons.close,color: Colors.black,)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8,),
                            const Divider(color: Colors.blueGrey,),
                            const Padding(
                              padding: EdgeInsets.only(top: 8,left: 16),
                              child: Align(alignment: Alignment.centerLeft,child: Text('Đối tượng tìm kiếm',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800),)),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 14,bottom: 14),
                                  child: MyRadioListTile<int>(
                                    value: 1,
                                    groupValue: _value,
                                    title: const Text('Kết quả xét nghiệm nước'),
                                    onChanged: (value) => myState(() => _value = value),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Divider(
                                    height: 0.7,thickness: 0.8,color: Colors.grey.withOpacity(0.3),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 14,bottom: 14),
                                  child: MyRadioListTile<int>(
                                    value: 2,
                                    groupValue: _value,
                                    title: const Text('Trung tâm xét nghiệm nước'),
                                    onChanged: (value) => myState(() => _value = value),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Divider(
                                    height: 0.7,thickness: 0.8,color: Colors.grey.withOpacity(0.3),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 14,bottom: 14),
                                  child: MyRadioListTile<int>(
                                    value: 3,
                                    groupValue: _value,
                                    title: const Text('Nhà máy nước'),
                                    onChanged: (value) => myState(() => _value = value),
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 8,left: 16),
                              child: Align(alignment: Alignment.centerLeft,child: Text('Địa điểm',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800),)),
                            ),
                            // ignore: avoid_returning_null_for_void
                            chooseAddress('Thành phố/Tỉnh: ',()=> null),
                            chooseAddress('Quận/huyện: ',()=> null),
                            chooseAddress('Phường/Xã: ',()=> null),
                            Padding(
                              padding: const EdgeInsets.only(left: 16,bottom: 0,right: 16,top:35),
                              child: InkWell(
                                onTap: () {
                                  // _bloc.add(SortListEvent(typeSort:_value));
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(16)),
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
                                    'Tìm kiếm',
                                    style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                );
              },
            ),
          );
        }
    );
  }

  Widget chooseAddress(String title,VoidCallback onTap){
    return Padding(
      padding: const EdgeInsets.only(left: 16,right: 16,top: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(title,style: const TextStyle(color: Colors.black,fontSize: 12),),
            ),
            const SizedBox(width: 6,),
            Expanded(
              flex: 2,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: mainColor)
                ),
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.arrow_right,color: Colors.blueGrey,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
