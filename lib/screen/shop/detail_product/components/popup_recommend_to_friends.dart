import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../themes/colors.dart';
import '../../../../widgets/text_field_widget2.dart';

class RecommendToFriendScreen extends StatefulWidget {
  const RecommendToFriendScreen({Key? key}) : super(key: key);


  @override
  _RecommendToFriendScreenState createState() => _RecommendToFriendScreenState();
}

class _RecommendToFriendScreenState extends State<RecommendToFriendScreen> {
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final commentController = TextEditingController();
  final usernameFocus = FocusNode();
  final phoneFocus = FocusNode();
  final commentFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: buildPage(context)
    );
  }

  Widget buildPage(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 25,bottom: 25),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24)
        ),
        child: SingleChildScrollView(
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                     Padding(
                       padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16,top: 0),
                       child: Column(
                         children: [
                           const Padding(
                             padding: EdgeInsets.all(10.0),
                             child: Text('Xin vui lòng nhập thông tin người bạn muốn giới thiệu',style:TextStyle(color: Colors.blueGrey),textAlign: TextAlign.center,),
                           ),
                           inputWidget(title: "Tên người nhận",hideText: 'Tên người nhận',controller: usernameController,focusNode: usernameFocus,textInputAction: TextInputAction.done, onTapSuffix: (){},note: true),
                           inputWidget(title: "Số điện thoại",hideText: '0963004959',controller: phoneController,focusNode: phoneFocus,textInputAction: TextInputAction.done, onTapSuffix: (){},note: true),
                           inputWidget(title: "Lời nhắn",hideText: 'Lời nhắn',controller: commentController,focusNode: commentFocus,textInputAction: TextInputAction.done, onTapSuffix: (){},note: true),
                         ],
                       ),
                     ),
                      Container(
                        color: Colors.grey.withOpacity(0.2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 16,right: 16,top: 10),
                              child: Text('Sản phẩm',style:TextStyle(color: Colors.black),textAlign: TextAlign.center,),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Container(
                                padding: const EdgeInsets.only(top: 10,right: 16,left: 16,bottom: 15),
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
                                        const SizedBox(height: 5,),
                                        const Text('180.000đ',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 16,right: 16,top: 15,bottom: 20),
                        child: InkWell(
                          onTap: () {

                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                InkWell(
                  onTap: ()=>Navigator.pop(context),
                  child: const Icon(Icons.cancel_outlined,color: Colors.white,size: 30,),
                )
              ],
            ),
          ),
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
            height: 40,
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