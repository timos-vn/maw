import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../themes/colors.dart';
import '../expert_lib/expert_lib_bloc.dart';
import '../expert_lib/expert_lib_state.dart';

class DetailPostScreen extends StatefulWidget {
  final bool showComment;
  const DetailPostScreen({Key? key,required this.showComment}) : super(key: key);

  @override
  _DetailPostScreenState createState() => _DetailPostScreenState();
}

class _DetailPostScreenState extends State<DetailPostScreen>{

  late ExpertLibBloc _bloc;

  TextEditingController contentController = TextEditingController();

  FocusNode contentFocusNode = FocusNode();

  final ImagePicker _picker = ImagePicker();
  // ignore: prefer_typing_uninitialized_variables
  var _image;
  late String lastSelectedValue;


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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: ()=> Navigator.pop(context),
                    child: const SizedBox(
                        height:20,
                        width: 30,
                        child: Icon(Icons.arrow_back_ios,color: Colors.black,size: 20,)),
                  ),
                  const Text('Chi tiết',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,),
                  const SizedBox(
                      height:20,
                      width: 30,
                      child: Icon(Icons.offline_share,color: Colors.white30,size: 20,)),
                ],
              ),
            ),
            const Divider(thickness: 2,),
            Expanded(child: SingleChildScrollView(child: buildBody(height))),

            Visibility(
                visible: widget.showComment == true,
                child: _inputContent())
          ],
        ),
      ),
    );
  }

  Widget buildBody(double height){
    return Padding(
      padding: EdgeInsets.only(bottom: height * .1,top: 10,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Center(child: Text('Vì sao phải mua lõi lọc ARAGON máy lọc nước NANO geyser chính hãng'.toUpperCase(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,))),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10,bottom: 30),
                  child: Text('Hiển thị HTML',style: TextStyle(color: Colors.blueGrey,fontSize: 12),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text('Đánh giá & nhận xét',style: TextStyle(color: mainColor,fontWeight: FontWeight.bold),),
                        Container(width: 145,height: 5,decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),color: mainColor),),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.thumb_up_alt_outlined,size: 12,color: Colors.grey,),
                        const SizedBox(width: 4,),
                        Text('1',style: TextStyle(color: subColor,fontSize: 12),),
                        const SizedBox(width: 16,),
                        const Icon(Icons.thumb_down_alt_outlined,size: 12,color: Colors.grey,),
                        const SizedBox(width: 4,),
                        Text('1',style: TextStyle(color: subColor,fontSize: 12),),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(height: 5,width: double.infinity,color: Colors.blueGrey.withOpacity(0.1),),
          ListView.separated(
            padding: const EdgeInsets.only(top: 5,left: 0,right: 0,bottom: 0),
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (context,index) =>
                Container(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(top: 10,right: 16,left: 16,bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Trangggg',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black),),
                            SizedBox(height: 7,),
                            Text('Tôi đã hiểu. xin cảm ơn',style: TextStyle(color: Colors.black,fontSize: 12),),
                            SizedBox(height: 7,),
                            Text('19/04/2022 16:48',style: TextStyle(color: Colors.grey,fontSize: 12),),
                            SizedBox(height: 5,),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
            , separatorBuilder: (BuildContext context, int index) {
            return const Padding(
              padding: EdgeInsets.only(right: 16,left: 16),
              child: Divider(height: 1,),
            );
          },),
        ],
      ),
    );
  }

  Widget _inputContent() {
    return Column(
      children: [
        const Divider(thickness: 1,height: 1,),
        InkWell(
          onTap: () {

          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Row(
                children: [
                  const Icon(MdiIcons.accountCircle,color: Colors.grey,),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide: const BorderSide(color: Colors.transparent, width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: grey, width: 1),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: grey, width: 1),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            filled: true,
                            suffixIcon: const Icon(Icons.camera_enhance,color: Colors.grey,),
                            contentPadding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                            hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5),fontSize: 12),
                            hintText: "Viết bình luận",
                            fillColor: Colors.white70),
                      ),
                    ),
                  )
                ],
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
