import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../themes/colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/text_field_widget2.dart';
import 'order_for_someone_bloc.dart';
import 'order_for_someone_event.dart';
import 'order_for_someone_state.dart';

class OrderForSomeOneScreen extends StatefulWidget {
  const OrderForSomeOneScreen({Key? key}) : super(key: key);

  @override
  _OrderForSomeOneScreenState createState() => _OrderForSomeOneScreenState();
}

class _OrderForSomeOneScreenState extends State<OrderForSomeOneScreen> with TickerProviderStateMixin{

  late OrderForSomeOneBloc _bloc;
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final usernameFocus = FocusNode();
  final phoneFocus = FocusNode();final addressFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = OrderForSomeOneBloc();
    _bloc.add(GetPrefs());

  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderForSomeOneBloc,OrderForSomeOneState>(
      listener: (context,state){

      },
      bloc: _bloc,
      child: BlocBuilder<OrderForSomeOneBloc,OrderForSomeOneState>(
        bloc: _bloc,
        builder: (BuildContext context,OrderForSomeOneState state){
          return buildPage(context,state);
        },
      ),
    );
  }

  Widget buildPage(BuildContext context,OrderForSomeOneState state){
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
                  buildProductOrder(),
                  const SizedBox(height: 15,),
                  Container(height: 6,width: double.infinity,color: Colors.blueGrey.withOpacity(0.1),),
                  buildPayment(),
                  const SizedBox(height: 15,),
                  Container(height: 6,width: double.infinity,color: Colors.blueGrey.withOpacity(0.1),),
                  buildBonusForTechnique(),
                  const SizedBox(height: 15,),
                  Container(height: 6,width: double.infinity,color: Colors.blueGrey.withOpacity(0.1),),
                  buildPaymentDetail()
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
                      'Đặt hàng',
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
                  Expanded(child: Text('Đặt hộ đơn hàng',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,)),
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
          inputWidget(title: "Tên người nhận",hideText: 'Tên người nhận',controller: usernameController,focusNode: usernameFocus,textInputAction: TextInputAction.done, onTapSuffix: (){},note: true),
          inputWidget(title: "Số điện thoại",hideText: '0963004959',controller: phoneController,focusNode: phoneFocus,textInputAction: TextInputAction.done, onTapSuffix: (){},note: true),
          inputWidget(title: "Địa chỉ",hideText: 'Địa chỉ',controller: addressController,focusNode: addressFocus,textInputAction: TextInputAction.done, onTapSuffix: (){},note: true),
          const Divider(color: Colors.grey,),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Ghi chú:',style: TextStyle(color: Colors.black,fontStyle: FontStyle.italic,decoration: TextDecoration.underline,fontSize: 12),),
              Text('Viết tin nhắn...',style: TextStyle(color: Colors.grey,fontStyle: FontStyle.italic,fontSize: 11),),
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
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13,color: Colors.grey),
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

  Widget buildProductOrder(){
    return Padding(
        padding: const EdgeInsets.only(top: 10,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 5,bottom: 3,left: 16,right: 16),
            child: Text('Sản phẩm',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,),
          ),
          ListView.builder(
              padding: const EdgeInsets.only(top: 5,left: 0,right: 0,bottom: 0),
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context,index) =>
                  Container(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Container(
                      color: Colors.grey.withOpacity(0.2),
                      padding: const EdgeInsets.only(top: 15,right: 16,left: 16,bottom: 15),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6), // Image border
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(35), // Image radius
                              child: CachedNetworkImage(
                                imageUrl: 'https://i.pinimg.com/564x/5e/93/14/5e9314a0f83f3f48e5d5fde1a77d3519.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15,),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Ten/ma sp',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black),),
                                    const SizedBox(height: 5,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const Icon(MdiIcons.tag,size: 16,color: Colors.grey,),
                                        const SizedBox(width: 5,),
                                        Text('Đại lý EnterBuy',style: TextStyle(color: subColor,fontSize: 11),),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: const [
                                    Text('x1',style: TextStyle(color: Colors.black),),
                                    SizedBox(height: 10,),
                                    Text('180.000đ',style: TextStyle(color: Colors.black),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
          ),
          const Padding(
            padding: EdgeInsets.only(top: 5,bottom: 10,left: 16,right: 16),
            child: Text('Đặt lịch',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5,bottom: 3,left: 16,right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 15,right: 8,top: 7,bottom: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.withOpacity(0.2)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Chọn giờ',style: TextStyle(color: Colors.black,fontSize: 12),),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_drop_down_outlined,color: Colors.black,size: 20,)
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15,right: 8,top: 7,bottom: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.withOpacity(0.2)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('16/03/2022',style: TextStyle(color: Colors.black,fontSize: 12),),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_drop_down_outlined,color: Colors.black,size: 20,)
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }


  bool status = false;
  Widget buildPayment(){
    return Padding(
      padding: const EdgeInsets.only(left: 16,right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 15,bottom: 16,),
            child: Text('Hình thức thanh toán',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Internet Banking',style: TextStyle(color: Colors.black,fontSize: 12),),
                  SizedBox(height: 5,),
                  Text('(Thanh toán chuyển khoản)',style: TextStyle(color: Colors.grey,fontSize: 10),),
                ],
              ),
              const Icon(Icons.navigate_next,color: Colors.black,),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8,bottom: 8),
            child: Divider(color: Colors.grey,),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('COD',style: TextStyle(color: Colors.black,fontSize: 12),),
                  SizedBox(height: 5,),
                  Text('Nhân viên ký xác nhận khi Khách hàng thanh toán',style: TextStyle(color: Colors.grey,fontSize: 10),),
                ],
              ),
              FlutterSwitch(
                width: 55.0,
                height: 25.0,
                valueFontSize: 12.0,
                toggleSize: 18.0,
                value: status,
                activeColor: subColor,
                onToggle: (val) {
                  setState(() {
                    status = val;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBonusForTechnique(){
    return Padding(
      padding: const EdgeInsets.only(left: 16,right: 16,top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 15,bottom: 16,),
            child: Text('Thưởng cho kỹ thuật',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CheckedContainer(paddingV: 25,content: '0 đ',checked: _bloc.checkingBonus == 0,onTap: ()=> _bloc.add(CheckingBonus(0)),checkedColor: subColor,),
              CheckedContainer(paddingV: 15,content: '5.000 đ',checked: _bloc.checkingBonus == 1,onTap: ()=> _bloc.add(CheckingBonus(1)),checkedColor: subColor,),
              CheckedContainer(paddingV: 15,content: '10.000 đ',checked: _bloc.checkingBonus == 2,onTap: ()=> _bloc.add(CheckingBonus(2)),checkedColor: subColor,),
              CheckedContainer(paddingV: 25,content: 'Khác',checked: _bloc.checkingBonus == 3,onTap: ()=> _bloc.add(CheckingBonus(3)),checkedColor: subColor,),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPaymentDetail(){
    return Padding(
      padding: const EdgeInsets.only(left: 16,right: 16,top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 15,bottom: 6,),
            child: Text('Thanh toán',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,),
          ),
          customWidgetPayment('Tổng tiền hàng:','180.000 đ',0,''),
          customWidgetPayment('Phí vận chuyển:','Free',0,''),
          customWidgetPayment('Voucher:','',5,'FreeShip'),
          Padding(
            padding: const EdgeInsets.only(top: 15,bottom: 6,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Tổng Thanh toán',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,),
                Text('180.000 đ',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customWidgetPayment(String title,String subtitle,int discount, String freeShip){
    return Padding(
      padding:const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,style: const TextStyle(fontSize: 12,color: Colors.blueGrey),),
              subtitle != '' ? Text(subtitle,style: const TextStyle(fontSize: 13,color: Colors.black),) :
                  discount > 0 ?
                      Row(
                        children: [
                          Visibility(
                            visible: discount > 0,
                            child: DottedBorder(
                                dashPattern: const [5, 3],
                                color: subColor,
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(2),
                                padding: const EdgeInsets.only(top: 2,bottom: 2,left: 16,right: 16),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  ),
                                  child: Text('-$discount %',style: TextStyle(fontSize: 11,color: subColor),
                                  ),
                                )
                            ),
                          ),
                          Visibility(
                            visible: freeShip != '',
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: DottedBorder(
                                  dashPattern: const [5, 3],
                                  color: subColor,
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(2),
                                  padding: const EdgeInsets.only(top: 2,bottom: 2,left: 16,right: 16),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                    ),
                                    child: Text('FreeShip',style: TextStyle(fontSize: 11,color: subColor),
                                    ),
                                  )
                              ),
                            ),
                          )
                        ],
                      )
                      : Container(),
            ],
          ),
          const Divider(color: Colors.grey,)
        ],
      ),
    );
  }
}
