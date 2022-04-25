import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../themes/colors.dart';
import 'history_report_bloc.dart';
import 'history_report_state.dart';


class HistoryReportScreen extends StatefulWidget {
  const HistoryReportScreen({Key? key}) : super(key: key);

  @override
  _HistoryReportScreenState createState() => _HistoryReportScreenState();
}

class _HistoryReportScreenState extends State<HistoryReportScreen>{

  late HistoryReportBloc _bloc;
  late TabController tabController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = HistoryReportBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HistoryReportBloc,HistoryReportState>(
      listener: (context,state){

      },
      bloc: _bloc,
      child: BlocBuilder<HistoryReportBloc,HistoryReportState>(
        bloc: _bloc,
        builder: (BuildContext context,HistoryReportState state){
          return buildPage(context,state);
        },
      ),
    );
  }


  Widget buildPage(BuildContext context,HistoryReportState state){
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
                          Expanded(child: Text('Lịch sử báo cáo',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,)),
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
            padding: const EdgeInsets.only(left: 8,bottom: 8),
            child: Row(
              children: const [
                Text('Năm nay',style: TextStyle(color: Colors.black,fontSize: 12),),
                SizedBox(width: 6,),
                Icon(Icons.arrow_drop_down_outlined,color: Colors.blueGrey,),
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
                            return Padding(
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
                                        const Text('Chi tiết phiếu',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800),),
                                        InkWell(
                                            onTap: ()=> Navigator.pop(context),
                                            child: const Icon(Icons.close,color: Colors.black,)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8,),
                                  const Divider(color: Colors.blueGrey,),
                                  const SizedBox(height: 8,),
                                  buildContent('Họ tên','Hoàng Thu Trang',false,true),
                                  buildContent('Số điện thoại','0963004959',false,true),
                                  buildContent('Email','Trang@sse.net.vn',false,true),
                                  buildContent('Báo cáo sự cố','Máy không hoạt động',false,true),
                                  buildContent('Bộ phận tiếp nhận','BP Kỹ thuật',false,true),
                                  buildContent('Ngày gửi báo cáo','19/03/2022',false,true),
                                  buildContent('Trạng thái','Đang xử lý',true,false),
                                  const SizedBox(height: 15,),
                                  SizedBox(
                                    height: 250,
                                    width: double.infinity,
                                    child: CachedNetworkImage(
                                      imageUrl: 'https://i.pinimg.com/564x/5e/93/14/5e9314a0f83f3f48e5d5fde1a77d3519.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            );
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

  Widget buildItem(int index){
    return Padding(
      padding: const EdgeInsets.only(bottom: 6,top: 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 16,bottom: 16),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('19/03/2022',style: TextStyle(color: Colors.blueGrey,fontSize: 13),),
              const Text('Máy không hoạt động',style: TextStyle(color: Colors.black,fontSize: 13),),
              Icon(Icons.check_circle_rounded,color: mainColor,),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContent(String title, String subtitle,bool color,bool divider){
    return Padding(
      padding: const EdgeInsets.only(top: 5,bottom: 5,left: 20,right: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
              Text(subtitle,style: TextStyle(color:color == true ? Colors.red : Colors.blueGrey),),
            ],
          ),
          Visibility(visible: divider == true,child:const  Divider())
        ],
      ),
    );
  }
}
