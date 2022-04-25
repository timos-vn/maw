import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:maw/screen/ticket/personal/personal_bloc.dart';
import 'package:maw/screen/ticket/personal/personal_state.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../themes/colors.dart';
import '../detail_ticket/detail_ticket_screen.dart';


class PersonalScreen extends StatefulWidget {
  const PersonalScreen({Key? key}) : super(key: key);

  @override
  _PersonalScreenState createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen>with TickerProviderStateMixin{

  late PersonalBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = PersonalBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonalBloc,PersonalState>(
      listener: (context,state){

      },
      bloc: _bloc,
      child: BlocBuilder<PersonalBloc,PersonalState>(
        bloc: _bloc,
        builder: (BuildContext context,PersonalState state){
          return buildPage(context,state);
        },
      ),
    );
  }


  Widget buildPage(BuildContext context,PersonalState state){
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.separated(
        padding: const EdgeInsets.only(top: 5,left: 0,right: 0,bottom: 0),
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (context,index) =>
            Container(
              padding: const EdgeInsets.only(bottom: 6),
              child: GestureDetector(
                onTap: ()=> pushNewScreen(context, screen: const DetailTicketScreen()),
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
        return const Divider();
      },),
    );
  }
}
