import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:maw/themes/colors.dart';

class TextFieldWidgetInput extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const TextFieldWidgetInput(
      {required this.controller,
        this.textInputAction = TextInputAction.next,
        this.isEnable = true,
        required this.onChanged,
        this.isPassword = false,
        required this.inputFormatters,
        required this.labelText,
        this.hintText,
        this.keyboardType = TextInputType.text,
        required this.focusNode,
        required this.onSubmitted,
        this.prefixIcon,
        this.suffix,
        required this.readOnly,
      });

  final TextEditingController controller;
  final bool isEnable;
  final List<TextInputFormatter> inputFormatters;
  final TextInputAction textInputAction;
  final FormFieldSetter<String> onChanged;
  final bool isPassword;
  final String labelText;
  final String? hintText;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final FormFieldSetter<String> onSubmitted;
  final dynamic prefixIcon;
  final dynamic suffix;
  final bool readOnly;

  @override
  _TextFieldWidgetInputState createState() => _TextFieldWidgetInputState();
}

class _TextFieldWidgetInputState extends State<TextFieldWidgetInput> {
  late bool _obscureText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: widget.readOnly ? false : widget.readOnly,
      enabled: widget.isEnable,
      focusNode: widget.focusNode,
      controller: widget.controller,
      obscureText: _obscureText,
      textInputAction: widget.textInputAction,
      textAlignVertical: TextAlignVertical.center,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(24)),
          //   borderSide: BorderSide(
          //     color: Colors.grey,width: 1),
          // ),
          // disabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(24)),
          //   borderSide: BorderSide(width: 1,color: Colors.grey),
          // ),
          // enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(24)),
          //   borderSide: BorderSide(
          //     color: Colors.grey,),
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(24)),
          //   borderSide: BorderSide(
          //     color: Colors.grey, ),
          // ),
          contentPadding: const EdgeInsets.symmetric(vertical: 7,horizontal: 0),
          isDense: true,
          focusColor: primaryColor,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontSize: 13,
            color: Colors.black,
          ),
          labelText: widget.labelText,
          prefixIcon: widget.prefixIcon == null
              ? null
              : (widget.prefixIcon is String
              ? Padding(
            child: Image.asset(
              widget.prefixIcon,
              width: 35,
              height: 35,
              fit: BoxFit.fitHeight,
            ),
            padding: const EdgeInsets.all(12),
          )
              : Icon(
            widget.prefixIcon,
            color: accent,
            size: 20,
          )),
          labelStyle: const TextStyle(color: Colors.black, fontSize: 13),
          errorStyle: const TextStyle(
            fontSize: 10,
            color: Colors.red,
          )),
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      textAlign: TextAlign.start,
      style: TextStyle(
        fontSize: 13,
        color: widget.isEnable ? black : Colors.black,
      ),
    );
  }
}