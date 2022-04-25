import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:maw/themes/colors.dart';

class QuantityWidget extends StatefulWidget {

  final int initQuantity;
  final ValueChanged<int> valueChanged;

  const QuantityWidget({Key? key, required this.initQuantity, required this.valueChanged}) : super(key: key);

  @override
  _QuantityWidgetState createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {

late int _quantity;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _quantity = widget.initQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap:  _quantity <= 1 ? null : () {
            setState(() {
              _quantity --;
            });
            widget.valueChanged(_quantity);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Icon(
              MdiIcons.minusCircle,
              color: _quantity > 1 ? mainColor : blackBlur,
            ),
          ),
        ),
        Text(
          _quantity.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 12, color: black, fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: () {
            setState(() {
              _quantity ++;
            });
            widget.valueChanged(_quantity);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Icon(
              MdiIcons.plusCircle,
              color: mainColor,
            ),
          ),
        ),
      ],
    );
  }
}