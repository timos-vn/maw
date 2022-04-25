import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:maw/screen/connect_device/connect_wifi/component/task_route_page.dart';

import '../../../themes/colors.dart';
import 'connect_wifi_bloc.dart';
import 'connect_wifi_state.dart';
import 'connect_wifi_event.dart';

class ConnectWifiScreen extends StatefulWidget {
  final String? ssId;
  final String? bssId;
  
  const ConnectWifiScreen({Key? key,this.ssId,this.bssId}) : super(key: key);

  @override
  _ConnectWifiScreenState createState() => _ConnectWifiScreenState();
}

class _ConnectWifiScreenState extends State<ConnectWifiScreen> {
  final passwordController = TextEditingController();
  final passwordFocus = FocusNode();
  final deviceController = TextEditingController();
  final deviceFocus = FocusNode();
  late ConnectWifiBloc _bloc;
  bool _obscureText = true;
  bool isBroad = true;
  bool connected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = ConnectWifiBloc();
    _bloc.add(GetPrefs());
    deviceController.text = '1';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectWifiBloc,ConnectWifiState>(
      listener: (context,state){

      },
      bloc: _bloc,
      child: BlocBuilder<ConnectWifiBloc,ConnectWifiState>(
        bloc: _bloc,
        builder: (BuildContext context,ConnectWifiState state){
          return buildPage(context,state);
        },
      ),
    );
  }

  Widget buildPage(BuildContext context,ConnectWifiState state){
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildBody(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget buildBody(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 18,right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('SSID:',style: TextStyle(color: Colors.black,),),
              const SizedBox(width: 5,),
              Text(widget.ssId??'',style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              const Text('BSSID:',style: TextStyle(color: Colors.black,),),
              const SizedBox(width: 5,),
              Text(widget.bssId??'',style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              const Text('PassWord:',style: TextStyle(color: Colors.black,),textAlign: TextAlign.center,),
              const SizedBox(width: 10,),
              Expanded(
                child: TextField(
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  style:const TextStyle(
                    fontSize: 13
                  ),
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(13)),
                      borderSide: BorderSide(
                        color: Colors.grey,width: 1),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      borderSide: BorderSide(width: 1,color: Colors.grey),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      borderSide: BorderSide(
                        color: Colors.grey,),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      borderSide: BorderSide(
                        color: Colors.grey, ),
                    ),
                      contentPadding: const EdgeInsets.only(left: 12,right: 12,top: 20),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText ? MdiIcons.eye : MdiIcons.eyeOff,
                          semanticLabel:
                          _obscureText ? 'show password' : 'hide password',
                          color: blue,
                        ),
                      ),
                      isDense: true,
                      focusColor: mainColor,
                      hintText: 'Mật khẩu wifi của bạn',

                      hintStyle: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                      labelStyle: const TextStyle(color: grey, fontSize: 13),
                      errorStyle: const TextStyle(
                        fontSize: 10,
                        color: Colors.red,
                      )),
                  focusNode: passwordFocus,
                  onSubmitted: (_){},
                  inputFormatters: const [],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              const Text('Device count:',style: TextStyle(color: Colors.black,),textAlign: TextAlign.center,),
              const SizedBox(width: 10,),
              SizedBox(
                width: 120,
                child: TextField(
                  controller: deviceController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  style:const TextStyle(
                      fontSize: 13
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                            color: Colors.grey,width: 1),
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(width: 1,color: Colors.grey),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                          color: Colors.grey,),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                          color: Colors.grey, ),
                      ),
                      contentPadding: const EdgeInsets.only(left: 12,right: 12,top: 20,bottom: 0),
                      isDense: true,
                      focusColor: mainColor,

                      hintStyle: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                      labelStyle: const TextStyle(color: grey, fontSize: 13),
                      errorStyle: const TextStyle(
                        fontSize: 10,
                        color: Colors.red,
                      )),
                  focusNode: deviceFocus,
                  onSubmitted: (_){},
                  inputFormatters: const [],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              Radio<bool>(
                  groupValue: isBroad,
                  value: true,
                  activeColor: Colors.red,
                  onChanged: (bool? value) {
                    setState(() {
                      isBroad = value!;
                    });
                  }),
              const Text("BroadCast"),
              const SizedBox(width: 6),
              Radio<bool>(
                  groupValue: isBroad,
                  value: false,
                  activeColor: Colors.red,
                  onChanged: (bool? value) {
                    setState(() {
                      isBroad = value!;
                    });
                  }),
              const Text("MultiCast"),
            ],
          ),
          const SizedBox(height: 40,),
          Visibility(
            visible: connected == false,
            child: GestureDetector(
              onTap: ()async{
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => TaskRoute(
                            widget.ssId.toString(),
                            widget.bssId.toString(),
                            passwordController.text,
                            deviceController.text,
                            isBroad))).then((value){
                              if(value != null){
                                if(value[0] == 'Connected'){
                                  setState(() {
                                    connected = true;
                                  });
                                }
                              }
                });
              },
              child: Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(24),color: mainColor),
                child: Center(child: Text('Kết nối thiết bị'.toUpperCase(),style:const TextStyle(color: Colors.white),)),
              ),
            ),
          ),
          const SizedBox(height: 40,),
          Visibility(
              visible: connected == true,
              child: Center(child: Text('Kết nối thiết bị thành công'.toUpperCase(),style: TextStyle(color: mainColor,fontWeight: FontWeight.bold),)))
        ],
      ),
    );
  }
}
