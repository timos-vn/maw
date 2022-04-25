import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:maw/screen/register/register_screen.dart';
import 'package:maw/themes/colors.dart';
import 'package:maw/themes/images.dart';
import 'package:maw/utils/utils.dart';
import 'package:maw/widgets/pending_action.dart';
import 'package:maw/widgets/text_field_widget.dart';
import '../main/main_screen.dart';
import '../otp_input/otp_input_screen.dart';
import '../register/forgot_password/forgot_password_screen.dart';
import 'login_bloc.dart';
import 'login_event.dart';
import 'login_sate.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final usernameFocus = FocusNode();
  final passwordFocus = FocusNode();

  bool isChecked = false;

  String errorPass ='', errorUsername='';

  late LoginBloc _loginBloc;

  PhoneNumber number = PhoneNumber(isoCode: Platform.localeName.split('_').last);


  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(context);
    _loginBloc.add(GetPrefs());
    // if(!Utils.isEmpty(MyTranslations.username)){
    //   isChecked = true;
    // }
    // usernameController.text = !Utils.isEmpty(MyTranslations.username) ? MyTranslations.username : '' ;
    // passwordController.text = !Utils.isEmpty(MyTranslations.pass) ? MyTranslations.pass : '' ;
    usernameController.text = '0962983437' ;
    passwordController.text = '123456' ;
  }

  Widget _entryField(String title, TextEditingController textEditingController, {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13,color: Colors.grey),
          ),
          TextFieldWidget(
            controller: passwordController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            isPassword: true,
            errorText: errorPass,
            hintText: '● ● ● ● ● ● ●',
            // prefixIcon: Icons.vpn_key,
            onChanged: (text) => _loginBloc.checkPassBloc(text!),
            focusNode: passwordFocus,
            onSubmitted: (_){},
            inputFormatters: const [],
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        if(!Utils.isEmpty(usernameController.text) && !Utils.isEmpty(passwordController.text)){
          String formatNumber = usernameController.text.toString();
          if(formatNumber.startsWith('0')) {
            formatNumber = formatNumber.substring(1);
          }
          if (!formatNumber.contains("+84")) {
            formatNumber = "+84" + formatNumber;
          }
         _loginBloc.add(Login(formatNumber,passwordController.text,isChecked));
        }else{
          Utils.showCustomToast(context, Icons.error_outline, 'Vui lòng nhập đầy đủ thông tin');
        }
      },
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
          'Đăng nhập',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: const <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('hoặc',),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const ForgotPassWordScreen(typeView: 0,))).then((value){
          if(!Utils.isEmpty(value)){
            setState(() {
              usernameController.text = value[0];
            });
          }
        });
        // NavigatorUtils.push(context, RouterGenerator.routeSignUpScreen);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Bạn chưa có tài khoản ?',
              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Đăng ký ngay',
              style:TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Đăng nhập',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    )
                ),
              Row(
                children: [
                  Image.asset(icon_viet_nam,width: 30,height: 40,fit: BoxFit.contain,),
                  const Icon(Icons.arrow_drop_down_outlined,color: Colors.grey,),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8,),
          const Text('Xin vui lòng nhập thông tin để tiếp tục',style: TextStyle(color: Colors.blueGrey,fontSize: 12),),
        ],
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Số điện thoại',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13,color: Colors.grey),
        ),
        InternationalPhoneNumberInput(
          onInputChanged: (PhoneNumber number) {
            String formatNumber = number.toString().substring(3);
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
          selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.DIALOG,
              trailingSpace: false
          ),
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.disabled,
          selectorTextStyle: const TextStyle(color: Colors.black),
          initialValue: number,
          textFieldController: usernameController,
          formatInput: false,
          searchBoxDecoration: const InputDecoration(
            hintText: 'Tìm kiếm theo tên quốc gia hoặc mã quay số',
          ),
          keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: true),
          locale: 'vi_VN',
          inputBorder: InputBorder.none,
          inputDecoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(bottom: 14),
            hintText: '0xx-xxx-xxx'
          ),
          onSaved: (PhoneNumber number) {

          },
        ),
         const Divider(color: Colors.grey,thickness: 1,),
        const SizedBox(height: 15,),
        _entryField("Mật khẩu", passwordController, isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
        body: BlocProvider(
          create: (context) => _loginBloc,
          child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess){
                    Navigator.push(context, (MaterialPageRoute(builder: (context)=>MainScreen(
                      userName: _loginBloc.username,
                      currentAddress: _loginBloc.currentAddress,
                      rewardPoints: _loginBloc.rewardPoints,
                    ))));
                  }else if (state is ConvertPhoneSuccessful){
                  usernameController.text = state.phoneNumber;
                }else if(state is LoginFailure){
                  Utils.showCustomToast(context, Icons.error_outline, state.error??'Có lỗi xảy ra');
                }
              },
            child: BlocBuilder<LoginBloc, LoginState>(bloc: _loginBloc,
                builder: (BuildContext context, LoginState state,) {
              if (state is ValidateErrorUsername) {
                errorUsername = state.error;
              } else if (state is ValidateErrorPassword) {
                errorPass = state.error;
              }
              return buildScreen(context, state);
            }),
          ),
        ));
  }

  Widget buildSavePassword(){
    return InkWell(
      onTap: (){
        setState(() {
          if(isChecked == true ){
            isChecked = false;
          }else{
            isChecked = true;
          }
        });
      } ,
      child: Container(
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              activeColor: mainColor,
              value: isChecked,
              onChanged: (bool? newValue) {
                setState(() {
                  isChecked = newValue!;
                });
              },
            ),
            const Text(
              'Lưu mật khẩu',
              style: TextStyle(fontSize: 12, color: grey,decoration:TextDecoration.underline ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildScreen(BuildContext context, LoginState state){
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus( FocusNode()),
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
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 200,
                                child: Image.asset('assets/images/splash1.png')),
                            _title(),
                            const SizedBox(height: 50),
                            _emailPasswordWidget(),
                          ],
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: buildSavePassword()),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            _submitButton(),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgotPassWordScreen(typeView: 1,)));
                                },
                                child: const Text('Quên mật khẩu ?',
                                    style: TextStyle(
                                        fontSize: 12.5, fontWeight: FontWeight.w500)),
                              ),
                            ),
                            const SizedBox(height: 10),
                            _divider(),
                            SizedBox(height: height * .015),
                            _createAccountLabel(),
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
          visible: state is LoginLoading,
          child: PendingAction(),
        ),
      ],
    );
  }
}
