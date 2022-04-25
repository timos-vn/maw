import 'package:flutter/material.dart';
import 'package:maw/screen/point/component/schedule_zoom.dart';
import 'package:maw/utils/utils.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../utils/const.dart';
import '../../../widgets/custom_appbar.dart';

class PartnerCenterScreen extends StatefulWidget {
  const PartnerCenterScreen({Key? key}) : super(key: key);

  @override
  _PartnerCenterScreenState createState() => _PartnerCenterScreenState();
}

class _PartnerCenterScreenState extends State<PartnerCenterScreen> {


  String content = 'Sử dụng máy lọc nước Karofi đúng cách và để tăng hiệu '
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
      'ngoài.''-Trường hợp cả nhà đi vắng nên rút nguồn điện cộng với'
      'khóa đầu hệ thống lọc nước giúp cho sản phẩm có được'
      'tuổi thọ lâu dài hơn.'
      '-Cần thường xuyên theo dõi cũng như kiểm tra xem thử'
      'lõi lọc có còn đang hoạt động tốt hay không.'
      '-Chú ý trong việc lắp đặt máy lọc Karofi tại những nơi cân'
      'bằng và cần tránh sự tác động của những yếu tố bên'
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
      'ngoài.''-Trường hợp cả nhà đi vắng nên rút nguồn điện cộng với'
      'khóa đầu hệ thống lọc nước giúp cho sản phẩm có được'
      'tuổi thọ lâu dài hơn.'
      '-Cần thường xuyên theo dõi cũng như kiểm tra xem thử'
      'lõi lọc có còn đang hoạt động tốt hay không.'
      '-Chú ý trong việc lắp đặt máy lọc Karofi tại những nơi cân'
      'bằng và cần tránh sự tác động của những yếu tố bên'
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
      'ngoài.''-Trường hợp cả nhà đi vắng nên rút nguồn điện cộng với'
      'khóa đầu hệ thống lọc nước giúp cho sản phẩm có được'
      'tuổi thọ lâu dài hơn.'
      '-Cần thường xuyên theo dõi cũng như kiểm tra xem thử'
      'lõi lọc có còn đang hoạt động tốt hay không.'
      '-Chú ý trong việc lắp đặt máy lọc Karofi tại những nơi cân'
      'bằng và cần tránh sự tác động của những yếu tố bên'
      'ngoài.''-Trường hợp cả nhà đi vắng nên rút nguồn điện cộng với'
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
      'hơn.';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: height * .05,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            appBar('Trung tâm đối tác',context),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.blueGrey.withOpacity(0.5),
              ),
            ),
            Expanded(child: buildBody(height)),
          ],
        ),
      ),
    );
  }

  buildBody(double height) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: Const.kDefaultPadding * 0.35,),
          menuItem('Kỹ năng Marketing',()=>Utils.showModalBottom(context,'Kỹ năng Marketing',content)),
          menuItem('Kỹ năng tư vấn',()=>Utils.showModalBottom(context,'Kỹ năng tư vấn',content)),
          menuItem('Kịch bản bán hàng cụ thể',()=>Utils.showModalBottom(context,'Kịch bản bán hàng cụ thể',content)),
          menuItem('Hướng dẫn bán hàng với app',()=>Utils.showModalBottom(context,'Hướng dẫn bán hàng với app',content)),
          menuItem('Chiến dịch HOT',()=>Utils.showModalBottom(context,'Chiến dịch HOT',content)),
          menuItem('Đặt lịch zoom 1:1',()=>pushNewScreen(context, screen: const ScheduleZoomScreen(title: 'Đặt lịch zoom 1:1',),withNavBar: false)),
          menuItem('Bản tin đối tác',()=>Utils.showModalBottom(context,'Bản tin đối tác',content)),
          menuItem('Ticket',()=>null),
        ],
      ),
    );
  }

  Widget menuItem(String title,VoidCallback onTap){
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10,left: 16,bottom: 10,right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                const Icon(Icons.navigate_next,color: Colors.black,),
              ],
            ),
          ),
          Divider(color: Colors.grey.withOpacity(0.3),thickness: 3,)
        ],
      ),
    );
  }
}
