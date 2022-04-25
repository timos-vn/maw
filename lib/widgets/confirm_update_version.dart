import 'package:flutter/material.dart';
import 'package:maw/utils/auth_atils.dart';
import 'dart:io' show Platform;
import 'package:url_launcher/url_launcher.dart';

class ConfirmUpdateVersionPage extends StatefulWidget {
  final String? title;
  final String? content;
  final int? type;

  const ConfirmUpdateVersionPage({Key? key, this.title, this.content, this.type}) : super(key: key);
  @override
  _ConfirmUpdateVersionPageState createState() => _ConfirmUpdateVersionPageState();
}

class _ConfirmUpdateVersionPageState extends State<ConfirmUpdateVersionPage> {
  TextEditingController contentController = TextEditingController();
  int groupValue = 0;
  FocusNode focusNodeContent = FocusNode();
  var _token;

  // void navigationPage() {
  //   if (_token != null) {
  //     NavigatorUtils.pushReplacementNamed(context, RouterGenerator.mainScreen,);
  //   } else {
  //     NavigatorUtils.pushReplacementNamed(
  //         context, RouterGenerator.routeIntro);//routeLoginScreen
  //   }
  // }

  void clearAllCake()async{
    AuthUtils.instance.clearAllData();
  }

  void checkExitsToken()async{
    _token = await AuthUtils.instance.getToken();
  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    // checkExitsToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30,),
            child: Container(
              decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(16)),),
              height:  380,
              width: double.infinity,
              child: Material(
                  animationDuration: const Duration(seconds: 3),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: Container(
                    height: double.infinity,width: double.infinity,
                    decoration: const BoxDecoration(
                      // border: Border.all(color: Colors.orange,width: 0.7,),
                      color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(16)
                    ),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image.asset(
                            'assets/images/bg1.png',
                            fit: BoxFit.cover,

                            width: double.infinity,
                          ),
                        ),
                        const SizedBox(height: 30,),
                        Text(widget.title.toString(),style:  const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        const SizedBox(height: 12,),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: Text(widget.content.toString(),style:  const TextStyle(color: Colors.grey,fontSize: 11),textAlign: TextAlign.center,),
                        ),
                        const SizedBox(height: 35,),
                       Padding(
                         padding: const EdgeInsets.only(left: 10,right: 10),
                         child: _submitButton(context),
                       ),
                      ],
                    ),
                  )),
            ),
          ),
        ));
  }

  Widget _submitButton(BuildContext context) {
    return InkWell(
      onTap: () {
        if (Platform.isAndroid) {
         launch('https://play.google.com/store/apps/details?id=takecare.vn.limousine');
        } else{
          //OpenAppstore.launch(androidAppId: "takecare.vn.limousine", iOSAppId: "1563546063");
        }
        //clearAllCake();
        Navigator.pop(context);
      },
      child: Container(
        // width: 150,
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: const Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: const Text(
          'Cập nhật ngay',
          style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}



