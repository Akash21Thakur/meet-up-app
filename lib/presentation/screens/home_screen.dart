import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../pages/mobile/mobile_page.dart';
import '../pages/tablet/tablet_page.dart';
import '../pages/web/web_page.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context,sizingInformation){
        if (sizingInformation.isDesktop){
          return WebPage( sizingInformation: sizingInformation,);
        }
        if (sizingInformation.isTablet){
          return TabletPage();
        }
        return MobilePage();
      },
    );
  }
}
