import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:maw/screen/ticket/people/people_bloc.dart';
import 'package:maw/screen/ticket/people/people_state.dart';


class PeopleScreen extends StatefulWidget {
  const PeopleScreen({Key? key}) : super(key: key);

  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen>with TickerProviderStateMixin{

  late PeopleBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = PeopleBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PeopleBloc,PeopleState>(
      listener: (context,state){

      },
      bloc: _bloc,
      child: BlocBuilder<PeopleBloc,PeopleState>(
        bloc: _bloc,
        builder: (BuildContext context,PeopleState state){
          return buildPage(context,state);
        },
      ),
    );
  }


  Widget buildPage(BuildContext context,PeopleState state){
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: height * .05,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [

          ],
        ),
      ),
    );
  }
}
