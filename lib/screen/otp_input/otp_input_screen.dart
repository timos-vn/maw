import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maw/screen/register/forgot_password/component/reset_password_screen.dart';
import 'package:maw/screen/register/register_screen.dart';
import 'package:maw/themes/colors.dart';
import 'package:maw/themes/images.dart';
import 'package:maw/utils/const.dart';
import 'package:maw/utils/utils.dart';
import 'package:maw/widgets/custom_back_button.dart';
import 'package:maw/widgets/pending_action.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'otp_input_bloc.dart';
import 'otp_input_event.dart';
import 'otp_input_state.dart';

class OtpInputScreen extends StatefulWidget {
  final String? phoneNumber;
  final String? verificationId;
  final int? typeView;

  const OtpInputScreen({Key? key,this.phoneNumber,this.verificationId,
   this.typeView,
  }) : super(key: key);

  @override
  _OtpInputScreenState createState() => _OtpInputScreenState();
}

class _OtpInputScreenState extends State<OtpInputScreen> {
  final TextEditingController _otpController = TextEditingController();
  late OtpInputBloc _otpBloc;
  // SignUpBloc _signUpBloc;
  String? _errorOtp;
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  String? smsCode;
  FocusNode? _inputCode;
  int countSend = 1;
  bool showSendOTP = false;
  String? verificationCode;
  ///
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _otpBloc = OtpInputBloc(context);
    errorController = StreamController<ErrorAnimationType>();
    // _signUpBloc = SignUpBloc(context);
    _inputCode = FocusNode();
    countSend = 1;
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message.toString()),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: BlocProvider(
          create: (context) => _otpBloc,
          child: BlocListener<OtpInputBloc, OtpInputState>(
              listener: (context, state) {
            if (state is FinishVerityOTPState) {
              if(widget.typeView == 1){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ResetPassWordScreen(phoneNumber: widget.phoneNumber.toString(),)));
              }else {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterScreen(phoneNumber: widget.phoneNumber.toString(),))).then((value){
                  if(value != null){
                    if(value[0] == Const.BACK){
                      Navigator.pop(context,[Const.BACK,value[1]]);
                    }
                  }
                });
              }
            }
            if(state is OtpInputFailure){
              Utils.showCustomToast(context, Icons.error_outline, 'Có lỗi xảy ra trong quá trình xác thực OTP');
              // Utils.showToast(state.error);
              Navigator.pop(context,['RegisterFail']);
            }
            if(state is OtpInputExpired){
              Utils.showCustomToast(context, Icons.warning_amber_outlined, 'Mã OTP sai hoặc đã hết hạn');
              // Utils.showToast('Mã OTP sai hoặc đã hết hạn.');

            }
            if(state is GetOTPFinishState){
              Utils.showCustomToast(context, Icons.message, 'Vui lòng đợi trong giây lát');
              // Utils.showToast('Vui lòng đợi trong giây lát.');
            }
            if(state is RegisterSuccess){
              Utils.showCustomToast(context, Icons.check_circle_outline, 'Đăng ký thành công');
              Navigator.pop(context,['LoginStart']);
            }
          }, child: BlocBuilder<OtpInputBloc, OtpInputState>(builder: (
            BuildContext context,
            OtpInputState state,
          ) {
            if (state is ValidateOtpError) _errorOtp = state.error;

            return Stack(
              children: <Widget>[
                GestureDetector(
                    onTap: () =>
                        FocusScope.of(context).requestFocus(FocusNode()),
                    child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: ListView(
                              children: <Widget>[
                                const SizedBox(height: 30),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height / 3.5,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.asset(otp_gif_image),
                                  ),
                                ),
                                //SizedBox(height: 8),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    'Xác thực số điện thoại',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                                  child: RichText(
                                    text: TextSpan(
                                        text: "Mã xác thực được gửi tới ",
                                        children: [
                                          TextSpan(
                                              text: "${widget.phoneNumber}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)),
                                        ],
                                        style: const TextStyle(color: Colors.black54, fontSize: 15)),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Form(
                                  key: formKey,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 30),
                                      child: PinCodeTextField(
                                        appContext: context,
                                        pastedTextStyle: TextStyle(
                                          color: Colors.green.shade600,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        length: 6,
                                        // obscureText: true,
                                        // obscuringCharacter: '*',
                                        // obscuringWidget: FlutterLogo(
                                        //   size: 24,
                                        // ),
                                        blinkWhenObscuring: true,
                                        animationType: AnimationType.fade,
                                        validator: (v) {
                                          if (v.toString().length < 3) {
                                            return "Mã xác thực không chính xác";
                                          } else {
                                            return null;
                                          }
                                        },
                                        pinTheme: PinTheme(
                                          shape: PinCodeFieldShape.box,
                                          borderRadius: BorderRadius.circular(5),
                                          fieldHeight: 50,
                                          fieldWidth: 40,
                                          activeFillColor: Colors.white,
                                        ),
                                        cursorColor: Colors.black,
                                        animationDuration: Duration(milliseconds: 300),
                                        enableActiveFill: true,
                                        errorAnimationController: errorController,
                                        controller: _otpController,
                                        keyboardType: TextInputType.number,
                                        boxShadows:const [
                                          BoxShadow(
                                            offset: Offset(0, 1),
                                            color: Colors.black12,
                                            blurRadius: 10,
                                          )
                                        ],
                                        onCompleted: (v) {},
                                        onChanged: (value) {
                                          setState(() {
                                            currentText = value;
                                          });
                                        },
                                        beforeTextPaste: (text) {
                                          return true;
                                        },
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: Text(
                                    hasError ? "" : "",
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Bạn không nhận được mã? ",
                                      style: TextStyle(color: Colors.black54, fontSize: 15),
                                    ),
                                    TextButton(
                                        onPressed: () => _otpBloc.add(GetOTP(widget.phoneNumber.toString())),
                                        child: Text(
                                          "Gửi lại".toUpperCase(),
                                          style: const TextStyle(
                                              color: Colors.lightBlue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ))
                                  ],
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Container(
                                  margin:
                                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                                  child: ButtonTheme(
                                    height: 50,
                                    child: TextButton(
                                      onPressed: () {
                                        formKey.currentState?.validate();
                                        if (currentText.length != 6) {
                                          errorController?.add(ErrorAnimationType.shake);
                                          hasError = true;
                                        } else {
                                          PhoneAuthCredential phoneAuthCredential =
                                          PhoneAuthProvider.credential(verificationId: widget.verificationId.toString(), smsCode: _otpController.text);
                                          _otpBloc.add(VerityOTP(phoneNumber: widget.phoneNumber,phoneAuthCredential:phoneAuthCredential));
                                          hasError = false;
                                        }
                                      },
                                      child: const Center(
                                          child: Text(
                                            "Xác thực",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                          Positioned(top: 40, left: 0, child: backButton(context),),
                    ])),
                Visibility(
                  visible: state is OtpInputLoading || state is AwaitVerityOTPState,
                  child: PendingAction(),
                ),
              ],
            );
          })),
        ));
  }

}
