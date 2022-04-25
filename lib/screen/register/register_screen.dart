import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:jiffy/jiffy.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:maw/screen/otp_input/otp_input_screen.dart';
import 'package:maw/screen/register/register_bloc.dart';
import 'package:maw/screen/register/register_event.dart';
import 'package:maw/screen/register/register_sate.dart';
import 'package:maw/themes/colors.dart';
import 'package:maw/utils/const.dart';
import 'package:maw/utils/utils.dart';
import 'package:maw/widgets/pending_action.dart';
import 'package:maw/widgets/text_field_widget.dart';

class RegisterScreen extends StatefulWidget {
  final String phoneNumber;

  const RegisterScreen({Key? key,required this.phoneNumber}) : super(key: key);


  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passController = TextEditingController();
  final birthDayController = TextEditingController();
  final sexController = TextEditingController();
  final passWordController = TextEditingController();
  final addressController = TextEditingController();

  final usernameFocus = FocusNode();
  final emailFocus = FocusNode();
  final phoneFocus = FocusNode();
  final passFocus = FocusNode();
  final addressFocus = FocusNode();

  bool isChecked = false;

  String errorPass ='', errorUsername='';

  late RegisterBloc _registerBloc;

  PhoneNumber number = PhoneNumber(isoCode: Platform.localeName.split('_').last);


  @override
  void initState() {
    super.initState();
    _registerBloc = RegisterBloc(context);
    phoneController.text = widget.phoneNumber;
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
                  child: Text('Đăng ký',
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
          const Text('Để tạo tài khoản xin vui lòng nhập\nthông tin của quý khách',style: TextStyle(color: Colors.blueGrey,fontSize: 12),textAlign: TextAlign.center,),
        ],
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
            String formatNumber = number.toString().substring(3);
            // if (usernameController.text.startsWith("0"))
            //   usernameController.text = usernameController.text.substring(1);
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
          ),
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.disabled,
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
            contentPadding: EdgeInsets.only(bottom: 14),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: BlocProvider(
          create: (context) => _registerBloc,
          child: BlocListener<RegisterBloc, RegisterState>(
              listener: (context, state) {
                if (state is RegisterSuccess){
                  Utils.showCustomToast(context, Icons.check_circle_outline, state.mess??'Đăng ký tài khoản thành công');
                  Navigator.pop(context,[Const.BACK,widget.phoneNumber]);
                }
                else if(state is ChooseSexSuccess){
                  sexController.text = _registerBloc.sex.toString();
                }else if(state is ResetPassWordSuccess){
                  Utils.showCustomToast(context, Icons.check_circle_outline, state.mess??'Thay đổi mật khẩu thành công');
                }else if(state is RegisterFailure){
                  Utils.showCustomToast(context, Icons.error_outline, state.error??'Có lỗi xảy ra');
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
                            inputWidget(title: "Họ & tên",hideText: 'Họ & tên',controller: usernameController,focusNode: usernameFocus,textInputAction: TextInputAction.next, onTapSuffix: ()=> Utils.navigateNextFocusChange(context,  usernameFocus,  emailFocus),note: true),
                            inputWidget(title: "Email",hideText: 'email@gmail.com',controller: emailController,focusNode: emailFocus,textInputAction: TextInputAction.next, onTapSuffix: ()=>Utils.navigateNextFocusChange(context,  emailFocus,  addressFocus),note: true),
                            inputWidget(title: "Địa chỉ",hideText: 'Địa chỉ của bạn',controller: addressController,focusNode: addressFocus,textInputAction: TextInputAction.next, onTapSuffix: ()=>Utils.navigateNextFocusChange(context,  addressFocus,  passFocus),note: true),
                            inputWidget(title: "Mật khẩu",hideText: '*******',controller: passWordController,isEnable: true,textInputAction: TextInputAction.done,isPassWord: true,note: true),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 10,bottom: 20),
                            //   child: _phoneWidget(),
                            // ),
                            GestureDetector(
                                onTap: (){
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(1980, 1, 1),
                                      theme: const DatePickerTheme(
                                        backgroundColor: Colors.white
                                      ),
                                      maxTime: DateTime.now(), onChanged: (date) {
                                      }, onConfirm: (date) {
                                        setState(() {
                                          birthDayController.text = Jiffy(date).format('yyyy-MM-dd');
                                        });
                                      }, currentTime: DateTime.now(), locale: LocaleType.vi);
                                },
                                child: inputWidget(title: "Ngày sinh",hideText: '1995/03/04',iconPrefix: MdiIcons.storefrontOutline,iconSuffix: Icons.arrow_drop_down_outlined,isEnable: false,controller: birthDayController,textInputAction: TextInputAction.done,)),
                            GestureDetector(
                                onTap: (){
                                  showGenSex(context,Const.listSex);

                                },
                                child: inputWidget(title: "Giới tính",hideText: 'Nam',controller: sexController,iconPrefix: MdiIcons.accountHeartOutline,iconSuffix: Icons.arrow_drop_down_outlined,isEnable: false,textInputAction: TextInputAction.done,)),

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
        if(!Utils.isEmpty(usernameController.text) && !Utils.isEmpty(passWordController.text) && !Utils.isEmpty(phoneController.text)){
          _registerBloc.add(RegisterAccountEvent(
            username: usernameController.text,
            password: passWordController.text,
            phoneNumber: widget.phoneNumber,
            sex: sexController.text,
            birthday: birthDayController.text,
            email: emailController.text,
            address: addressController.text
          ));
        }else{
          Utils.showCustomToast(context, Icons.error_outline,'Vui lòng nhập đầy đủ thông tin');
        }
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
            'Xác nhận',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget inputWidget({String? title,String? hideText,IconData? iconPrefix,IconData? iconSuffix, bool? isEnable,
    TextEditingController? controller,Function? onTapSuffix, Function? onSubmitted,FocusNode? focusNode,
    TextInputAction? textInputAction,bool inputNumber = false,bool note = false,bool isPassWord = false}){
    return Padding(
      padding: const EdgeInsets.only(top: 10,left: 0,right: 0,bottom: 20),
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
          SizedBox(
            height: 33,
            child: TextFieldWidget(
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

  void showGenSex(BuildContext context,List<String> listName){
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        builder: (builder){
          return StatefulBuilder(
            builder: (BuildContext context,StateSetter myState){
              return Container(
                height: MediaQuery.of(context).size.height * 0.40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                child:  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0))),
                    child: Column(
                      children: [
                        Container(
                          padding:const EdgeInsets.only(left: 16,right: 16,top: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 5,
                                width: 60,
                                decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.all(Radius.circular(24))
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Giới tính',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                    GestureDetector(
                                      onTap: ()=>Navigator.pop(context),
                                      child: const SizedBox(
                                          height: 30,
                                          width: 40,
                                          child: Icon(Icons.clear,color: Colors.black,)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                separatorBuilder: (BuildContext context, int index)=>const Padding(
                                  padding: EdgeInsets.only(left: 16,right: 16,),
                                  child: Divider(),
                                ),

                                itemBuilder: (BuildContext context, int index){
                                  return InkWell(
                                    onTap: ()=> Navigator.pop(context,[index,listName[index].toString()]),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 0,right: 10),
                                      child: SizedBox(
                                        height: 40,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(child: Text(listName[index].toString(),style: TextStyle(color: blue.withOpacity(0.5)),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: listName.length
                            ),
                          ),
                        )
                      ],
                    )),
              );
            },
          );
        }
    ).then((value){
      if(value != null){
        _registerBloc.add(ChooseSex(sex: value[1]));
      }
    });
  }
}
