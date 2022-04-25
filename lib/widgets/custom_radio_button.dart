import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyRadioListTile<T> extends StatelessWidget {
  final T? value;
  final T? groupValue;
  final Widget? subTitle;
  final Widget? title;

  final ValueChanged<T>? onChanged;

  const MyRadioListTile({
    this.value,
    this.groupValue,
    this.onChanged,
    this.subTitle,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return InkWell(
      onTap: () => onChanged!(value!),
      child: Container(
        // height: 50,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _customRadioButton,
            SizedBox(width: 12),
            if (title != null) Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,
                  subTitle == null ? Container() :
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: subTitle,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Row(
      children: [
        Container(
          // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? Colors.orange : Colors.black.withOpacity(0.6),
              width: 1.6,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              height: 10,width: 10,
              decoration: BoxDecoration(
                color: isSelected ? Colors.orange : null,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? Colors.orange : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}