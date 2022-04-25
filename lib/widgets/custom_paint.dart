
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CheckCorner extends CustomPainter {
  final double size;
  final Color color;

  CheckCorner({this.size = 20, this.color = Colors.grey});

  @override
  void paint(Canvas canvas, Size _) {
    var shapePainter = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    var shapePath = Path();
    shapePath.moveTo(0, 0);
    shapePath.lineTo(0, size);
    shapePath.lineTo(size, 0);
    shapePath.close();

    var checkPainter = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    canvas.drawPath(shapePath, shapePainter);
    canvas.drawLine(Offset(size * .15, size * .25),
        Offset(size * .3, size * .45), checkPainter);
    canvas.drawLine(Offset(size * .3, size * .45),
        Offset(size * .6, size * .15), checkPainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(140,0);
    path_0.lineTo(140,50);
    path_0.lineTo(0.309,53.37);
    path_0.lineTo(0.309,49.669999999999995);
    path_0.cubicTo(0.386,49.669999999999995,0.45299999999999996,49.669999999999995,0.528,49.669999999999995);
    path_0.cubicTo(3.259,49.669999999999995,5.465,48.84499999999999,5.465,47.82299999999999);
    path_0.cubicTo(5.465,46.800999999999995,3.26,45.98,0.528,45.98);
    path_0.cubicTo(0.452,45.98,0.386,45.98,0.30900000000000005,45.98);
    path_0.lineTo(0.30900000000000005,42.279999999999994);
    path_0.cubicTo(0.38600000000000007,42.279999999999994,0.45300000000000007,42.279999999999994,0.528,42.279999999999994);
    path_0.cubicTo(3.259,42.279999999999994,5.465,41.45499999999999,5.465,40.43299999999999);
    path_0.cubicTo(5.465,39.410999999999994,3.26,38.59,0.528,38.59);
    path_0.cubicTo(0.452,38.59,0.386,38.59,0.30900000000000005,38.59);
    path_0.lineTo(0.30900000000000005,34.89);
    path_0.cubicTo(0.38600000000000007,34.89,0.45300000000000007,34.89,0.528,34.89);
    path_0.cubicTo(3.259,34.89,5.465,34.065,5.465,33.043);
    path_0.cubicTo(5.465,32.021,3.26,31.2,0.528,31.2);
    path_0.cubicTo(0.452,31.2,0.386,31.2,0.30900000000000005,31.2);
    path_0.lineTo(0.30900000000000005,27.5);
    path_0.cubicTo(0.38600000000000007,27.5,0.45300000000000007,27.5,0.528,27.5);
    path_0.cubicTo(3.259,27.5,5.465,26.675,5.465,25.653);
    path_0.cubicTo(5.465,24.630999999999997,3.26,23.811,0.528,23.811);
    path_0.cubicTo(0.452,23.811,0.386,23.811,0.30900000000000005,23.811);
    path_0.lineTo(0.30900000000000005,20.111);
    path_0.cubicTo(0.38600000000000007,20.111,0.45300000000000007,20.111,0.528,20.111);
    path_0.cubicTo(3.259,20.111,5.465,19.286,5.465,18.264);
    path_0.cubicTo(5.465,17.241999999999997,3.26,16.421,0.528,16.421);
    path_0.cubicTo(0.452,16.421,0.386,16.421,0.30900000000000005,16.421);
    path_0.lineTo(0.30900000000000005,12.721);
    path_0.cubicTo(0.38600000000000007,12.721,0.45300000000000007,12.721,0.528,12.721);
    path_0.cubicTo(3.259,12.721,5.465,11.896,5.465,10.874);
    path_0.cubicTo(5.465,9.852,3.26,9.032,0.528,9.032);
    path_0.cubicTo(0.452,9.032,0.386,9.032,0.30900000000000005,9.032);
    path_0.lineTo(0.30900000000000005,5.332);
    path_0.cubicTo(0.38600000000000007,5.332,0.45300000000000007,5.332,0.528,5.332);
    path_0.cubicTo(3.259,5.332,5.465,4.507,5.465,3.485);
    path_0.cubicTo(5.465,2.463,3.26,1.642,0.528,1.642);
    path_0.cubicTo(0.452,1.642,0.386,1.642,0.30900000000000005,1.642);
    path_0.lineTo(0.30900000000000005,0);
    path_0.close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = Color(0xff0b7640).withOpacity(1.0);
    canvas.drawPath(path_0,paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(-1845.093,3165);
    path_1.lineTo(-1845.093,3218.87);

    Paint paint_1_stroke = Paint()..style=PaintingStyle.stroke..strokeWidth=size.width;
    paint_1_stroke.color=Color(0xffffab1b).withOpacity(1.0);
    canvas.drawPath(path_1,paint_1_stroke);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}



class RPSCustomPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Paint paint_1_stroke = Paint()..style=PaintingStyle.stroke..strokeWidth=size.width*0.003676471;
    paint_1_stroke.color=Color(0xff0b7640).withOpacity(1.0);
    canvas.drawRRect(RRect.fromRectAndCorners(Rect.fromLTWH(size.width*0.001838235,size.height*0.007812500,size.width*0.9963235,size.height*0.9843750),bottomRight: Radius.circular(size.width*0.01286765),bottomLeft:  Radius.circular(size.width*0.01286765),topLeft:  Radius.circular(size.width*0.01286765),topRight:  Radius.circular(size.width*0.01286765)),paint_1_stroke);

    Path path_2 = Path();
    path_2.moveTo(9990,69);
    path_2.lineTo(10003.03,57.437);
    path_2.lineTo(9990,57.437);
    path_2.close();

    Paint paint_2_fill = Paint()..style=PaintingStyle.fill;
    paint_2_fill.color = Color(0xff0b7640).withOpacity(1.0);
    canvas.drawPath(path_2,paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(10.408,9);
    path_3.lineTo(7.378,12.031);
    path_3.lineTo(6,10.653);

    Paint paint_3_stroke = Paint()..style=PaintingStyle.stroke..strokeWidth=size.width*0.007352941;
    paint_3_stroke.color=Color(0xffffffff).withOpacity(1.0);
    paint_3_stroke.strokeCap = StrokeCap.round;
    paint_3_stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_3,paint_3_stroke);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}



class RPSCustomPainter3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(13.5,0);
    path_0.lineTo(17.465,2.857);
    path_0.lineTo(22.311,3.257);
    path_0.lineTo(23.54,8.034);
    path_0.lineTo(27,11.5);
    path_0.lineTo(24.917,15.961);
    path_0.lineTo(25.371000000000002,20.877000000000002);
    path_0.lineTo(20.951,22.935000000000002);
    path_0.lineTo(18.188,27);
    path_0.lineTo(13.5,25.692);
    path_0.lineTo(8.811,27);
    path_0.lineTo(6.048,22.938);
    path_0.lineTo(1.628,20.88);
    path_0.lineTo(2.082,15.963999999999999);
    path_0.lineTo(0,11.5);
    path_0.lineTo(3.46,8.034);
    path_0.lineTo(4.689,3.257);
    path_0.lineTo(9.535,2.857);
    path_0.close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = Color(0xffff0303).withOpacity(1.0);
    canvas.drawPath(path_0,paint_0_fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ProductLikePaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 255, 0, 4)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0381373, size.height * 0.7943000);
    path_0.lineTo(size.width * 0.0381373, size.height * 0.0393000);
    path_0.lineTo(size.width * 0.9557843, size.height * 0.0393000);
    path_0.quadraticBezierTo(size.width * 0.9950784, size.height * 0.0460000,
        size.width * 0.9969608, size.height * 0.1393000);
    path_0.cubicTo(
        size.width * 0.9964706,
        size.height * 0.2780500,
        size.width * 0.9954902,
        size.height * 0.5555500,
        size.width * 0.9950000,
        size.height * 0.6943000);
    path_0.quadraticBezierTo(size.width * 0.9942745, size.height * 0.7736000,
        size.width * 0.9597059, size.height * 0.7793000);

    canvas.drawPath(path_0, paint_0);

    Paint paint_1 = new Paint()
      ..color = Color.fromARGB(255, 175, 17, 20)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.0400000, size.height * 0.7937000);
    path_1.lineTo(size.width * 0.0993333, size.height * 0.9974000);
    path_1.lineTo(size.width * 0.1000392, size.height * 0.7885500);

    canvas.drawPath(path_1, paint_1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CustomChatBubble extends CustomPainter {
  CustomChatBubble({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color ;

    Path paintBubbleTail() {
      late Path path;
      path = Path()
        ..moveTo(5, size.height - 5)
        ..quadraticBezierTo(-5, size.height, -16, size.height - 4)
        ..quadraticBezierTo(-5, size.height - 5, 0, size.height - 17);
      return path;
    }

    final RRect bubbleBody = RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(16));
    final Path bubbleTail = paintBubbleTail();

    canvas.drawRRect(bubbleBody, paint);
    canvas.drawPath(bubbleTail, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}