import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../pages/mobile/single_chat_page_mobile.dart';
import '../pages/tablet/single_chat_page_tablet.dart';
import '../pages/web/single_chat_page_web.dart';

class SingleChatScreen extends StatelessWidget {
  final String username;
  final String uid;
  final String type;

  const SingleChatScreen({Key? key, required this.username, required this.uid,required this.type}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context,sizingInformation){
        if (sizingInformation.isDesktop){
          return SingleChatPageWeb(uid: uid,userName: username,type: type);
        }
        if (sizingInformation.isTablet){
          return SingleChatPageTablet(uid: uid,userName: username,);
        }
        return SingleChatPageMobile(userName: username,uid: uid,);
      },
    );
  }
}
