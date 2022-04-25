import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maw/screen/cart/cart_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../themes/colors.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/text_field_widget2.dart';
import 'water_test_bloc.dart';
import 'water_test_event.dart';
import 'water_test_state.dart';

class WaterTestScreen extends StatefulWidget {
  const WaterTestScreen({Key? key}) : super(key: key);

  @override
  _WaterTestScreenState createState() => _WaterTestScreenState();
}

class _WaterTestScreenState extends State<WaterTestScreen> with TickerProviderStateMixin{

  late WaterTestBloc _bloc;
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
    _bloc = WaterTestBloc();
    _bloc.add(GetPrefs());

  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WaterTestBloc,WaterTestState>(
      listener: (context,state){

      },
      bloc: _bloc,
      child: BlocBuilder<WaterTestBloc,WaterTestState>(
        bloc: _bloc,
        builder: (BuildContext context,WaterTestState state){
          return buildPage(context,state);
        },
      ),
    );
  }

  Widget buildPage(BuildContext context,WaterTestState state){
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: height * .05,bottom: 0),
        child: Column(
          children: [
            buildTitle(height),
            Container(height: 2,width: double.infinity,color: Colors.blueGrey.withOpacity(0.1),),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(bottom: height * .03,),
                children: [
                  buildBody(height),
                  const SizedBox(height: 15,),
                  Container(height: 6,width: double.infinity,color: Colors.blueGrey.withOpacity(0.1),),
                  buildPackageTest(),
                  const SizedBox(height: 15,),
                  Container(height: 6,width: double.infinity,color: Colors.blueGrey.withOpacity(0.1),),
                  buildTimeForTest(),
                ],
              ),
            ),
            Container(height: 3,width: double.infinity,color: Colors.blueGrey.withOpacity(0.2),),
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.only(left: 16,right: 16,top: 5,bottom: 5),
              child: InkWell(
                onTap: () {
                  pushNewScreen(context, screen: const CartScreen());
                },
                child: Card(
                  elevation: 2,
                  shadowColor: Colors.grey,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.shade200,
                              offset: const Offset(2, 4),
                              blurRadius: 5,
                              spreadRadius: 2)
                        ],
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [mainColor, mainColor])),
                    child: const Text(
                      'Đăng ký',
                      style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ),
            )
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
                  Expanded(child: Text('Đăng ký xét nghiệm nước',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,)),
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

  Widget buildBody(double height){
    return Padding(
      padding: EdgeInsets.only(top: height * .02,left: 16,right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nhập thông tin người nhận',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15,color: Colors.black),
          ),
          const SizedBox(height: 10,),
          inputWidget(title: "Tên người nhận",hideText: 'Tên người nhận',controller: usernameController,focusNode: usernameFocus,textInputAction: TextInputAction.next, onTapSuffix: (){},note: true,onSubmitted: ()=>Utils.navigateNextFocusChange(context,  usernameFocus,  phoneFocus),),
          inputWidget(title: "Số điện thoại",hideText: '0963004959',controller: phoneController,focusNode: phoneFocus,textInputAction: TextInputAction.next, onTapSuffix: (){},note: true,onSubmitted: ()=>Utils.navigateNextFocusChange(context,  phoneFocus,  emailFocus),),
          inputWidget(title: "Email",hideText: 'tiennq.dev@gmail.com',controller: emailController,focusNode: emailFocus,textInputAction: TextInputAction.next, onTapSuffix: (){},note: true,onSubmitted: ()=>Utils.navigateNextFocusChange(context,  emailFocus,  addressFocus),),
          inputWidget(title: "Địa chỉ lấy mẫu",hideText: 'Địa chỉ',controller: addressController,focusNode: addressFocus,textInputAction: TextInputAction.done, onTapSuffix: (){},note: true),
          const Divider(color: Colors.grey,),
          const SizedBox(height: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Chọn trung tâm xét nghiệm',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12,color: Colors.black),
                  ),
                  Text(' *',style: TextStyle(color: Colors.red),)
                ],
              ),
              const SizedBox(height: 5,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Trung Tam ABC',style: TextStyle(color: Colors.black,fontSize: 12),),
                    Icon(Icons.arrow_drop_down,color: Colors.grey,),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget inputWidget({String? title,String? hideText,IconData? iconPrefix,IconData? iconSuffix, bool? isEnable,
    TextEditingController? controller,Function? onTapSuffix, Function? onSubmitted,FocusNode? focusNode,
    TextInputAction? textInputAction,bool inputNumber = false,bool note = false,bool isPassWord = false}){
    return Padding(
      padding: const EdgeInsets.only(top: 10,left: 0,right: 0,bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title??'',
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12,color: Colors.black),
              ),
              Visibility(
                visible: note == true,
                child: const Text(' *',style: TextStyle(color: Colors.red),),
              )
            ],
          ),
          const SizedBox(height: 5,),
          Container(
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12)
            ),
            child: TextFieldWidget2(
              controller: controller!,
              suffix: iconSuffix,
              textInputAction: textInputAction!,
              isEnable: isEnable ?? true,
              keyboardType: inputNumber == true ? TextInputType.phone : TextInputType.text,
              hintText: hideText,
              focusNode: focusNode,
              onSubmitted: (text)=> onSubmitted,
              isPassword: isPassWord,
              inputFormatters: const [],
            ),
          ),
        ],
      ),
    );
  }



  bool status = false;
  Widget buildPackageTest(){
    return Padding(
      padding: const EdgeInsets.only(left: 16,right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15,bottom: 5,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Chỉ tiêu cần kiểm tra',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,),
                Icon(Icons.navigate_next,color: Colors.grey,),
              ],
            ),
          ),
          const Text('Gói cơ bản',style: TextStyle(color: Colors.black,fontSize: 12),),
          const SizedBox(height: 10,),
          SizedBox(height: 120,child: buildListTestBasic()),
          const Divider(),
          const Text('Gói nâng cao',style: TextStyle(color: Colors.black,fontSize: 12),),
          const SizedBox(height: 10,),
          SizedBox(height: 120,child: buildListTestPro()),
        ],
      ),
    );
  }

  bool checkPackageTest = false;

  Widget buildListTestBasic(){
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context,index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16,bottom: 0),
            child: GestureDetector(
              onTap: (){

              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 90,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 35,
                            padding: const EdgeInsets.all(6),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16)
                              ),
                              color: mainColor,
                            ),
                            child: const Center(child: Text('2.400.000đ',style: TextStyle(color: Colors.white),overflow: TextOverflow.ellipsis,maxLines: 1,)),
                          ),
                        ),
                        Container(
                          width: 140,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(16)),
                              border: Border.all(
                                  color: mainColor
                              )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 6,left: 8),
                                child: Text('E-Test $index',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15),overflow: TextOverflow.ellipsis,maxLines: 1,),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5,left: 8,bottom: 5,right: 8),
                                child: Text('($index chỉ tiêu)',style: const TextStyle(color: Colors.grey,fontSize: 12),overflow: TextOverflow.ellipsis,maxLines: 2,),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5,),
                  checkPackageTest == true ? Icon(Icons.check_circle_outline,color: mainColor,) : const Icon(Icons.panorama_fisheye_outlined,color: Colors.grey,),
                ],
              ),
            ),
          );
        }
    );
  }

  Widget buildListTestPro(){
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context,index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16,bottom: 0),
            child: GestureDetector(
              onTap: (){

              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 90,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 35,
                            padding: const EdgeInsets.all(6),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16)
                              ),
                              color: mainColor,
                            ),
                            child: const Center(child: Text('2.400.000đ',style: TextStyle(color: Colors.white),overflow: TextOverflow.ellipsis,maxLines: 1,)),
                          ),
                        ),
                        Container(
                          width: 140,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(16)),
                              border: Border.all(
                                  color: mainColor
                              )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 6,left: 8),
                                child: Text('E-Test $index',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15),overflow: TextOverflow.ellipsis,maxLines: 1,),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5,left: 8,bottom: 5,right: 8),
                                child: Text('($index chỉ tiêu)',style: const TextStyle(color: Colors.grey,fontSize: 12),overflow: TextOverflow.ellipsis,maxLines: 2,),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5,),
                  checkPackageTest == true ? Icon(Icons.check_circle_outline,color: mainColor,) : const Icon(Icons.panorama_fisheye_outlined,color: Colors.grey,),
                ],
              ),
            ),
          );
        }
    );
  }

  Widget buildTimeForTest(){
    return Padding(
      padding: const EdgeInsets.only(left: 16,right: 16,top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Thời gian lấy mẫu',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                Container(
                  padding: const EdgeInsets.only(left: 16,right: 10,top: 4,bottom: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: dark_text.withOpacity(0.3)
                  ),
                  child: Row(
                    children: const [
                      Center(child: Text('15/04/2022',style: TextStyle(color: Colors.black,fontSize: 12),),),
                      SizedBox(width: 5,),
                      Icon(Icons.arrow_drop_down,color: Colors.black,),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CheckedContainer(paddingV: 10,content: '08:00 - 09:00',checked: _bloc.checkingBonus == 0,onTap: ()=> _bloc.add(CheckingTimeSchedule(0)),checkedColor: subColor,),
                CheckedContainer(paddingV: 10,content: '09:00 - 10:00',checked: _bloc.checkingBonus == 1,onTap: ()=> _bloc.add(CheckingTimeSchedule(1)),checkedColor: subColor,),
                CheckedContainer(paddingV: 10,content: '10:00 - 11:00',checked: _bloc.checkingBonus == 2,onTap: ()=> _bloc.add(CheckingTimeSchedule(2)),checkedColor: subColor,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CheckedContainer(paddingV: 10,content: '11:00 - 12:00',checked: _bloc.checkingBonus == 3,onTap: ()=> _bloc.add(CheckingTimeSchedule(3)),checkedColor: subColor,),
                CheckedContainer(paddingV: 10,content: '12:00 - 13:00',checked: _bloc.checkingBonus == 4,onTap: ()=> _bloc.add(CheckingTimeSchedule(4)),checkedColor: subColor,),
                CheckedContainer(paddingV: 10,content: '13:00 - 14:00',checked: _bloc.checkingBonus == 5,onTap: ()=> _bloc.add(CheckingTimeSchedule(5)),checkedColor: subColor,),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CheckedContainer(paddingV: 10,content: '14:00 - 15:00',checked: _bloc.checkingBonus == 6,onTap: ()=> _bloc.add(CheckingTimeSchedule(6)),checkedColor: subColor,),
              CheckedContainer(paddingV: 10,content: '15:00 - 16:00',checked: _bloc.checkingBonus == 7,onTap: ()=> _bloc.add(CheckingTimeSchedule(7)),checkedColor: subColor,),
              CheckedContainer(paddingV: 10,content: '16:00 - 17:00',checked: _bloc.checkingBonus == 8,onTap: ()=> _bloc.add(CheckingTimeSchedule(8)),checkedColor: subColor,),
            ],
          ),
        ],
      ),
    );
  }

}
