import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../themes/colors.dart';
import '../../../utils/const.dart';
import '../../../widgets/custom_appbar.dart';
import 'history_profit_bloc.dart';
import 'history_profit_event.dart';
import 'history_profit_state.dart';


class HistoryProfitScreen extends StatefulWidget {
  const HistoryProfitScreen({Key? key}) : super(key: key);

  @override
  _HistoryProfitScreenState createState() => _HistoryProfitScreenState();
}

class _HistoryProfitScreenState extends State<HistoryProfitScreen>with SingleTickerProviderStateMixin{

  late HistoryProfitBloc _bloc;
  late TabController tabController;
  late  PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = HistoryProfitBloc();
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
    return BlocListener<HistoryProfitBloc,HistoryProfitState>(
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
      child: BlocBuilder<HistoryProfitBloc,HistoryProfitState>(
        bloc: _bloc,
        builder: (BuildContext context,HistoryProfitState state){
          return buildPage(context,state);
        },
      ),
    );
  }


  Widget buildPage(BuildContext context,HistoryProfitState state){
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
              appBar('Lịch sử điểm',context),
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
              GestureDetector(
                onTap: (){
                  _bloc.add(ChangePageViewEvent(0));
                },
                child: Container(
                  height: 35,
                  padding: const EdgeInsets.only(left: 40,right: 40,top: 6,bottom: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: _bloc.valueChange == 0 ? mainColor : Colors.grey
                  ),
                  child: Center(child: Text('Hoa hồng',style: TextStyle(color: _bloc.valueChange == 0 ?  Colors.white : Colors.black),)),
                ),
              ),
              const SizedBox(width: Const.kDefaultPadding,),
              GestureDetector(
                onTap: (){
                  _bloc.add(ChangePageViewEvent(1));
                },
                child: Container(
                  height: 35,
                  padding: const EdgeInsets.only(left: 40,right: 40,top: 6,bottom: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: _bloc.valueChange == 1 ? mainColor : Colors.grey
                  ),
                  child: Center(child: Text('Trả hoa hồng',style: TextStyle(color: _bloc.valueChange == 1 ?  Colors.white : Colors.black),)),
                ),
              ),
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
            tabs: List<Widget>.generate(_bloc.listTabViewHistory.length, (int index) {
              return Tab(
                text: _bloc.listTabViewHistory[index].toString(),
              );
            }),
          ),
        ),
        Container(color: Colors.grey.withOpacity(0.3),width: double.infinity,height: 1,),
        Expanded(
          child: TabBarView(
              controller: tabController,
              children: List<Widget>.generate(_bloc.listTabViewHistory.length, (int index) {
                for (int i = 0; i <= _bloc.listTabViewHistory.length; i++) {
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
    return Padding(
      padding: EdgeInsets.only(bottom: height * .1,top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20,right: 20),
            height: 38,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('1 tháng',style: TextStyle(color: subColor),),
                Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 8),
                  child: Container(height: double.infinity,width: 1,color: Colors.blueGrey,),
                ),
                const Text('6 tháng',style: TextStyle(color: Colors.black),),
                Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 8),
                  child: Container(height: double.infinity,width: 1,color: Colors.blueGrey,),
                ),
                const Text('1 năm',style: TextStyle(color: Colors.black),),
                Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 8),
                  child: Container(height: double.infinity,width: 1,color: Colors.blueGrey,),
                ),
                const Text('Tất cả',style: TextStyle(color: Colors.black),),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 5,
            color: dark_text.withOpacity(0.3),
          ),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: Center(child: Text('Tổng điểm thưởng: 150 đ',style: TextStyle(color: subColor,fontWeight: FontWeight.bold),)),
          ),
          Expanded(
            child: Container(
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('Tên đơn hàng',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black),),
                                  Text('Ngày giới thiệu: 20/08/2021',style: TextStyle(color: Colors.grey,fontSize: 11),),
                                ],
                              ),
                              const SizedBox(height: 5,),
                              // Row(
                              //   children: [
                              //     Icon(Icons.phone,color: Colors.grey,size: 16,),
                              //     SizedBox(width: 5,),
                              //     Text('0963 004 959',style: TextStyle(color: Colors.grey,fontSize: 12),),
                              //   ],
                              // ),
                              const Divider(color: Colors.grey,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Chiến dịch: Giới thiệu tải app nhận thưởng',style: TextStyle(color: mainColor,fontSize: 12),),
                                  Text('Điểm: 60đ',style: TextStyle(color: subColor,fontSize: 12),),
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
            ),
          )
        ],
      ),
    );
  }

}
