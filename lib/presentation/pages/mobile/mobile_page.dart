import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import './widget/body_widget.dart';

class MobilePage extends StatelessWidget {
  // const WebPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context,sizingInformation){
        return Scaffold(
          body: Container(
            child: BodyWidgetMobile(sizingInformation: sizingInformation,),
          ),
        );
      },
    );
  }
}