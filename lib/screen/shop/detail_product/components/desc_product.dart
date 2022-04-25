import 'package:flutter/material.dart';

class DESCProductScreen extends StatefulWidget {
  const DESCProductScreen({Key? key}) : super(key: key);

  @override
  _DESCProductScreenState createState() => _DESCProductScreenState();
}

class _DESCProductScreenState extends State<DESCProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16,top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bộ lõi lọc thô EuroAqua C kích thước chuẩn 10 inch với khe hởi 5 micro được '
                  'ứng dụng thay thế trong các bộ lọc thô đầu nguồn, lõi lọc số 1 - số 3 của máy lọc RO gia đình.',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 20,),
            Text('Phần này yêu cầu hiển thị HTML'),
          ],
        ),
      ),
    );
  }
}
