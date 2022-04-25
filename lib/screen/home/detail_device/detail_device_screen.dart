import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:maw/screen/history/history_report_screen.dart';
import 'package:maw/screen/home/detail_device/test.dart';
import 'package:maw/screen/home/history_device/history_device_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../../themes/colors.dart';
import '../../../utils/utils.dart';
import 'detail_device_bloc.dart';
import 'detail_device_event.dart';
import 'detail_device_state.dart';

class DetailDeviceScreen extends StatefulWidget {
  const DetailDeviceScreen({Key? key}) : super(key: key);

  @override
  _DetailDeviceScreenState createState() => _DetailDeviceScreenState();
}

class _DetailDeviceScreenState extends State<DetailDeviceScreen> with TickerProviderStateMixin{

  late DetailDeviceBloc _bloc;
  late TabController tabController;
  List<String> listProduct = [
    "https://hc.com.vn/i/ecommerce/media/00033736_FEATURE_40133.jpg",
    "https://fpt123.net/uploads/images/may-loc-nuoc/karofi-e239.png",
    "https://hc.com.vn/i/ecommerce/media/GD.000340_FEATURE_43864.jpg"
  ];
  List<String> choices = <String>[
    "Lịch sử báo cáo",
    "Đặt lại thiết bị",
    "Chính sách bảo hành"
  ];
  String dropdownValue ="Lịch sử báo cáo";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = DetailDeviceBloc();
    tabController = TabController(vsync:this,length:2);
  }

  void _select(String choice) {
    if(choice == 'Lịch sử báo cáo'){
      pushNewScreen(context, screen: const HistoryReportScreen(),withNavBar: false);
      //String dataType = "1";
      // dataType = '1';
      // _bloc.add(GetListOrderEvent(_dateForm.toString(),_dateTo.toString(),dataType));
    }else if(choice == 'Đặt lại thiết bị'){
      // dataType = '2';
      // _bloc.add(GetListOrderEvent(_dateForm.toString(),_dateTo.toString(),dataType));
    }else{

    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailDeviceBloc,DetailDeviceState>(
      listener: (context,state){

      },
      bloc: _bloc,
      child: BlocBuilder<DetailDeviceBloc,DetailDeviceState>(
        bloc: _bloc,
        builder: (BuildContext context,DetailDeviceState state){
          return buildPage(context,state);
        },
      ),
    );
  }


  Widget buildPage(BuildContext context,DetailDeviceState state){
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: mainColor,
      body: Container(
        padding: EdgeInsets.only(top: height * .05,bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16,right: 10,bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: ()=> Navigator.pop(context),
                    child: const SizedBox(
                        height:20,
                        width: 20,
                        child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 20,)),
                  ),
                  InkWell(
                      onTap: (){
                        showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.red,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
                            ),
                            isScrollControlled: true,
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0,left: 16,right: 16),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Icon(Icons.check,color: Colors.white,),
                                          const Text('Chi tiết phiếu',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800),),
                                          InkWell(
                                              onTap: ()=> Navigator.pop(context),
                                              child: const Icon(Icons.close,color: Colors.black,)),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8,),
                                    const Divider(color: Colors.blueGrey,),
                                    const SizedBox(height: 8,),

                                    const SizedBox(height: 15,),
                                    SizedBox(
                                      height: 250,
                                      width: double.infinity,
                                      child: CachedNetworkImage(
                                        imageUrl: 'https://i.pinimg.com/564x/5e/93/14/5e9314a0f83f3f48e5d5fde1a77d3519.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Icon(Icons.help,color: mainColor,)),
                  const Text('Chi tiết thiết bị',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis,),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 0),
                        child: InkWell(
                            onTap: (){
                                Utils.showModalBottom(context,'Hướng dẫn sử dụng',
                              'Sử dụng máy lọc nước Karofi đúng cách và để tăng hiệu '
                              'quả cũng như tuổi thọ sản phẩm chúng ta hãy lưu ý một'
                              'số những yếu tố quan trọng đó chính là:'
                              '-Không được lắp đầu vòi sản phẩm máy lọc nước vào với'
                              'nguồn nóng.'
                              '-Không nên làm đóng băng hệ thống sản phẩm lọc nước.'
                              '-Khi sử dụng thì không được nút chặt lỗ nước thải bởi nếu'
                              'như vậy nó sẽ làm cho những lõi lọc bên trong hệ thống'
                              'lọc bị hư hỏng.'
                              '-Trước khi bắt đầu sử dụng máy lọc nước mới nên để sản'
                              'phẩm chạy liên tục trong thời gian khoảng 3 giờ đồng hồ'
                              'mục đích kiểm tra xem máy chạy ra sao và nguồn nước lọc'
                              'ra có đảm bảo sạch và tinh khiết hay không.'
                              '-Trường hợp cả nhà đi vắng nên rút nguồn điện cộng với'
                              'khóa đầu hệ thống lọc nước giúp cho sản phẩm có được'
                              'tuổi thọ lâu dài hơn.'
                              '-Cần thường xuyên theo dõi cũng như kiểm tra xem thử'
                              'lõi lọc có còn đang hoạt động tốt hay không.'
                              '-Chú ý trong việc lắp đặt máy lọc Karofi tại những nơi cân'
                              'bằng và cần tránh sự tác động của những yếu tố bên'
                              'ngoài.'
                              '-Cuối cùng nếu như trong quá trình sử dụng máy lọc nước'
                              'Karofi mà chúng ta thấy sản phẩm gặp sự cố thì nên tắt'
                              'nguồn điện và tháo đường dẫn nước. Lưu ý là bạn không'
                              'nên tự ý sửa chữa mà tốt hơn hết là nên liên lạc cùng nhân'
                              'viên kỹ thuật để được tư vấn và sửa chữa kịp thời chính xác.'
                              'ránh trường hợp chúng ta làm cho lỗi càng trở nên nặng'
                              'hơn.');
                            },
                            child: const Icon(Icons.help,color: Colors.white,)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 0),
                        child: SizedBox(
                          width: 25,
                          child: PopupMenuButton(
                            icon: const Icon(MdiIcons.alertCircleOutline),
                            onSelected: _select,
                            shape: const TooltipShape(),
                            padding: EdgeInsets.zero,
                            offset: const Offset(20, 45),
                            itemBuilder: (BuildContext context) {
                              return choices.map((String choice) {
                                return  PopupMenuItem<String>(
                                  height: 10,
                                  padding: const EdgeInsets.only(left: 5,top: 5),
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
                  )
                ],
              ),
            ),
            SizedBox(
              height: 95,
                child: Image.asset("assets/images/product.png",fit: BoxFit.contain)),
            Expanded(child: buildBody(height)),
          ],
        ),
      ),
    );
  }

  Widget buildBody(double height){
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14)
        )
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: height * .1,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 1,width: double.infinity,color: Colors.blueGrey.withOpacity(0.5),),
              Container(
                  padding: const EdgeInsets.only(top: 16,left: 16,right: 16,bottom: 20),
                  width: double.infinity,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Expanded(child: Text('Bộ 3 lõi lọc 123 RO EuroAqua C Made in Russia',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),)),
                          SizedBox(width: 50,),
                          Text('ID: 1234abc',style: TextStyle(color: Colors.black,fontSize: 12),),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: buildInfoDevice('Tên khác:','Máy Ion Kiềm')),
                          const Text('Seri: KH-001',style: TextStyle(color: Colors.black,fontSize: 12),),
                        ],
                      ),
                      buildInfoDevice('Chức năng:','Lọc nước'),
                      buildInfoDevice('Ngày mua:','17/03/2022 | 10:17'),
                      buildInfoDevice('Thời gian bảo hành còn lại:','12 tháng'),
                      buildInfoDevice('Ví trí lắp đặt:','Tầng 2'),
                    ],
                  )),
              Container(height: 3,width: double.infinity,color: Colors.blueGrey.withOpacity(0.2),),
              buildDetail(),
              Container(height: 3,width: double.infinity,color: Colors.blueGrey.withOpacity(0.2),),
              const Padding(
                padding: EdgeInsets.only(left: 16,top: 10),
                child: Text('Thiết bị phụ',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              ),
              buildDeviceOther(),
              Container(height: 3,width: double.infinity,color: Colors.blueGrey.withOpacity(0.2),),
              const Padding(
                padding: EdgeInsets.only(left: 16,top: 10),
                child: Text('Tuỳ chọn',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16,right: 16,top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildOptions('Kích hoạt bảo hành',MdiIcons.shieldOutline,true),
                    buildOptions('Kết nối \nwifi',Icons.wifi,false),
                    buildOptions('Lùi lịch bảo trì',MdiIcons.history,false),
                    buildOptions('Thay đổi chủ sở hữu',MdiIcons.accountSwitchOutline,false),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16,top: 10,bottom: 16),
                child: buildOptions('Báo cáo sự cố',MdiIcons.alertOctagonOutline,false),
              ),
              Container(height: 3,width: double.infinity,color: Colors.blueGrey.withOpacity(0.2),),
              Padding(
                padding: const EdgeInsets.all(16),
                child: InkWell(
                  onTap:()=>pushNewScreen(context, screen: const HistoryDeviceScreen(),withNavBar: false),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Lịch sử thiết bị',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      Icon(Icons.navigate_next,color: Colors.blueGrey,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoDevice(String title, String content){
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Text(title,style: const TextStyle(color: Colors.blueGrey,fontSize: 12),),
          const SizedBox(width: 5,),
          Text(content,style: const TextStyle(color: Colors.black,fontSize: 12),),
        ],
      ),
    );
  }

  Widget buildDetail(){
    return Padding(
      padding: const EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Lõi (3)',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              Container(
                height: 30,
                padding: const EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: subColor
                ),
                child: const Center(
                  child: Text('Bảo trì ngay',style: TextStyle(color: Colors.white,fontSize: 12),),
                ),
              )
            ],
          ),
          ListView.builder(
              padding: const EdgeInsets.only(top: 10,left: 0,right: 0,bottom: 16),
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context,index) =>
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      shadowColor: Colors.blueGrey,
                      elevation: 4,
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 10),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6), // Image border
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(27), // Image radius
                                child: CachedNetworkImage(
                                  imageUrl: 'https://i.pinimg.com/564x/5e/93/14/5e9314a0f83f3f48e5d5fde1a77d3519.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 15,),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Expanded(child: Text('Ten/ma sp',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black),)),
                                      const SizedBox(height: 5,),
                                      Icon(Icons.refresh,color: subColor,),
                                    ],
                                  ),
                                  const SizedBox(height: 8,),
                                  Container(
                                    width: double.infinity,
                                    height: 14,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24)
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                    child: LiquidLinearProgressIndicator(
                                      borderRadius: 12.0,
                                      backgroundColor: Colors.white,
                                      valueColor: const AlwaysStoppedAnimation(Colors.blue),
                                      center: const Text(
                                        "Loading...",
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
          ),
          const Text('Điện cực',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          ListView.builder(
              padding: const EdgeInsets.only(top: 10,left: 0,right: 0,bottom: 16),
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context,index) =>
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      shadowColor: Colors.blueGrey,
                      elevation: 4,
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 10),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6), // Image border
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(27), // Image radius
                                child: CachedNetworkImage(
                                  imageUrl: 'https://i.pinimg.com/564x/5e/93/14/5e9314a0f83f3f48e5d5fde1a77d3519.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 15,),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Expanded(child: Text('Điện cực',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black),)),
                                      const SizedBox(height: 5,),
                                      Icon(Icons.refresh,color: subColor,),
                                    ],
                                  ),
                                  const SizedBox(height: 8,),
                                  Container(
                                    width: double.infinity,
                                    height: 14,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24)
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                    child: LiquidLinearProgressIndicator(
                                      borderRadius: 12.0,
                                      backgroundColor: Colors.white,
                                      valueColor: AlwaysStoppedAnimation(mainColor),
                                      center: const Text(
                                        "Loading...",
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
          ),
          const Text('Muối',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: LiquidCircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: const AlwaysStoppedAnimation(Colors.blueGrey),
                borderColor: mainColor,
                borderWidth: 1.0,
                center: const Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Lượng nước',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                Row(
                  children: const [
                    Text('Tháng này',style: TextStyle(color: Colors.blueGrey,fontSize: 12),),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_drop_down_outlined,color: Colors.blueGrey,)
                  ],
                )
              ],
            ),
          ),
          WaveWidget(
            config: CustomConfig(
              gradients: [
                [Colors.blue.withOpacity(0.2), Colors.blue.withOpacity(0.2)],
                [Colors.blue, Colors.blue.withOpacity(0.2)],
                [Colors.blue.withOpacity(0.2), Colors.blue],
                [Colors.blue.withOpacity(0.2), Colors.blue.withOpacity(0.2)]
              ],
              durations: [35000, 19440, 10800, 6000],
              heightPercentages: [0.20, 0.23, 0.25, 0.30],
              blur: const MaskFilter.blur(BlurStyle.solid, 1),
              gradientBegin: Alignment.bottomLeft,
              gradientEnd: Alignment.topRight,
            ),
            // colors: [
            //   Colors.white70,
            //   Colors.white54,
            //   Colors.white30,
            //   Colors.white24,
            // ],
            duration: 6000,
            waveAmplitude: 0,
            heightPercentange: 0.2,
            // backgroundImage: DecorationImage(
            //   image: NetworkImage(
            //     'https://images.unsplash.com/photo-1600107363560-a2a891080c31?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=672&q=80',
            //   ),
            //   fit: BoxFit.cover,
            //   colorFilter:
            //   ColorFilter.mode(Colors.white, BlendMode.softLight),
            // ),
            size: const Size(
              double.infinity,
              60,
            ),
          ),
        ],
      ),
    );
  }

  Padding buildDeviceOther(){
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6), // Image border
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(40), // Image radius
                  child: CachedNetworkImage(
                    imageUrl: 'https://i.pinimg.com/564x/5e/93/14/5e9314a0f83f3f48e5d5fde1a77d3519.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Text('Bộ tiền lọc Ecutor',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            const SizedBox(height: 5,),
            const Text('Chức năng: Tiền lọc',style: TextStyle(color: Colors.black,fontSize: 11),),
            const SizedBox(height: 5,),
            const Text('Tình trạng: Đang hoạt động',style: TextStyle(color: Colors.blue,fontSize: 11),),
            const SizedBox(height: 5,),
            ListView.builder(
                padding: const EdgeInsets.only(top: 10,left: 16,right: 16,bottom: 16),
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context,index) =>
                    Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Card(
                        shadowColor: Colors.blueGrey,
                        elevation: 4,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 10),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6), // Image border
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(27), // Image radius
                                  child: CachedNetworkImage(
                                    imageUrl: 'https://i.pinimg.com/564x/5e/93/14/5e9314a0f83f3f48e5d5fde1a77d3519.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15,),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(child: Text('Tên lõi/mã lõi $index',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black),)),
                                        const SizedBox(height: 5,),
                                        Icon(Icons.refresh,color: subColor,),
                                      ],
                                    ),
                                    const SizedBox(height: 8,),
                                    Container(
                                      width: double.infinity,
                                      height: 14,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(24)
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                      child: LiquidLinearProgressIndicator(
                                        borderRadius: 12.0,
                                        backgroundColor: Colors.white,
                                        valueColor: const AlwaysStoppedAnimation(Colors.blue),
                                        center: const Text(
                                          "Loading...",
                                          style: TextStyle(
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOptions(String title,IconData icons, bool stacked){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 50,width: 50,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: mainColor
          ),
          child: Center(
            child: Stack(
              children: [
                Icon(icons,size: 25,color: Colors.white,),
                Visibility(
                  visible:  stacked == true,
                  child: const Positioned(
                    top: 0,right: 0,bottom: 0,left: 0,
                    child: Icon(Icons.check,color: Colors.white,size: 15,),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 10,),
        SizedBox(width: 70,child: Text(title,style: const TextStyle(fontSize: 11,),textAlign: TextAlign.center,)),
      ],
    );
  }
}
