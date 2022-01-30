import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import './widget/right_side_widget.dart';
import './widget/left_side_widget.dart';

class WebPage extends StatelessWidget {
  final SizingInformation sizingInformation;

  const WebPage({Key? key, required this.sizingInformation}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            LeftSideWidget(sizingInformation: sizingInformation,),
            Expanded(child: RightSideWidget(
              sizingInformation: sizingInformation,
            )),
          ],
        ),
      ),
    );
  }
}