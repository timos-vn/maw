import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../themes/colors.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_rate.dart';
import 'detail_ticket_bloc.dart';
import 'detail_ticket_state.dart';


class DetailTicketScreen extends StatefulWidget {
  const DetailTicketScreen({Key? key}) : super(key: key);

  @override
  _DetailTicketScreenState createState() => _DetailTicketScreenState();
}

class _DetailTicketScreenState extends State<DetailTicketScreen>with TickerProviderStateMixin{

  late DetailTicketBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = DetailTicketBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailTicketBloc,DetailTicketState>(
      listener: (context,state){

      },
      bloc: _bloc,
      child: BlocBuilder<DetailTicketBloc,DetailTicketState>(
        bloc: _bloc,
        builder: (BuildContext context,DetailTicketState state){
          return buildPage(context,state);
        },
      ),
    );
  }


  Widget buildPage(BuildContext context,DetailTicketState state){
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: height * .05,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            appBar('Chi tiết Ticket',context),
            Padding(
              padding: const EdgeInsets.only(top: 8.0,bottom: 20),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.blueGrey.withOpacity(0.5),
              ),
            ),
            Expanded(child: buildBody()),
            const Divider(height: 1,),
            Container(
              color: Colors.grey.withOpacity(0.1),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      showDialog(context: context,
                          builder: (BuildContext context){
                            return const CustomRate(
                              title: "Đánh giá của bạn",
                              descriptions: "Xin vui lòng gửi đánh giá về câu trả lời của chúng tôi",
                              text: "Gửi",
                              hintText: 'Góp ý cho chúng tôi tại đây',
                            );
                          }
                      );
                    },
                    child: Card(
                      elevation: 10,
                      shadowColor: Colors.grey.withOpacity(0.4),
                      child: Container(
                        padding:const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                        child: Row(
                          children: [
                            Icon(Icons.star_border,color: mainColor,size: 20,),
                            const SizedBox(width: 10,),
                            Text('Đánh giá',style: TextStyle(color: mainColor),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30,),
                  Card(
                    elevation: 10,
                    color: mainColor,
                    shadowColor: Colors.grey.withOpacity(0.4),
                    child: Container(
                      padding:const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle_outline,color: subColor,size: 20,),
                          const SizedBox(width: 10,),
                          const Text('Xác nhận',style: TextStyle(color: Colors.white),),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody(){
    return Column(
      children: [
        const Text('Sản phẩm',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        const SizedBox(height: 5,),
        const Text('(Dòng máy này hiển thị chủ đề)',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        Padding(
          padding: const EdgeInsets.only(left: 12,right: 12,top: 20,bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Nội dung: ',style: TextStyle(color: Colors.black,fontSize: 13),),
                  Flexible(child: Text('Nên mua loại máy lọc nước nào dùng bền nhất',style: TextStyle(color: Colors.grey,fontSize: 13),maxLines: 2,)),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: const [
                  Text('Người tạo: ',style: TextStyle(color: Colors.black,fontSize: 13),),
                  Text('Hoàng Thu Trang',style: TextStyle(color: Colors.grey,fontSize: 13),),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: const [
                  Text('Nhân viên xử lý: ',style: TextStyle(color: Colors.black,fontSize: 13),),
                  Text('admin',style: TextStyle(color: Colors.grey,fontSize: 13),),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 12,right: 12,top: 12,bottom: 10),
          color: Colors.grey.withOpacity(0.2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Trao đổi",style: TextStyle(fontWeight: FontWeight.bold),),
              Row(
                children: [
                  const Text("Công khai",style: TextStyle(color: Colors.grey),),
                  const SizedBox(width: 5,),//Earth
                  Icon(MdiIcons.earth,color: mainColor,size: 20,)
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 20,),
        Expanded(
          child: ListView.separated(
          padding: const EdgeInsets.only(top: 5,left: 0,right: 0,bottom: 0),
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (context,index) =>
              Container(
                padding: const EdgeInsets.only(bottom: 6),
                child: GestureDetector(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(top: 5,right: 16,left: 16,bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(MdiIcons.accountCircle,color: Colors.grey,size: 30,),
                            SizedBox(width: 6,),
                            Text('Admin',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black),),
                          ],
                        ),
                        const SizedBox(height: 6,),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('[San pham] Đến với Enterbuy bạn không phải lo lắng đến chất lượng. Chúng tôi có các sản phẩm ưu việt như .....',style: TextStyle(fontSize: 13,color: Colors.black),),
                            const SizedBox(height: 7,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('07/04/2022 16:48',style: TextStyle(color: Colors.grey,fontSize: 12),),
                                Row(
                                  children: [
                                    const Icon(Icons.thumb_up_alt_outlined,size: 12,color: Colors.grey,),
                                    const SizedBox(width: 4,),
                                    Text('1',style: TextStyle(color: subColor,fontSize: 12),),
                                    const SizedBox(width: 16,),
                                    const Icon(Icons.thumb_down_alt_outlined,size: 12,color: Colors.grey,),
                                    const SizedBox(width: 4,),
                                    Text('1',style: TextStyle(color: subColor,fontSize: 12),),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
          , separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },),
        ),
      ],
    );
  }
}
