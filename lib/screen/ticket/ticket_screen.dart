import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:maw/screen/ticket/people/people_screen.dart';
import 'package:maw/screen/ticket/personal/personal_screen.dart';
import 'package:maw/screen/ticket/ticket_bloc.dart';
import 'package:maw/screen/ticket/ticket_state.dart';

import '../../themes/colors.dart';


class TicketScreen extends StatefulWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen>with TickerProviderStateMixin{

  late TicketBloc _bloc;
  late TabController tabController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = TicketBloc();
    tabController = TabController(vsync:this,length:2);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TicketBloc,TicketState>(
      listener: (context,state){

      },
      bloc: _bloc,
      child: BlocBuilder<TicketBloc,TicketState>(
        bloc: _bloc,
        builder: (BuildContext context,TicketState state){
          return buildPage(context,state);
        },
      ),
    );
  }


  Widget buildPage(BuildContext context,TicketState state){
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: height * .05,),
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
                          Expanded(child: Text('Ticket',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,)),
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
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 16),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(border: Border.all(width: 0.1, color: white), borderRadius: const BorderRadius.all(Radius.circular(26)), color: Colors.blueGrey.withOpacity(0.1),),
                child: Container(
                  height: 40,
                    decoration: BoxDecoration(border: Border.all(width: 0.1, color: white), borderRadius: const BorderRadius.all(Radius.circular(26)), color: Colors.blueGrey.withOpacity(0.1)),
                    child: TabBar(
                      controller: tabController,
                      unselectedLabelColor: Colors.black,
                      labelColor: Colors.white,
                      labelStyle: const TextStyle(fontWeight: FontWeight.w600,fontSize: 13),
                      isScrollable: false,
                      indicatorPadding: const EdgeInsets.all(0),
                      indicatorColor: Colors.orange,
                      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600,fontSize: 13),
                      indicator: BoxDecoration(color: mainColor, borderRadius: const BorderRadius.all(Radius.circular(26))),

                      tabs: List<Widget>.generate(_bloc.listTabViewTicket.length, (int index) {
                        return Tab(
                          text: _bloc.listTabViewTicket[index].toString(),
                        );
                      }),
                    )
                ),
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
      padding: EdgeInsets.only(bottom: height * .1,top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(height: 1,color: Colors.grey.withOpacity(0.5),),
          Expanded(
            child: Container(
              color: dark_text.withOpacity(0.3),
              child: TabBarView(
                  controller: tabController,
                  children: List<Widget>.generate(_bloc.listTabViewTicket.length, (int index) {
                    for (int i = 0; i <=_bloc.listTabViewTicket.length; i++) {
                      if (index == 0) {
                        return const PersonalScreen();
                      }else if(index == 1){
                        return const PeopleScreen();
                      }
                    }
                    return const Text('');
                  })),
            ),
          )
        ],
      ),
    );
  }

}
