import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../themes/colors.dart';
import 'notification_bloc.dart';
import 'notification_state.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>{

  late NotificationBloc _bloc;
  late TabController tabController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = NotificationBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc,NotificationState>(
      listener: (context,state){

      },
      bloc: _bloc,
      child: BlocBuilder<NotificationBloc,NotificationState>(
        bloc: _bloc,
        builder: (BuildContext context,NotificationState state){
          return buildPage(context,state);
        },
      ),
    );
  }

  Widget buildPage(BuildContext context,NotificationState state){
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
                          SizedBox(width: 15,),
                          Expanded(child: Text('Thông báo',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                        ],
                      ),
                    ),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Mới'.toUpperCase(),style: const TextStyle(color: Colors.blueGrey,fontSize: 11),),
                Text('Đánh dấu đã đọc',style: TextStyle(color: mainColor,fontSize: 12),),
              ],
            ),
          ),
          const SizedBox(height: 8,),
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
          color: subColor.withOpacity(0.2),
          padding: const EdgeInsets.only(left: 16,right: 16,top: 18,bottom: 18),
          width: double.infinity,
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
              const SizedBox(width: 12,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Báo động thay lõi',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 5,),
                  const Text('Click để xem chi tiết các lõi đến hạn cần thay',style: TextStyle(color: Colors.blueGrey,fontSize: 11),),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Text('Xem ngay',style: TextStyle(color: subColor,fontSize: 11),),
                      Icon(Icons.navigate_next,color: subColor,size: 20,),
                    ],
                  ),
                ],
              )
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
          Visibility(visible: divider == true,child: const Divider())
        ],
      ),
    );
  }
}
