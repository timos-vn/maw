import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../themes/colors.dart';
import 'banking_bloc.dart';
import 'banking_state.dart';

class BankingScreen extends StatefulWidget {
  const BankingScreen({Key? key}) : super(key: key);

  @override
  _BankingScreenState createState() => _BankingScreenState();
}

class _BankingScreenState extends State<BankingScreen>{

  late BankingBloc _bloc;
  final findBankingController = TextEditingController();
  final findBankingFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = BankingBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BankingBloc,BankingState>(
      listener: (context,state){

      },
      bloc: _bloc,
      child: BlocBuilder<BankingBloc,BankingState>(
        bloc: _bloc,
        builder: (BuildContext context,BankingState state){
          return buildPage(context,state);
        },
      ),
    );
  }


  Widget buildPage(BuildContext context,BankingState state){
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
              child: InkWell(
                onTap: ()=> Navigator.pop(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const[
                    SizedBox(
                        height:20,
                        width: 30,
                        child: Icon(Icons.arrow_back_ios,color: Colors.black,size: 20,)),
                    Text('Danh Sách Ngân Hàng',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,),
                    SizedBox(
                        height:20,
                        width: 30,
                        child: Icon(Icons.event,color: Colors.white,size: 20,)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.blueGrey.withOpacity(0.5),
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
      padding: EdgeInsets.only(bottom: height * .1,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         Container(
           padding: const EdgeInsets.only(left: 8,right: 8),
           height: 50,
           color: Colors.grey.withOpacity(0.1),
           child: Row(
             children: [
               const Icon(Icons.search_outlined,color: Colors.grey,size: 20,),
               Padding(
                 padding: const EdgeInsets.only(top: 15,bottom: 15,left: 10,right: 8),
                 child: Container(height: double.infinity,width: 1,color: Colors.blueGrey,),
               ),
               Expanded(
                 child: TextField(
                   controller: findBankingController,
                   focusNode: findBankingFocus,
                     style: const TextStyle(
                       fontSize: 13,
                       color: Colors.black,),
                   decoration: const InputDecoration(
                     border: InputBorder.none,
                     contentPadding: EdgeInsets.only(top: 10,bottom: 10,left: 10),
                     isDense: true,
                     focusColor: primaryColor,
                     hintText: 'Tìm kiếm ngân hàng',
                     hintStyle: TextStyle(
                       fontSize: 13,
                       color: grey,
                     ),
                   ),
                   onChanged: (text){

                   },
                 ),
               )
             ],
           ),
         ),
          Expanded(
            child: ListView.separated(
                padding: const EdgeInsets.only(top: 16,left: 16,right: 16,bottom: 0),
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context,index) =>
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.only(right: 16,left: 16),
                      child: Text('Ngan hang tmcp ngoai thuong viet nam (vietcombank)'.toUpperCase(),style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 13,color: Colors.black),),
                    )
            , separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
            },),
          ),
        ],
      ),
    );
  }
}
