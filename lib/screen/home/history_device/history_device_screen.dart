import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../themes/colors.dart';
import '../../../widgets/custom_rate.dart';
import '../update_history/update_history_screen.dart';
import 'history_device_bloc.dart';
import 'history_device_state.dart';

class HistoryDeviceScreen extends StatefulWidget {
  const HistoryDeviceScreen({Key? key}) : super(key: key);

  @override
  _HistoryDeviceScreenState createState() => _HistoryDeviceScreenState();
}

class _HistoryDeviceScreenState extends State<HistoryDeviceScreen>{

  late HistoryDeviceBloc _bloc;
  late TabController tabController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = HistoryDeviceBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HistoryDeviceBloc,HistoryDeviceState>(
      listener: (context,state){

      },
      bloc: _bloc,
      child: BlocBuilder<HistoryDeviceBloc,HistoryDeviceState>(
        bloc: _bloc,
        builder: (BuildContext context,HistoryDeviceState state){
          return buildPage(context,state);
        },
      ),
    );
  }


  Widget buildPage(BuildContext context,HistoryDeviceState state){
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: GestureDetector(
        onTap: ()=> pushNewScreen(context, screen: const UpdateHistoryDeviceScreen()),
        child: Container(
          padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: subColor
            ),
            child: const Icon(Icons.add,color: Colors.white,)),
      ),
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
                          Expanded(child: Text('Lịch sử thiết bị',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,)),
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
            Expanded(child: buildBody(height)),
          ],
        ),
      ),
    );
  }

  Widget buildBody(double height){
    return Padding(
      padding: EdgeInsets.only(bottom: height * .1,top: 20,left: 16,right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10,right: 10,bottom: 2,top: 2),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(8))
                  ),
                  child: Row(
                    children: const [
                      Text('Hoàn thành',style: TextStyle(color: Colors.black,fontSize: 10),),
                      SizedBox(width: 6,),
                      Icon(Icons.arrow_drop_down_outlined,color: Colors.blueGrey,),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10,right: 10,bottom: 2,top: 2),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(8))
                  ),
                  child: Row(
                    children: const [
                      Text('Năm nay',style: TextStyle(color: Colors.black,fontSize: 10),),
                      SizedBox(width: 6,),
                      Icon(Icons.arrow_drop_down_outlined,color: Colors.blueGrey,),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                // controller: _scrollController,
                padding: EdgeInsets.zero,
                separatorBuilder: (BuildContext context, int index)=>Container(),
                itemBuilder: (BuildContext context, int index){
                  return //index >= length ?
                    // Container(
                    //   height: 100.0,
                    //   color: white,
                    //   child: PendingAction(),
                    // )
                    //     :
                    GestureDetector(
                        onTap: (){
                          showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                              ),
                              isScrollControlled: true,
                              builder: (context) {
                                return buildPopup(context);
                              });
                        },
                        child: buildItem(index));
                },
                itemCount: 2 //length == 0 ? length : _hasReachedMax ? length : length + 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPopup(BuildContext context){
    return SizedBox(
      height: MediaQuery.of(context).copyWith().size.height * 0.90,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 5.0,left: 16,right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.check,color: Colors.white,),
                  const Text('Chi tiết',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800),),
                  InkWell(
                      onTap: ()=> Navigator.pop(context),
                      child: const Icon(Icons.close,color: Colors.black,)),
                ],
              ),
            ),
            const SizedBox(height: 8,),
            const Divider(color: Colors.blueGrey,),
            const SizedBox(height: 8,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 80,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 10),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.blueGrey.withOpacity(0.1),
                                    border: Border.all(color: Colors.blueGrey.withOpacity(0.5))
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(6), // Image border
                                      child: SizedBox.fromSize(
                                        size: const Size.fromRadius(26), // Image radius
                                        child: CachedNetworkImage(
                                          imageUrl: 'https://i.pinimg.com/564x/5e/93/14/5e9314a0f83f3f48e5d5fde1a77d3519.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text('Thay lõi số 2',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 13),),
                                        SizedBox(height: 5,),
                                        Text('Loại ĐH: Bảo trì',style: TextStyle(color: Colors.blueGrey,fontSize: 11),),
                                      ],
                                    ),
                                    const SizedBox(width: 20,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text('x1',style: TextStyle(color: Colors.black,fontSize: 11),),
                                        const SizedBox(height: 5,),
                                        Text('180.000đ',style: TextStyle(color: subColor,fontSize: 11,fontWeight: FontWeight.bold),),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => Container(width: 10,),
                          itemCount: 5),
                    ),
                    const SizedBox(height: 8,),
                    const Divider(color: Colors.blueGrey,),
                    Padding(
                      padding: const EdgeInsets.only(top: 8,bottom: 8,right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(MdiIcons.cash, color: mainColor,),
                          const SizedBox(width: 6,),
                          const Text('Thành tiền:',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          const SizedBox(width: 6,),
                          Text('180.000đ',style: TextStyle(color: subColor,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    Container(height: 3,width: double.infinity,color: Colors.blueGrey.withOpacity(0.2),),
                    buildContentLine('Nội dung:','[Bảo trì] Thay lõi lọc nước số 2 của thiết bị lọc nước K8',false,true),
                    buildContentLine('Ghi chú của Kỹ thuật:','Đã thay xong',false,true),
                    buildContentLine('Địa chỉ nhận hàng:','262 Nguyễn Huy Tưởng, Thanh Xuân, Hà Nội',false,true),
                    buildContent('Tư vấn viên:','N/A',false,true),
                    buildContent('Kỹ thuật viên:','N/A',false,true),
                    buildContent('Đơn vị cung cấp:','MAW',false,true),
                    buildContent('Phương thức thanh toán:','C.O.D',true,false),
                    const SizedBox(height: 8,),
                    Container(height: 3,width: double.infinity,color: Colors.blueGrey.withOpacity(0.2),),
                    const SizedBox(height: 8,),
                    buildContentSub('Mã đơn hàng:','MAW2843989',false,false),
                    buildContentSub('Thời gian đặt hàng:','21/03/2022 9:05',false,false),
                    buildContentSub('Thời gian vận chuyển:','21/03/2022 9:05',false,false),
                    buildContentSub('Thời gian lắp đặt/nhận hàng:','21/03/2022 9:05',false,false),
                    buildContentSub('Thời gian thanh toán:','21/03/2022 9:05',false,false),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 10,
                            child: Container(
                              height: 35,width: 150,
                              padding: const EdgeInsets.only(left: 16,right: 16,top: 5,bottom: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueGrey.shade50),
                                  borderRadius: const BorderRadius.all(Radius.circular(10))
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.message,color: mainColor,size: 18,),
                                  const SizedBox(width: 10,),
                                  const Text('Xem bình luận',style: TextStyle(color: Colors.black,fontSize: 12),),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              showDialog(context: context,
                                  builder: (BuildContext context){
                                    return  const CustomRate(
                                      title: "Custom Dialog Demo",
                                      descriptions: "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
                                      text: "Yes",
                                    );
                                  }
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 10,
                              child: Container(
                                height: 35,
                                width: 150,
                                padding: const EdgeInsets.only(left: 16,right: 16,top: 5,bottom: 5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blueGrey.shade50),
                                    borderRadius: const BorderRadius.all(Radius.circular(10))
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.star_border_outlined,color: mainColor,size: 18,),
                                    const SizedBox(width: 10,),
                                    const Text('Đánh giá',style: TextStyle(color: Colors.black,fontSize: 12),),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 16),
                    //   child: Container(
                    //     height: 45,width: double.infinity,
                    //     padding: EdgeInsets.only(left: 16,right: 16,top: 5,bottom: 5),
                    //     decoration: BoxDecoration(
                    //         border: Border.all(color: Colors.blueGrey.shade50),
                    //         borderRadius: BorderRadius.all(Radius.circular(10)),
                    //         color: mainColor
                    //     ),
                    //     child: Center(child: Text('Mua lại',style: TextStyle(color: Colors.white),)),
                    //   ),
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildItem(int index){
    return Padding(
      padding: const EdgeInsets.only(bottom: 6,top: 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.blueGrey.withOpacity(0.1),
          border: Border.all(color: Colors.blueGrey.withOpacity(0.5))
        ),
        padding: const EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 16),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('21/03/2022',style: TextStyle(color: Colors.blueGrey,fontSize: 13),),
            const Text('Thay lõi số 2',style: TextStyle(color: Colors.black,fontSize: 13),),
            Icon(Icons.check_circle_rounded,color: mainColor,),
          ],
        ),
      ),
    );
  }

  Widget buildContentLine(String title, String subtitle,bool color,bool divider){
    return Padding(
      padding: const EdgeInsets.only(top: 5,bottom: 5),
      child: Column(

        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,bottom: 5,top: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                Expanded(flex:2,child: Text(subtitle,style: TextStyle(color:color == true ? Colors.red : Colors.blueGrey,fontSize: 13),maxLines: 2,textAlign: TextAlign.end,)),
              ],
            ),
          ),
          Visibility(visible: divider == true,child: Container(height: 3,width: double.infinity,color: Colors.blueGrey.withOpacity(0.2),),)
        ],
      ),
    );
  }

  Widget buildContent(String title, String subtitle,bool color,bool divider){
    return Padding(
      padding: const EdgeInsets.only(top: 5,bottom: 5,left: 0,right: 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,bottom: 5,top: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(title,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),)),
                Text(subtitle,style: TextStyle(color:color == true ? Colors.red : Colors.blueGrey,fontSize: 13),maxLines: 2,textAlign: TextAlign.end),
              ],
            ),
          ),
          Visibility(visible: divider == true,child: Divider(thickness: 1.2,color: Colors.blueGrey.withOpacity(0.3),),)
        ],
      ),
    );
  }

  Widget buildContentSub(String title, String subtitle,bool color,bool divider){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16,right: 16,bottom: 10,top: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(title,style: const TextStyle(color: Colors.blueGrey),)),
              Text(subtitle,style: TextStyle(color:color == true ? Colors.red : Colors.blueGrey,fontSize: 13),maxLines: 2,textAlign: TextAlign.end),
            ],
          ),
        ),
        Visibility(visible: divider == true,child: Divider(thickness: 1.2,color: Colors.blueGrey.withOpacity(0.3),),)
      ],
    );
  }
}
