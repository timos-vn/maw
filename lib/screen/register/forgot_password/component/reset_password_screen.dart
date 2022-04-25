import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maw/screen/register/register_bloc.dart';
import 'package:maw/screen/register/register_event.dart';
import 'package:maw/screen/register/register_sate.dart';
import 'package:maw/themes/colors.dart';
import 'package:maw/utils/utils.dart';
import 'package:maw/widgets/pending_action.dart';
import 'package:maw/widgets/text_field_widget.dart';

class ResetPassWordScreen extends StatefulWidget {
  final String phoneNumber;

  const ResetPassWordScreen({Key? key,required this.phoneNumber}) : super(key: key);


  @override
  _ResetPassWordScreenState createState() => _ResetPassWordScreenState();
}

class _ResetPassWordScreenState extends State<ResetPassWordScreen> with SingleTickerProviderStateMixin{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final passWordController = TextEditingController();
  final passWordAgainController = TextEditingController();


  final passWordFocus = FocusNode();
  final passWordAgainFocus = FocusNode();

  late RegisterBloc _registerBloc;

  String? errorPass, errorAgainPass;


  @override
  void initState() {
    super.initState();
    _registerBloc = RegisterBloc(context);

  }

  Widget _title() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          InkWell(
              onTap: ()=> Navigator.pop(context),
              child: const Icon(Icons.arrow_back,color: Colors.black,)),
          const Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text('Đặt lại mật khẩu',
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

              }
            },
            child: BlocBuilder<RegisterBloc, RegisterState>(
                bloc: _registerBloc,
                builder: (BuildContext context, RegisterState state,) {
                  if (state is ValidateErrorPasswordNew) errorPass = state.error;
                  if (state is ValidateErrorAgainPasswordNew) errorAgainPass = state.error;
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
                            inputWidget(title: "Mật khẩu mới",hideText: '*******',controller: passWordController,
                                focusNode: passWordFocus,isEnable: true,textInputAction: TextInputAction.done,
                                isPassWord: true,note: true,
                                checkErr: 0,
                                errorText: errorPass
                            ),
                            inputWidget(title: "Nhập lại Mật khẩu mới",hideText: '*******',
                                controller: passWordAgainController,focusNode: passWordAgainFocus,isEnable: true,
                                textInputAction: TextInputAction.done,isPassWord: true,note: true,
                                checkErr: 1,
                                errorText: errorAgainPass
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
        if(!Utils.isEmpty(passWordController.text) && !Utils.isEmpty(passWordAgainController.text) && errorPass == null && errorAgainPass == null){
          _registerBloc.add(ResetPassWordEvent(phoneNumber: widget.phoneNumber));
        }else{
          Utils.showCustomToast(context, Icons.error_outline, 'Vui lòng nhập đầy đủ thông tin');
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
    TextEditingController? controller,Function? onTapSuffix, Function? onSubmitted, int? checkErr,FocusNode? focusNode,
    TextInputAction? textInputAction,bool inputNumber = false,bool note = false,bool isPassWord = false,String? errorText}){
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
              errorText: errorText,
              onSubmitted: (text)=> onSubmitted,
              onChanged: (text){
               if(checkErr == 0){
                  _registerBloc.checkPasswordNewBloc(text!);
                }else{
                  _registerBloc.checkAgainPassBloc(passWordAgainController.text,text!);
                }
              },
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
                child: Container(
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

    });
  }
}
