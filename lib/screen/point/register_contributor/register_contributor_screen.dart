import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:maw/screen/banking/banking_screen.dart';
import 'package:maw/screen/point/register_contributor/register_contributor_bloc.dart';
import 'package:maw/screen/point/register_contributor/register_contributor_state.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../themes/colors.dart';
import '../../../utils/utils.dart';
import '../../../widgets/text_field_widget2.dart';

class RegisterContributorScreen extends StatefulWidget {
  const RegisterContributorScreen({Key? key}) : super(key: key);

  @override
  _RegisterContributorScreenState createState() => _RegisterContributorScreenState();
}

class _RegisterContributorScreenState extends State<RegisterContributorScreen>{

  late RegisterContributorBloc _bloc;

  final usernameBController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final mstController = TextEditingController();
  final ddController = TextEditingController();
  final cvController = TextEditingController();
  final stkController = TextEditingController();

  final mskController = TextEditingController();
  final usernameBFocus = FocusNode();
  final phoneFocus = FocusNode();
  final addressFocus = FocusNode();
  final mstFocus = FocusNode();
  final ddFocus = FocusNode();
  final cvFocus = FocusNode();
  final stkFocus = FocusNode();
  final smkFocus = FocusNode();

  String? banking;
  bool _agreeTerms = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = RegisterContributorBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterContributorBloc,RegisterContributorState>(
      listener: (context,state){

      },
      bloc: _bloc,
      child: BlocBuilder<RegisterContributorBloc,RegisterContributorState>(
        bloc: _bloc,
        builder: (BuildContext context,RegisterContributorState state){
          return buildPage(context,state);
        },
      ),
    );
  }


  Widget buildPage(BuildContext context,RegisterContributorState state){
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
                          Expanded(child: Text('Đăng ký cộng tác viên',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,)),
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
            Expanded(child: SingleChildScrollView(child: buildBody(height))),
          ],
        ),
      ),
    );
  }

  Widget buildBody(double height){
    return Padding(
      padding: EdgeInsets.only(bottom: height * .1,top: 16,left: 16,right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          inputWidget(title: "Họ & tên bên B:",hideText: 'Ghi theo ĐKKD',controller: usernameBController,focusNode: usernameBFocus,textInputAction: TextInputAction.next, onTapSuffix: (){},note: true,onSubmitted: ()=>Utils.navigateNextFocusChange(context,  usernameBFocus,  addressFocus),),
          inputWidget(title: "Địa chỉ",hideText: 'Ghi theo ĐKDN',controller: addressController,focusNode: addressFocus,textInputAction: TextInputAction.next, onTapSuffix: (){},note: true,onSubmitted: ()=>Utils.navigateNextFocusChange(context,  addressFocus,  mstFocus)),
          inputWidget(title: "Mã số thuế",hideText: '',controller: mstController,focusNode: mstFocus,textInputAction: TextInputAction.next, onTapSuffix: (){},note: true,onSubmitted: ()=>Utils.navigateNextFocusChange(context,  mstFocus,  phoneFocus)),
          inputWidget(title: "Điện thoại",hideText: '0963004959',controller: phoneController,focusNode: phoneFocus,textInputAction: TextInputAction.next, onTapSuffix: (){},note: true,onSubmitted: ()=>Utils.navigateNextFocusChange(context,  phoneFocus,  ddFocus)),
          inputWidget(title: "Đại diên",hideText: 'Ghi theo ĐKKD',controller: ddController,focusNode: ddFocus,textInputAction: TextInputAction.next, onTapSuffix: (){},note: true,onSubmitted: ()=>Utils.navigateNextFocusChange(context,  ddFocus,  cvFocus)),
          inputWidget(title: "Chức vụ",hideText: 'Ghi theo ĐKKD',controller: cvController,focusNode: cvFocus,textInputAction: TextInputAction.next, onTapSuffix: (){},note: true,onSubmitted: ()=>Utils.navigateNextFocusChange(context,  cvFocus,  stkFocus)),
          inputWidget(title: "Số tài khoản ngân hàng",hideText: '',controller: stkController,focusNode: stkFocus,textInputAction: TextInputAction.done, onTapSuffix: (){},note: true),
          const SizedBox(height: 15,),
          GestureDetector(
            onTap: (){
              pushNewScreen(context, screen: const BankingScreen(),withNavBar: false);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Tại ngân hàng',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13,color: Colors.black),
                    ),
                    Text(' *',style: TextStyle(color: Colors.red),)
                  ],
                ),
                const SizedBox(height: 5,),
                Container(
                  height: 45,
                  padding: const EdgeInsets.only(left: 16,right: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(14),
                    // color: Colors.grey.withOpacity(0.4)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Ngân hàng Techcombank',style: TextStyle(color: Colors.black),),
                      Icon(Icons.arrow_drop_down,color: Colors.black,),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15,bottom: 15),
            child: inputWidget(title: "Mã số khách hàng",hideText: '',controller: mskController,focusNode: smkFocus,textInputAction: TextInputAction.done, onTapSuffix: (){},note: true),
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                _agreeTerms = !_agreeTerms;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _agreeTerms
                    ? Icon(
                  Icons.check_circle,
                  color: subColor,
                  size: 25,
                )
                    : const Icon(
                  Icons.radio_button_unchecked,
                  color: Colors.grey,
                  size: 25,
                ),
                const SizedBox(width: 5),
                const Text("Tôi đồng ý với các điều khoản"),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Container(
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blueGrey)
              ),
              padding: const EdgeInsets.all(8),
              child: const SingleChildScrollView(
                  child: Text(
                      'Giới thiệu bạn – Thưởng vô hạn'
                      'Trở thành đại sứ và nhận thưởng tới 100.000 đồng cho mỗi người, khi giới thiệu bạn bè đăng ký mới BIDV SmartBanking.'

                  'Từ ngày 26/04 - 31/07/2021, hãy rủ "hội bạn thân" mở tài khoản trực tuyến và đăng ký BIDV SmartBanking ngay từ đường dẫn chia sẻ của bạn nhé.'

                  'BIDV dành tặng bạn và "hội bạn thân" những ưu đãi vô cùng hấp dẫn - với tổng giá trị chương trình lên tới hơn 15 tỷ đồng.'

                  'Theo đó, bộ đôi quà tặng dành cho người giới thiệu và được giới thiệu sau khi đăng ký thành công BIDV SmartBanking như sau:'

                  'Nhận ngay 50.000đ cho mỗi người khi người được giới thiệu là khách hàng hoàn toàn mới (Chưa có mã khách hàng - CIF tại BIDV).'
                  'Nhận 30.000đ cho mỗi người khi người được giới thiệu đã là khách hàng BIDV (Đã có mã khách hàng CIF tại BIDV) nhưng chưa đăng ký sử dụng SmartBanking.'
          'Thưởng ngay 5 triệu đồng cho TOP 20 người giới thiệu xuất sắc nhất hàng tháng.'
          'Mức thưởng không giới hạn đối với người giới thiệu.'
          'Nhân đôi giá trị giải thưởng trong “Tuần lễ tri ân” từ 26/04/2021-03/05/2021.',style: TextStyle(color: Colors.grey),))),
          buildButtonRegister()
        ],
      ),
    );
  }

  Widget buildButtonRegister(){
    return  Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
      child: GestureDetector(
        onTap: (){},
        child: Container(
          height: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: mainColor
          ),
          child: const Center(child: Text('Gửi yêu cầu',style: TextStyle(color: Colors.white),),),
        ),
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
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13,color: Colors.black),
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
}
