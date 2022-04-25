import 'package:flutter/material.dart';
import 'custom_circular_process_indicator.dart';

class PendingAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ModalBarrier(dismissible: false, color: Colors.white.withOpacity(0.5)
            // black.withOpacity(0.3),
            ),
        Align(alignment: Alignment.center, child: CustomCircularProcessIndicator()),
      ],
    );
  }
}
