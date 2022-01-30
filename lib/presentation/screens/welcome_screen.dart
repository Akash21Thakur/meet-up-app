import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../pages/mobile/welcome_page_mobile.dart';
import '../pages/tablet/welcome_page_tablet.dart';
import '../pages/web/welcome_page_web.dart';

class WelcomeScreen extends StatelessWidget {
  final String uid;

  const WelcomeScreen({Key? key, required this.uid}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return ResponsiveBuilder(
      builder: (context,sizingInformation){
        if (sizingInformation.isDesktop){
          return WelcomePageWeb(uid: uid,);
        }
        if (sizingInformation.isTablet){
          return WelcomePageTablet(uid: uid,);
        }
        return WelcomePageMobile(uid: uid,);
      },
    );
  }
}
