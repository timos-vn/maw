import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:maw/screen/map/expert_lib/expert_lib_bloc.dart';
import 'package:maw/screen/map/expert_lib/expert_lib_state.dart';

import '../../../themes/colors.dart';
import '../../home/detail_device/test.dart';

class CreateQuestionScreen extends StatefulWidget {
  const CreateQuestionScreen({Key? key}) : super(key: key);

  @override
  _CreateQuestionScreenState createState() => _CreateQuestionScreenState();
}

class _CreateQuestionScreenState extends State<CreateQuestionScreen>{

  late ExpertLibBloc _bloc;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  FocusNode titleFocusNode = FocusNode();
  FocusNode contentFocusNode = FocusNode();

  final ImagePicker _picker = ImagePicker();
  // ignore: prefer_typing_uninitialized_variables
  var _image;
  late String lastSelectedValue;

  List<String> choices = <String>[
    "Hiện thị với admin",
    "Hiện thị với mọi người",
  ];


  void _select(String choice) {
    if(choice == 'Hiện thị với admin'){
      //String dataType = "1";
      // dataType = '1';
      // _bloc.add(GetListOrderEvent(_dateForm.toString(),_dateTo.toString(),dataType));
    }else if(choice == 'Hiện thị với mọi người'){
      // dataType = '2';
      // _bloc.add(GetListOrderEvent(_dateForm.toString(),_dateTo.toString(),dataType));
    }else{

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = ExpertLibBloc();
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpertLibBloc,ExpertLibState>(
      listener: (context,state){

      },
      bloc: _bloc,
      child: BlocBuilder<ExpertLibBloc,ExpertLibState>(
        bloc: _bloc,
        builder: (BuildContext context,ExpertLibState state){
          return buildPage(context,state);
        },
      ),
    );
  }


  Widget buildPage(BuildContext context,ExpertLibState state){
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
              padding: const EdgeInsets.only(left: 16,right: 10,bottom: 10),
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
                          Expanded(child: Text('Tạo câu hỏi',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 16),
                    child: SizedBox(
                      width: 25,
                      child: PopupMenuButton(
                        icon: Icon(MdiIcons.accountMultipleOutline,color: mainColor,),
                        onSelected: _select,
                        shape: const TooltipShape(),
                        padding: EdgeInsets.zero,
                        offset: const Offset(5, 45),
                        itemBuilder: (BuildContext context) {
                          return choices.map((String choice) {
                            return  PopupMenuItem<String>(
                              height: 10,
                              padding: const EdgeInsets.only(left: 10,top: 5,right: 10),
                              value: choice,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(choice,style: const TextStyle(fontSize: 12),),
                                  const Divider()
                                ],
                              ),
                            );}
                          ).toList();
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Divider(thickness: 2,),
            Expanded(child: SingleChildScrollView(child: buildBody(height))),
          ],
        ),
      ),
    );
  }

  Widget buildBody(double height){
    return Padding(
      padding: EdgeInsets.only(bottom: height * .1,top: 10,left: 16,right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Chủ đề',style: TextStyle(color: Colors.black),),
          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 20),
            child: DottedBorder(
              dashPattern: const [5, 3],
              color: Colors.grey,
              borderType: BorderType.RRect,
              radius: const Radius.circular(6),
              padding: const EdgeInsets.only(left: 12,right: 12),
              child: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(titleFocusNode),
                child: Container(
                  height: 40,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Hãy lựa chọn chủ đề',style: TextStyle(color: Colors.grey,fontSize: 12),),
                      Icon(Icons.arrow_drop_down,color: Colors.black,)
                    ],
                  ),
                ),
              ),
            ),
          ),
          buildInputTitle(),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Nội dung',style: TextStyle(color: Colors.black),),
              InkWell(
                onTap: ()=> selectCamera(),
                child: const SizedBox(
                    width: 45,
                    child: Icon(MdiIcons.camera,color: Colors.grey,size: 22,)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 20),
            child: DottedBorder(
              dashPattern: const [5, 3],
              color: Colors.grey,
              borderType: BorderType.RRect,
              radius: const Radius.circular(6),
              padding: const EdgeInsets.only(left: 12,right: 12),
              child: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(contentFocusNode),
                child: Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: TextField(
                    maxLines: 5,
                    // obscureText: true,
                    controller: contentController,
                    decoration:const  InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(7),
                      hintText: '',
                      hintStyle: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                    ),
                    // focusNode: focusNodeContent,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 14),
                    //textInputAction: TextInputAction.none,
                  ),
                ),
              ),
            ),
          ),
          const Text('Bộ phận tiếp nhận',style: TextStyle(color: Colors.black),),
          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 16),
            child: DottedBorder(
              dashPattern: const [5, 3],
              color: Colors.grey,
              borderType: BorderType.RRect,
              radius: const Radius.circular(6),
              padding: const EdgeInsets.only(left: 12,right: 12),
              child: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(titleFocusNode),
                child: Container(
                  height: 40,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Hãy lựa chọn bộ phân',style: TextStyle(color: Colors.grey,),),
                      Icon(Icons.arrow_drop_down,color: Colors.black,)
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40,),
          _submitButton()
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {

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
            'Gửi',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget buildInputTitle(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text('Tiêu đề',style: TextStyle(color: Colors.black),),
        ),
        DottedBorder(
          dashPattern: const [5, 3],
          color: Colors.grey,
          borderType: BorderType.RRect,
          radius: const Radius.circular(6),
          padding: const EdgeInsets.only(left: 12,right: 12),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(titleFocusNode),
            child: Container(
              height: 40,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: TextField(
                maxLines: 5,
                // obscureText: true,
                controller: titleController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(7),
                  hintText: 'Vui lòng nhập tiêu đề',
                  hintStyle: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey,fontSize: 12),
                ),
                // focusNode: focusNodeContent,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 14),
                //textInputAction: TextInputAction.none,
              ),
            ),
          ),
        ),
      ],
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
}
