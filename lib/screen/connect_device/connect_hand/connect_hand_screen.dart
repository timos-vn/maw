import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:maw/models/models/core_water.dart';
import 'package:maw/widgets/custom_appbar.dart';
import 'package:maw/widgets/text_field_widget2.dart';

import '../../../themes/colors.dart';
import 'connect_hand_bloc.dart';
import 'connect_hand_state.dart';
import 'connect_hand_event.dart';

class ConnectHandScreen extends StatefulWidget {
  final String? ssId;
  final String? bssId;
  
  const ConnectHandScreen({Key? key,this.ssId,this.bssId}) : super(key: key);

  @override
  _ConnectHandScreenState createState() => _ConnectHandScreenState();
}

class _ConnectHandScreenState extends State<ConnectHandScreen> {
  final productNameController = TextEditingController();
  final productNameFocus = FocusNode();
  final dateUseController = TextEditingController();
  final dateUseFocus = FocusNode();
  final addressController = TextEditingController();
  final addressFocus = FocusNode();
  final addressSetupController = TextEditingController();
  final addressSetupFocus = FocusNode();
  final nameCoreController = TextEditingController();
  final nameCoreFocus = FocusNode();
  late ConnectHandBloc _bloc;

  String nameAt = '';

  final ImagePicker _picker = ImagePicker();
  // ignore: prefer_typing_uninitialized_variables
  var _image;
  late String lastSelectedValue;
  late List<DataCoreWater> _listCoreWater;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = ConnectHandBloc();
    _listCoreWater = _bloc.listCoreWater;
    _bloc.add(GetPrefs());
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectHandBloc,ConnectHandState>(
      listener: (context,state){
        if(state is AddOrRemoveCoreWaterSuccess){
          _listCoreWater = _bloc.listCoreWater;
        }
      },
      bloc: _bloc,
      child: BlocBuilder<ConnectHandBloc,ConnectHandState>(
        bloc: _bloc,
        builder: (BuildContext context,ConnectHandState state){
          return buildPage(context,state);
        },
      ),
    );
  }

  Widget buildPage(BuildContext context,ConnectHandState state){
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: height * .05,bottom: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
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
                                Expanded(child: Text('Thông tin thiết bị',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Icon(Icons.qr_code,color: mainColor,),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const[
                      Text('Xin vui lòng nhập đầy đủ thông tin để quản lý\nthiết bị của bạn',style: TextStyle(color: Colors.blueGrey,fontSize: 12,),textAlign: TextAlign.center,maxLines: 2,),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  Container(height: 5,color: Colors.grey.withOpacity(0.2),),
                  buildBody(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBody(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Thiết bị chính',style: TextStyle(color: mainColor,fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                inputWidget(title: "Tên sản phẩm",hideText: 'Tên sản phẩm',controller: productNameController,focusNode: productNameFocus,
                  textInputAction: TextInputAction.next, onTapSuffix: (){},note: true,iconSuffix: Icons.search_outlined,
                  onSubmitted: ()=>null,),
                const SizedBox(height: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'Thương hiệu',
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
                          Text('Panasonic',style: TextStyle(color: Colors.black,fontSize: 12),),
                          Icon(Icons.arrow_drop_down,color: Colors.grey,),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10,),
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
                              dateUseController.text = Jiffy(date).format('yyyy-MM-dd');
                            });
                          }, currentTime: DateTime.now(), locale: LocaleType.vi);
                    },
                    child: inputWidget(title: "Ngày bắt đầu sử dụng",hideText: '****/**/**',iconPrefix: MdiIcons.storefrontOutline,iconSuffix: Icons.arrow_drop_down_outlined,isEnable: false,controller: dateUseController,textInputAction: TextInputAction.done,)),
                const SizedBox(height: 10,),
                inputWidget(title: "Địa chỉ lắp đặt",hideText: 'Địa chỉ lắp đặt',controller: addressController,focusNode: addressFocus,
                  textInputAction: TextInputAction.next, onTapSuffix: (){},note: true,
                  onSubmitted: ()=>null,),
                const SizedBox(height: 10,),
                inputWidget(title: "Vị trí lắp đặt",hideText: 'Vị trí lắp đặt',controller: addressSetupController,focusNode: addressSetupFocus,
                  textInputAction: TextInputAction.next, onTapSuffix: (){},note: true,
                  onSubmitted: ()=>null,),
                const SizedBox(height: 10,),
                const Text('Cập nhật hình ảnh',style: TextStyle(color: Colors.black,),),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: ()=> selectCamera(),
                      child: Stack(
                        overflow: Overflow.visible,
                        children: [
                          Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(10.0),
                            child:  ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child:_image == null
                                    ? GestureDetector(
                                    onTap: (){selectCamera();},
                                    child: Container(
                                        height: 120.0,
                                        width: 120.0,
                                        color: primaryColor,
                                        child: CachedNetworkImage(imageUrl: "https://source.unsplash.com/1600x900/?portrait",fit: BoxFit.fill,)
                                    )
                                ):  GestureDetector(
                                    onTap: () {selectCamera();},
                                    child: SizedBox(
                                      height: 80.0,
                                      width: 80.0,
                                      child: Image.file(_image,fit: BoxFit.cover, height: 800.0,width: 80.0,),
                                    )
                                )
                            ),
                          ),
                          Positioned(
                              right: -15,
                              bottom: -13,
                              child: Container(
                                  padding: const EdgeInsets.all(5),
                                  child: const Icon(Icons.camera_alt_rounded,color: Colors.grey,)))
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16,),
              ],
            ),
          ),
          Container(height: 5,color: Colors.grey.withOpacity(0.2),),
          coreWater(),
          Container(height: 5,color: Colors.grey.withOpacity(0.2),),
          deviceAt()
        ],
      ),
    );
  }

  Widget coreWater(){
    return Padding(
      padding: const EdgeInsets.only(top: 16,bottom: 10,left: 16,right: 16),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Lõi lọc',style: TextStyle(color: mainColor,fontWeight: FontWeight.bold),)),
          const SizedBox(height: 10,),
          if(_listCoreWater.isNotEmpty)
            for(var i in _listCoreWater) Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tên lõi lọc ${_listCoreWater.indexOf(i) + 1}',
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12,color: Colors.black),
                        ),
                        InkWell(
                            onTap: ()=>_bloc.add(AddOrRemoveCoreWater(type: false,item: i,index: _listCoreWater.indexOf(i))),
                            child: const SizedBox(
                                height: 30,width: 40,
                                child: Icon(MdiIcons.deleteCircle,color: Colors.grey,))),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: grey, width: 1),
                            ),
                            contentPadding: const EdgeInsets.only(top: 16,bottom: 10,left: 10),
                            isDense: true,
                            focusColor: primaryColor,
                            hintText: 'Tên lõi lọc',
                            hintStyle: const TextStyle(
                              fontSize: 12,
                              color: grey,
                            ),
                          ),
                          onChanged: (text) {
                            i.nameCore = text;
                          },
                          style:const TextStyle(
                            fontSize: 14,
                            color: black,)
                      )
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Chu kỳ bảo trì',style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12,color: Colors.black),),
                  Row(
                    children: const [
                      Text('03 tháng',style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12,color: Colors.black),),
                      SizedBox(width: 5,),
                      Icon(Icons.arrow_drop_down,color: Colors.grey,),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Ngày thay gần nhất',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12,color: Colors.black),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('****/**/**',style: TextStyle(color: Colors.black,fontSize: 12),),
                          Icon(Icons.calendar_today,color: Colors.grey,size: 18,),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const Divider(thickness: 2,)
            ],
          ),
          const SizedBox(height: 16,),
          InkWell(
              onTap: (){
                TextEditingController textController = TextEditingController();
                DataCoreWater item = DataCoreWater(

                    nameCore:'',
                    maintenanceCycle: '',
                    latestChange: ''
                );
                _bloc.add(AddOrRemoveCoreWater(type: true,item: item));
              },
              child: const SizedBox(
                  height: 30,width: 40,
                  child: Icon(MdiIcons.plusCircleOutline,color: Colors.grey,))),
        ],
      ),
    );
  }

  Widget deviceAt(){
    return Padding(
      padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Thiết bị phụ',style: TextStyle(color: mainColor,fontWeight: FontWeight.bold),)),
          const SizedBox(height: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tên thiết bị phụ',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12,color: Colors.black),
                    ),
                    const SizedBox(height: 5,),
                    Container(
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: grey, width: 1),
                              ),
                              contentPadding: const EdgeInsets.only(top: 16,bottom: 10,left: 10),
                              isDense: true,
                              focusColor: primaryColor,
                              hintText: 'Tên thiết bị phụ',
                              hintStyle: const TextStyle(
                                fontSize: 12,
                                color: grey,
                              ),
                            ),
                            onChanged: (text) {
                              nameAt = text;
                            },
                            style:const TextStyle(
                              fontSize: 14,
                              color: black,)
                        )
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Chu kỳ bảo trì',style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12,color: Colors.black),),
                  Row(
                    children: const [
                      Text('03 tháng',style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12,color: Colors.black),),
                      SizedBox(width: 5,),
                      Icon(Icons.arrow_drop_down,color: Colors.grey,),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Ngày thay gần nhất',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12,color: Colors.black),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('****/**/**',style: TextStyle(color: Colors.black,fontSize: 12),),
                          Icon(Icons.calendar_today,color: Colors.grey,size: 18,),
                        ],
                      ),
                    ),
                  )
                ],
              ),
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

  selectCamera () {
    showDemoActionSheet(
      context: context,
      child: CupertinoActionSheet(
          title: const Text('Select Camera'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: const Text('Camera'),
              onPressed: () {
                Navigator.pop(context, 'Camera');
                cameraImage();
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Photo Library'),
              onPressed: () {
                Navigator.pop(context, 'Photo Library');
                getImageLibrary();
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancel'),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
          )
      ),
    );
  }

  void showDemoActionSheet({required BuildContext context, required Widget child}) {
    showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) => child,
    ).then((String? value) {
      if(value !=null ){
        setState(() {
          lastSelectedValue = value;
        });
      }
    });
  }

  Future getImageLibrary() async {
    var gallery = await _picker.pickImage(source: ImageSource.gallery,maxWidth: 700);
    setState(() {
      _image = gallery;
    });
  }

  Future cameraImage() async {
    var image = await _picker.pickImage(source: ImageSource.camera,maxWidth: 700);
    setState(() {
      _image = image;
    });
  }
}
