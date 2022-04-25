import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../themes/colors.dart';
import '../../../widgets/custom_appbar.dart';
import '../expert_lib/expert_lib_bloc.dart';
import '../expert_lib/expert_lib_state.dart';


class DetailTicketExScreen extends StatefulWidget {
  const DetailTicketExScreen({Key? key}) : super(key: key);

  @override
  _DetailTicketExScreenState createState() => _DetailTicketExScreenState();
}

class _DetailTicketExScreenState extends State<DetailTicketExScreen>with TickerProviderStateMixin{

  late ExpertLibBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = ExpertLibBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpertLibBloc,ExpertLibState>(
      listener: (context,state){

      },
      bloc: _bloc,
      child: BlocBuilder<ExpertLibBloc,ExpertLibState>(
        bloc: _bloc,
        builder: (BuildContext context,ExpertLibState state){
          return buildPage(context,state);
        },
      ),
    );
  }


  Widget buildPage(BuildContext context,ExpertLibState state){
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
            const Divider(thickness: 1,height: 1,),
            _inputContent()
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
        Container(
          padding: const EdgeInsets.only(top: 5,right: 16,left: 16,bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Image border
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(16), // Image radius
                      child: Image.asset('assets/images/icon.png'),
                    ),
                  ),
                  const SizedBox(width: 6,),
                  const Text('Admin',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black),),
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
        const SizedBox(height: 10,),
        const Divider(thickness: 2,),
        const SizedBox(height: 10,),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 5,),
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
                              Text('Tranggg',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black),),
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

  Widget _inputContent() {
    return InkWell(
      onTap: () {

      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
        child: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Row(
            children: [
              const Icon(MdiIcons.accountCircle,color: Colors.grey,),
              const SizedBox(width: 10,),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.0),
                          borderSide: const BorderSide(color: Colors.transparent, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: grey, width: 1),
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: grey, width: 1),
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        filled: true,
                        suffixIcon: const Icon(Icons.camera_enhance,color: Colors.grey,),
                        contentPadding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5),fontSize: 12),
                        hintText: "Viết bình luận",
                        fillColor: Colors.white70),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
