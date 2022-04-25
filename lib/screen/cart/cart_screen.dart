import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../themes/colors.dart';
import 'cart_bloc.dart';
import 'cart_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  late CartBloc  _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = CartBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: BlocListener<CartBloc,CartState>(
        bloc: _bloc,
        listener: (context, state) {

        },
        child: BlocBuilder<CartBloc,CartState>(
          bloc: _bloc,
          builder: (BuildContext context, CartState state){
            return buildBody(state);
          },
        ),
      ),
    );
  }

  Widget buildBody(CartState state){
    return Column(
      children: [
        Container(
          height: 100,

        ),
        Expanded(
            child: Container(
              color: Colors.white,
            )),
      ],
    );
  }
}
