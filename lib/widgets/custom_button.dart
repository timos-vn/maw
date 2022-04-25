import 'package:flutter/material.dart';

import 'custom_paint.dart';

class CheckedContainer extends StatelessWidget {
  const CheckedContainer({
    required this.content,
    this.onTap,
    this.checked = false,
    this.color = const Color(0xFFCDCDCD),
    this.checkedColor,
    required this.paddingV,
    Key? key,
  }) : super(key: key);

  final bool checked;
  final Color? checkedColor;
  final Color color;
  final dynamic content;
  final VoidCallback? onTap;
  final double paddingV;

  @override
  Widget build(BuildContext context) {
    final _checkedColor = checkedColor ?? Theme.of(context).primaryColor;

    final mainColor = checked ? _checkedColor : color;

    rContent() {
      if (content is String) {
        return Text(content, style: TextStyle(color: mainColor));
      }
      if (content is Widget) return content;
      return Container();
    }

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 6.0,horizontal: paddingV),
              decoration: BoxDecoration(
                border: Border.all(color: mainColor),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Center(child: rContent()),
            ),
            Visibility(
              visible: checked,
              child: Positioned(
                left: 0,
                top: 0,
                child: CustomPaint(
                  painter: CheckCorner(
                    size: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
