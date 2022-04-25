import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:maw/screen/voucher/voucher_bloc.dart';
import 'package:maw/screen/voucher/voucher_state.dart';

import '../../themes/colors.dart';
import '../../utils/const.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import 'voucher_event.dart';

class VoucherScreen extends StatefulWidget {
  const VoucherScreen({Key? key}) : super(key: key);

  @override
  _VoucherScreenState createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen>with SingleTickerProviderStateMixin{

  late VoucherBloc _bloc;
  late TabController tabController;
  late  PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = VoucherBloc();
    tabController = TabController(length: 3, vsync: this);
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VoucherBloc,VoucherState>(
      listener: (context,state){
        if(state is ChangePageViewSuccess){
          if(state.valueChange == 0){
            _pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.ease);
          }else{
            _pageController.animateToPage(1, duration: const Duration(milliseconds: 500), curve: Curves.ease);
          }
        }
      },
      bloc: _bloc,
      child: BlocBuilder<VoucherBloc,VoucherState>(
        bloc: _bloc,
        builder: (BuildContext context,VoucherState state){
          return buildPage(context,state);
        },
      ),
    );
  }


  Widget buildPage(BuildContext context,VoucherState state){
    final height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.only(top: height * .05,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              appBar('Ví Voucher',context),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.blueGrey.withOpacity(0.5),
                ),
              ),
              Expanded(child: buildPageController(height)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPageController (double height){
    return Center(
      child: Column(
        children: <Widget>[
          const SizedBox(height: Const.kDefaultPadding + 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CheckedContainer(paddingV: 25,content: 'Voucher',checked: _bloc.checkingStore == 0,onTap: ()=> _bloc.add(ChangePageViewEvent(0)),checkedColor: subColor,),
              const SizedBox(width: Const.kDefaultPadding,),
              CheckedContainer(paddingV: 15,content: 'Mã giới thiệu',checked: _bloc.checkingStore == 1,onTap: ()=> _bloc.add(ChangePageViewEvent(1)),checkedColor: subColor,),
            ],
          ),
          const SizedBox(height: Const.kDefaultPadding*0.5,),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                buildBody(height),
                buildBody(height),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBody(double height){
    return Column(
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
            tabs: List<Widget>.generate(_bloc.listTabVoucher.length, (int index) {
              return Tab(
                text: _bloc.listTabVoucher[index].toString(),
              );
            }),
          ),
        ),
        Container(color: Colors.grey.withOpacity(0.3),width: double.infinity,height: 1,),
        Expanded(
          child: TabBarView(
              controller: tabController,
              children: List<Widget>.generate(_bloc.listTabVoucher.length, (int index) {
                for (int i = 0; i <= _bloc.listTabVoucher.length; i++) {
                  if (i == index) {
                    return buildBodyContent(context, index,height);
                  }
                }
                return const Text('');
              })),
        ),
      ],
    );
  }

  Widget buildBodyContent(BuildContext context, int i,double height){
    return Container(
      color: dark_text.withOpacity(0.3),
      child: ListView.separated(
        padding: EdgeInsets.only(top: 5,left: 0,right: 0,bottom: height * .1,),
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (context,index) =>
            Container(
              padding: const EdgeInsets.only(bottom: 6),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(top: 10,right: 16,left: 16,bottom: 10),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6), // Image border
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(30), // Image radius
                        child: CachedNetworkImage(
                          imageUrl: 'https://i.pinimg.com/564x/5e/93/14/5e9314a0f83f3f48e5d5fde1a77d3519.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Tên đơn hàng',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black),),
                        const SizedBox(height: 5,),
                        Row(
                          children: [
                            const Icon(MdiIcons.tag,color: Colors.blueGrey,size: 12,),
                            const SizedBox(width: 5,),
                            Text('Đại lý Enterbuy',style: TextStyle(color: subColor,fontSize: 11),),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        const Text('Áp dụng cho cái gì',style: TextStyle(fontSize: 11,color: Colors.blueGrey),),
                      ],
                    ),
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
