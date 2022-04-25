import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maw/screen/home/update_history/update_history_bloc.dart';
import 'package:maw/screen/home/update_history/update_history_state.dart';
import 'package:maw/screen/notification/notification_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../themes/colors.dart';
import '../../../widgets/text_field_widget3.dart';

class UpdateHistoryDeviceScreen extends StatefulWidget {
  const UpdateHistoryDeviceScreen({Key? key}) : super(key: key);

  @override
  _UpdateHistoryDeviceScreenState createState() => _UpdateHistoryDeviceScreenState();
}

class _UpdateHistoryDeviceScreenState extends State<UpdateHistoryDeviceScreen>{

  late UpdateHistoryDeviceBloc _bloc;
  TextEditingController contentController = TextEditingController();

  FocusNode focusNodeContent = FocusNode();
  final ImagePicker _picker = ImagePicker();
  // ignore: prefer_typing_uninitialized_variables
  var _image;
  late String lastSelectedValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = UpdateHistoryDeviceBloc();
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
    return BlocListener<UpdateHistoryDeviceBloc,UpdateHistoryDeviceState>(
      listener: (context,state){

      },
      bloc: _bloc,
      child: BlocBuilder<UpdateHistoryDeviceBloc,UpdateHistoryDeviceState>(
        bloc: _bloc,
        builder: (BuildContext context,UpdateHistoryDeviceState state){
          return buildPage(context,state);
        },
      ),
    );
  }


  Widget buildPage(BuildContext context,UpdateHistoryDeviceState state){
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
                          Expanded(child: Text('Cập nhật lịch sử',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,)),
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
                    child: InkWell(
                        onTap: ()=> pushNewScreen(context, screen: const NotificationScreen()),
                        child: Icon(Icons.notifications,color: mainColor,)),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 2,),
            Expanded(child: buildBody(height)),
          ],
        ),
      ),
    );
  }

  Widget buildBody(double height){
    return Padding(
      padding: EdgeInsets.only(bottom: height * .1,top: 20,left: 16,right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Máy lọc nước Kangen K8',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          const SizedBox(height: 20,),
          TextFieldWidgetInput(
            onChanged: (String? newValue) {  },
            labelText: 'Nội dung', focusNode: focusNodeContent,
            onSubmitted: (String? newValue) {  },
            controller: contentController,
            readOnly: false, inputFormatters: const [],
          ),
          const SizedBox(height: 16,),
          TextFieldWidgetInput(
            onChanged: (String? newValue) {  },
            labelText: 'Người bảo trì', focusNode: focusNodeContent,
            onSubmitted: (String? newValue) {  },
            controller: contentController,
            readOnly: false, inputFormatters: const [],
          ),
          const SizedBox(height: 30,),
          const Text('Cập nhật hình ảnh',style: TextStyle(color: Colors.black,),),
          const SizedBox(height: 20,),
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
          const SizedBox(height: 20,),
          TextFieldWidgetInput(
            onChanged: (String? newValue) {  },
            labelText: 'Người thực hiện', focusNode: focusNodeContent,
            onSubmitted: (String? newValue) {  },
            controller: contentController,
            readOnly: false, inputFormatters: const [],
          ),
          const SizedBox(height: 16,),
          TextFieldWidgetInput(
            onChanged: (String? newValue) {  },
            labelText: 'Ghi chú', focusNode: focusNodeContent,
            onSubmitted: (String? newValue) {  },
            controller: contentController,
            readOnly: false, inputFormatters: const [],
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
            'Cập nhật',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
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
}
