import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maw/screen/shop/search_product/search_product_bloc.dart';
import 'package:maw/screen/shop/search_product/search_product_state.dart';

import '../../../themes/colors.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({Key? key}) : super(key: key);

  @override
  _SearchProductScreenState createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen>{

  late SearchProductBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = SearchProductBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchProductBloc,SearchProductState>(
      listener: (context,state){

      },
      bloc: _bloc,
      child: BlocBuilder<SearchProductBloc,SearchProductState>(
        bloc: _bloc,
        builder: (BuildContext context,SearchProductState state){
          return buildPage(context,state);
        },
      ),
    );
  }

  Widget buildPage(BuildContext context,SearchProductState state){
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
              padding: const EdgeInsets.only(left: 10,right: 10,bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: ()=> Navigator.pop(context),
                    child: const SizedBox(
                        height:20,
                        width: 50,
                        child: Icon(Icons.arrow_back_ios,color: Colors.black,size: 20,)),
                  ),
                  const Text('Tìm kiếm sản phẩm',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Stack(
                          overflow: Overflow.visible,
                          children: [
                            Icon(Icons.shopping_cart_rounded,color: mainColor,),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 0),
                        child: Icon(Icons.help,color: mainColor,),
                      ),
                    ],
                  )
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
    return Column(
      children: [
        Container(height: 1,width: double.infinity,color: Colors.blueGrey.withOpacity(0.5),),
      ],
    );
  }
}
