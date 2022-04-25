import 'package:flutter/material.dart';
import 'package:maw/screen/message/message.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../../themes/colors.dart';


class DoingScreen extends StatefulWidget {
  const DoingScreen({Key? key}) : super(key: key);

  @override
  _DoingScreenState createState() => _DoingScreenState();
}

class _DoingScreenState extends State<DoingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 6),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 15,right: 16,left: 16,bottom: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Nguyễn Văn A',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black),),
                  Text('Ngày giới thiệu: 20/08/2021',style: TextStyle(color: Colors.grey,fontSize: 11),),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                children: const [
                  Icon(Icons.phone,color: Colors.grey,size: 16,),
                  SizedBox(width: 5,),
                  Text('0963 004 959',style: TextStyle(color: Colors.grey,fontSize: 12),),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                children: const [
                  Text('Tên sản phẩm: ',style: TextStyle(color: Colors.grey,fontSize: 12),),
                  SizedBox(width: 5,),
                  Text('Ô mô ma tic',style: TextStyle(color: Colors.black,fontSize: 12),),
                ],
              ),
              const Divider(color: Colors.grey,),
              Text('Chiến dịch: Giới thiệu tải app nhận thưởng',style: TextStyle(color: mainColor,fontSize: 12),),
              const SizedBox(height: 5,),
              GestureDetector(
                onTap: (){
                  // Utils.showModalBottom(context,'Hướng dẫn sử dụng',
                  //     'Sử dụng máy lọc nước Karofi đúng cách và để tăng hiệu '
                  //         'quả cũng như tuổi thọ sản phẩm chúng ta hãy lưu ý một'
                  //         'số những yếu tố quan trọng đó chính là:'
                  //         '-Không được lắp đầu vòi sản phẩm máy lọc nước vào với'
                  //         'nguồn nóng.'
                  //         '-Không nên làm đóng băng hệ thống sản phẩm lọc nước.'
                  //         '-Khi sử dụng thì không được nút chặt lỗ nước thải bởi nếu'
                  //         'như vậy nó sẽ làm cho những lõi lọc bên trong hệ thống'
                  //         'lọc bị hư hỏng.'
                  //         '-Trước khi bắt đầu sử dụng máy lọc nước mới nên để sản'
                  //         'phẩm chạy liên tục trong thời gian khoảng 3 giờ đồng hồ'
                  //         'mục đích kiểm tra xem máy chạy ra sao và nguồn nước lọc'
                  //         'ra có đảm bảo sạch và tinh khiết hay không.'
                  //         '-Trường hợp cả nhà đi vắng nên rút nguồn điện cộng với'
                  //         'khóa đầu hệ thống lọc nước giúp cho sản phẩm có được'
                  //         'tuổi thọ lâu dài hơn.'
                  //         '-Cần thường xuyên theo dõi cũng như kiểm tra xem thử'
                  //         'lõi lọc có còn đang hoạt động tốt hay không.'
                  //         '-Chú ý trong việc lắp đặt máy lọc Karofi tại những nơi cân'
                  //         'bằng và cần tránh sự tác động của những yếu tố bên'
                  //         'ngoài.'
                  //         '-Cuối cùng nếu như trong quá trình sử dụng máy lọc nước'
                  //         'Karofi mà chúng ta thấy sản phẩm gặp sự cố thì nên tắt'
                  //         'nguồn điện và tháo đường dẫn nước. Lưu ý là bạn không'
                  //         'nên tự ý sửa chữa mà tốt hơn hết là nên liên lạc cùng nhân'
                  //         'viên kỹ thuật để được tư vấn và sửa chữa kịp thời chính xác.'
                  //         'ránh trường hợp chúng ta làm cho lỗi càng trở nên nặng'
                  //         'hơn.');
                  pushNewScreen(context, screen: const MessagesScreen(),withNavBar: false);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Sale phụ trách: HML',style: TextStyle(color: Colors.grey,fontSize: 12),),
                    Icon(Icons.message,color: Colors.blueGrey,size: 20,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
