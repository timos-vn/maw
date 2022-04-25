import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:maw/themes/colors.dart';

class CustomCircularProcessIndicator extends StatelessWidget {
  const CustomCircularProcessIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircularProgressIndicator(
          backgroundColor: primaryColor.withOpacity(0.2),
          valueColor: const AlwaysStoppedAnimation<Color>(blue),
          strokeWidth: 3,
        ),
        const Positioned(
          top: 5,
          left: 5,
          right: 5,
          bottom: 5,
          child: CircleAvatar(
            radius: 14.0,
            backgroundColor: Colors.transparent,
            child: Center(
              child: Icon(
                MdiIcons.bat,
                color: orange,
              ),
            ),
          ),
        )
      ],
    );
  }
}
