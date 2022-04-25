import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../themes/colors.dart';
import '../component/create_question.dart';
import '../component/detail_post.dart';
import '../component/detail_ticket_ex.dart';
import 'expert_lib_bloc.dart';
import 'expert_lib_event.dart';
import 'expert_lib_state.dart';

class ExpertLibScreen extends StatefulWidget {
  const ExpertLibScreen({Key? key}) : super(key: key);

  @override
  _ExpertLibScreenState createState() => _ExpertLibScreenState();
}

class _ExpertLibScreenState extends State<ExpertLibScreen> with TickerProviderStateMixin{

  late ExpertLibBloc _bloc;
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final usernameFocus = FocusNode();
  final phoneFocus = FocusNode();
  final addressFocus = FocusNode();
  final emailController = TextEditingController();
  final emailFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = ExpertLibBloc();
    _bloc.add(GetPrefs());

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
      floatingActionButton: GestureDetector(
        onTap: ()=> pushNewScreen(context, screen: const CreateQuestionScreen()),
        child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: subColor
            ),
            child: const Icon(Icons.add,color: Colors.white,)),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: height * .05,bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitle(height),
            Container(height: 2,width: double.infinity,color: Colors.blueGrey.withOpacity(0.1),),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: height * .02,left: 16,right: 16),
                  child: const Text(
                    'Bài viết chuyên gia',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15,color: Colors.black),
                  ),
                ),
                ListView.separated(
                  padding: const EdgeInsets.only(top: 15,left: 0,right: 0,bottom: 0),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context,index) =>
                      Container(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: GestureDetector(
                          onTap: ()=> pushNewScreen(context, screen: const DetailPostScreen(showComment: true,)),
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.only(top: 15,right: 16,left: 16,bottom: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10), // Image border
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(30), // Image radius
                                    child: CachedNetworkImage(
                                      imageUrl: 'https://i.pinimg.com/564x/5e/93/14/5e9314a0f83f3f48e5d5fde1a77d3519.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6,),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('[San pham] Nen mua may loc nuoc hang nao',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black),),
                                    const SizedBox(height: 7,),
                                    const Text('07/04/2022 16:48',style: TextStyle(color: Colors.grey,fontSize: 12),),
                                    const SizedBox(height: 5,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(MdiIcons.wechat,size: 16,color: Colors.grey,),
                                        const SizedBox(width: 4,),
                                        Text('1',style: TextStyle(color: mainColor,fontSize: 12),),
                                        const SizedBox(width: 16,),
                                        const Icon(Icons.thumb_up_alt_outlined,size: 12,color: Colors.grey,),
                                        const SizedBox(width: 4,),
                                        Text('1',style: TextStyle(color: subColor,fontSize: 12),),
                                        const SizedBox(width: 16,),
                                        const Icon(Icons.thumb_down_alt_outlined,size: 12,color: Colors.grey,),
                                        const SizedBox(width: 4,),
                                        Text('1',style: TextStyle(color: subColor,fontSize: 12),),
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
                  return const Divider(height: 4,);
                },),
                Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16,bottom: 6),
                  child: Center(
                    child: Text(
                      'Xem thêm',
                      style: TextStyle( fontSize: 13,color: mainColor),
                    ),
                  ),
                ),
                Container(height: 6,width: double.infinity,color: Colors.blueGrey.withOpacity(0.1),),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: height * .02,left: 16,right: 16),
              child: const Text(
                'Ticket',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15,color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 16,left: 16,right: 16),
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
                        Text('Năm nay',style: TextStyle(color: Colors.black,fontSize: 10),),
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
                        Text('Tất cả',style: TextStyle(color: Colors.black,fontSize: 10),),
                        SizedBox(width: 6,),
                        Icon(Icons.arrow_drop_down_outlined,color: Colors.blueGrey,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(height: 6,width: double.infinity,color: Colors.blueGrey.withOpacity(0.1),),
            ListView.separated(
              padding: const EdgeInsets.only(top: 5,left: 0,right: 0,bottom: 0),
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context,index) =>
                  Container(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: GestureDetector(
                      onTap: ()=> pushNewScreen(context, screen: const DetailTicketExScreen()),
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(top: 15,right: 16,left: 16,bottom: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(MdiIcons.accountCircle,color: Colors.grey,size: 30,),
                            const SizedBox(width: 6,),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('[San pham] Nen mua may loc nuoc hang nao',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black),),
                                const SizedBox(height: 7,),
                                const Text('07/04/2022 16:48',style: TextStyle(color: Colors.grey,fontSize: 12),),
                                const SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(Icons.chat,size: 12,color: Colors.grey,),
                                    const SizedBox(width: 4,),
                                    Text('1',style: TextStyle(color: mainColor,fontSize: 12),),
                                    const SizedBox(width: 16,),
                                    const Icon(Icons.thumb_up_alt_outlined,size: 12,color: Colors.grey,),
                                    const SizedBox(width: 4,),
                                    Text('1',style: TextStyle(color: subColor,fontSize: 12),),
                                    const SizedBox(width: 16,),
                                    const Icon(Icons.thumb_down_alt_outlined,size: 12,color: Colors.grey,),
                                    const SizedBox(width: 4,),
                                    Text('1',style: TextStyle(color: subColor,fontSize: 12),),
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
              return const Divider(height: 1,);
            },)
          ],
        ),
      ),
    );
  }

  Widget buildTitle(double height){
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: ()=> Navigator.pop(context),
              child: Row(
                children: const [
                  SizedBox(
                      height:20,
                      width: 50,
                      child: Icon(Icons.arrow_back_ios,color: Colors.black,size: 20,)),
                  Expanded(child: Text('Thư viện chuyên gia',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,)),
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
            padding: const EdgeInsets.only(left: 20,right: 12),
            child: Stack(
              overflow: Overflow.visible,
              children: [
                Icon(Icons.notifications,color: mainColor,),
                Positioned(
                    top: -5,
                    right: -MediaQuery.of(context).size.width * .01,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(44)),
                        color: Colors.red,
                      ),
                      height: 10,width: 10,
                    )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
