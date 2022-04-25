import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../themes/colors.dart';
import '../home/detail_device/test.dart';
import 'order_bloc.dart';
import 'order_state.dart';

class OrderScreen extends StatefulWidget {
  final int? indexTab;
  const OrderScreen({Key? key,this.indexTab}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> with SingleTickerProviderStateMixin{

  late TabController tabController;
  late OrderBloc _bloc;
  TextEditingController nameController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();

  TextEditingController phoneController = TextEditingController();
  FocusNode phoneFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();

  List<String> choices = <String>[
    "Ngày hôm nay",
    "Tuần này",
    "Tháng này",
    "Năm này",
    "Nhập thời gian"
  ];

  void _select(String choice) {
    if(choice == 'Lịch sử báo cáo'){
      //String dataType = "1";
      // dataType = '1';
      // _bloc.add(GetListOrderEvent(_dateForm.toString(),_dateTo.toString(),dataType));
    }else if(choice == 'Đặt lại thiết bị'){
      // dataType = '2';
      // _bloc.add(GetListOrderEvent(_dateForm.toString(),_dateTo.toString(),dataType));
    }else{

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = OrderBloc();
    tabController = TabController(length: 4, vsync: this);
    if(widget.indexTab == 1){
      Future.delayed(const Duration(milliseconds: 200)).then((value)=>tabController.animateTo((tabController.index + 1) % 10));
    }else if(widget.indexTab == 2){
      Future.delayed(const Duration(milliseconds: 200)).then((value)=>tabController.animateTo((tabController.index + 2) % 10));
    }else if(widget.indexTab == 3){
      Future.delayed(const Duration(milliseconds: 200)).then((value)=>tabController.animateTo((tabController.index + 3) % 10));
    }
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<OrderBloc,OrderState>(
        bloc: _bloc,
        listener: (context,state){

        },
        child: BlocBuilder(
          bloc: _bloc,
          builder: (BuildContext context, OrderState state){
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16,right: 10,bottom: 10,top: height * .05,),
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
                              Expanded(child: Text('Lịch sử đơn hàng',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: SizedBox(
                          width: 25,
                          child: PopupMenuButton(
                            icon: Icon(MdiIcons.filterOutline,color: mainColor,),
                            onSelected: _select,
                            shape: const TooltipShape(),
                            padding: EdgeInsets.zero,
                            offset: const Offset(5, 45),
                            itemBuilder: (BuildContext context) {
                              return choices.map((String choice) {
                                return  PopupMenuItem<String>(
                                  height: 10,
                                  padding: const EdgeInsets.only(left: 10,top: 5,right: 10),
                                  value: choice,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(choice,style: const TextStyle(fontSize: 12),),
                                      const Divider()
                                    ],
                                  ),
                                );}
                              ).toList();
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: buildBody()
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildBody(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(),
        Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: SizedBox(
                    height: 35,
                      child: TabBar(
                        controller: tabController,
                        unselectedLabelColor: Colors.black.withOpacity(0.7),
                        labelColor: mainColor,
                        labelStyle: const TextStyle(fontWeight: FontWeight.w400,fontSize: 12),
                        isScrollable: true,
                        indicatorPadding: EdgeInsets.zero,
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
                            text: _bloc.listTabViewProfile[index].toString(),
                          );
                        }),
                      )
                  ),
                ),
                Expanded(
                  child: TabBarView(
                      controller: tabController,
                      children: List<Widget>.generate(_bloc.listTabViewProfile.length, (int index) {
                        return buildBodyContent();
                      })),
                ),
              ],
            )
        )
      ],
    );
  }

  Widget buildBodyContent(){
    return Container(
      color: dark_text.withOpacity(0.3),
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 5,left: 0,right: 0,bottom: 0),
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (context,index) =>
            Container(
              padding: const EdgeInsets.only(bottom: 6),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(top: 15,right: 16,left: 16,bottom: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Tiêu đề',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10), // Image border
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(25), // Image radius
                                child: CachedNetworkImage(
                                  imageUrl: 'https://i.pinimg.com/564x/5e/93/14/5e9314a0f83f3f48e5d5fde1a77d3519.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5,),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text('Tên vật tư',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black),),
                                  const SizedBox(height: 3,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text('Ngày giới thiệu: 20/08/2021',style: TextStyle(color: Colors.grey,fontSize: 11),),
                                      SizedBox(width: 5,),
                                      Text('x1',style: TextStyle(color: Colors.grey,fontSize: 12),),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const [
                                      Text('180.000đ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black),),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    const Divider(color: Colors.grey,),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(MdiIcons.cash,color: mainColor,),
                        const SizedBox(width: 5,),
                        const Text('Thành tiền: ',style: TextStyle(fontSize: 11,color: Colors.black),),
                        Text('180.000đ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: subColor),),
                      ],
                    ),
                    const Divider(color: Colors.grey,),
                    Row(
                      children: [
                        Icon(MdiIcons.carSide,color: mainColor,),
                        const SizedBox(width: 5,),
                        Text('Giao hàng và lắp đặt thành công',style: TextStyle(color: mainColor,fontSize: 12),),
                      ],
                    ),
                    const Divider(color: Colors.grey,),
                    const SizedBox(height: 3,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Chưa nhận được đánh giá',style: TextStyle(fontSize: 11,color: Colors.grey),),
                        Container(
                          padding: const EdgeInsets.only(top: 6,bottom: 6,right: 16,left: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: mainColor
                          ),
                          child: const Text('Đánh giá',style: TextStyle(fontSize: 11,color: Colors.white),),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
        , separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          width: double.infinity,
          height: 2,
          // color: dark_text.withOpacity(0.3),
        );
      },),
    );
  }

}
