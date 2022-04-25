import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:maw/screen/otp_input/otp_input_screen.dart';
import 'package:maw/screen/register/register_bloc.dart';
import 'package:maw/screen/register/register_sate.dart';
import 'package:maw/themes/colors.dart';
import 'package:maw/utils/const.dart';
import 'package:maw/utils/utils.dart';
import 'package:maw/widgets/pending_action.dart';

import '../register_event.dart';



class ForgotPassWordScreen extends StatefulWidget {
  final int? typeView;

  const ForgotPassWordScreen({Key? key,this.typeView}) : super(key: key);


  @override
  _ForgotPassWordState createState() => _ForgotPassWordState();
}

class _ForgotPassWordState extends State<ForgotPassWordScreen> with SingleTickerProviderStateMixin{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final phoneController = TextEditingController();

  final phoneFocus = FocusNode();

  late RegisterBloc _registerBloc;

  PhoneNumber number = PhoneNumber(isoCode: Platform.localeName.split('_').last);

  late String formatNumber;

  @override
  void initState() {
    super.initState();
    _registerBloc = RegisterBloc(context);

  }


  Widget _title() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              InkWell(
                  onTap: ()=> Navigator.pop(context),
                  child: const Icon(Icons.arrow_back,color: Colors.black,)),
              const Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Quên mật khẩu',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      )
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward,color: Colors.white,),
            ],
          ),
          const SizedBox(height: 8,),
          const Text('Xin vui lòng nhập số điện thoại của Quý khách.\nSau khi nhập số điện thoại, Quý khách sẽ nhận\nđược mã OTP để đặt lại mật khẩu.',style: TextStyle(color: Colors.blueGrey,fontSize: 12),textAlign: TextAlign.center,),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider(
          create: (context) => _registerBloc,
          child: BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if(state is GetOTPSuccess){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpInputScreen(
                  phoneNumber: formatNumber,
                  verificationId: state.verificationId,
                  typeView: widget.typeView,
                ))).then((value){
                  if(value != null){
                    if(value[0] == 'LoginStart' || value[0] == Const.BACK){
                      Navigator.pop(context,[formatNumber]);
                    }
                  }
                });
              }
              else if(state is RegisterFailure){
               // Utils.showToast(state.error);
              }
            },
            child: BlocBuilder<RegisterBloc, RegisterState>(
                bloc: _registerBloc,
                builder: (BuildContext context, RegisterState state,) {
                  return buildScreen(context, state);
                }),
          ),
        ));
  }


  Widget buildScreen(BuildContext context, RegisterState state){
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: SizedBox(
            height: height,
            key: _scaffoldKey,
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 45),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _title(),
                            const SizedBox(height: 50),
                            Padding(
                              padding: const EdgeInsets.only(top: 10,bottom: 20),
                              child: _phoneWidget(),
                            ),
                            _submitButton()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: state is RegisterLoading,
          child: PendingAction(),
        ),
      ],
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        _registerBloc.add(GetOTPEvent(formatNumber));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 35),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 15),
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
                  colors: [Color(0xff0B7640), Color(0xff0B7640)])),
          child: const Text(
            'Tiếp tục',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _phoneWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Số điện thoại',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13,color: Colors.grey),
            ),
            Text(' *',style: TextStyle(color: Colors.red),)
          ],
        ),
        InternationalPhoneNumberInput(
          onInputChanged: (PhoneNumber number) {
            formatNumber = number.toString().substring(3);
            if(formatNumber.startsWith('0')) {
              formatNumber = formatNumber.substring(1);
            }
            if (!formatNumber.contains("+84")) {
              formatNumber = "+84" + formatNumber;
            }
          },
          onInputValidated: (bool value) {
            // print(value);
          },
          maxLength: 15,
          selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.DIALOG,
              trailingSpace: false
          ),
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.disabled,
          textAlign: TextAlign.start,
          selectorTextStyle: const TextStyle(color: Colors.black),
          initialValue: number,
          textFieldController: phoneController,
          formatInput: false,
          searchBoxDecoration: const InputDecoration(
            hintText: 'Tìm kiếm theo tên quốc gia hoặc mã quay số',
          ),
          keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
          textStyle: const TextStyle(
            fontSize: 14,
            color: black ,),
          locale: 'vi_VN',
          inputBorder: InputBorder.none,
          inputDecoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(bottom: 15),
            hintText: '',
            hintStyle: TextStyle(
              fontSize: 10,
              color: grey,
            ),
          ),
          onSaved: (PhoneNumber number) {},
        ),
        const SizedBox(
            height: 1,
            child: Divider(color: Colors.grey,thickness: 1,)),
      ],
    );
  }

}
