import 'package:flutter/material.dart';
import './widget/left_side_widget.dart';
import './widget/right_side_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TabletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context,sizingInformation){
        return Scaffold(
          body: Row(
            children: [
              LeftSideWidget(sizingInformation: sizingInformation,),
              Expanded(child: RightSideWidget(
                sizingInformation: sizingInformation,
              )),
            ],
          ),
        );
      },
    );
  }
}
