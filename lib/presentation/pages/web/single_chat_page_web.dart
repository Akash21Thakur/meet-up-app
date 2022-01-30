import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../bloc/communication/communication_cubit.dart';
import '../widget/message_layout.dart';

class SingleChatPageWeb extends StatefulWidget {
  final String uid;
  final String userName;
  final String type;

  const SingleChatPageWeb(
      {Key? key, required this.type, required this.uid, required this.userName})
      : super(key: key);

  @override
  _SingleChatPageWebState createState() => _SingleChatPageWebState();
}

class _SingleChatPageWebState extends State<SingleChatPageWeb> {
  TextEditingController _messageController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<CommunicationCubit>(context).getTextMessages(widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunicationCubit, CommunicationState>(
      builder: (context, state) {
        if (state is CommunicationLoaded) {
          return _bodyWidget(state, widget.type);
        }
        return _loadingWidget();
      },
    );
  }

  Widget _bodyWidget(CommunicationLoaded messages, String game) {
    String img;
    if (game == 'Cricket') {
      img = "assets/cric.jpg";
    } else if(game=='Football') {
      img = "assets/football.jpg";
    } else if(game =='Hockey') {
      img="assets/hockeyy.jpg";
    } else {
      img="assets/wrestling.jpg";
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  const Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0, 1],
              ),
            ),
          ),
            Positioned.fill(
              child: Image.asset(
                img,
                // fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              ),
            ),
          Column(
            children: [
              _headerWidget(widget.type),
              _listMessagesWidget(messages),
              _sendTextMessageWidget(widget.type),
            ],
          ),
        ],
      ),
    );
  }

  Widget _loadingWidget() {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/back.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              _headerWidget(widget.type),
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              _sendTextMessageWidget(widget.type),
            ],
          ),
        ],
      ),
    );
  }

  Widget _headerWidget(String game) {
    String title;
    if (game == 'Cricket') {
      title = "CRICKET";
    } else if(game=='Football') {
      title = "FOOTBALL";
    } else if(game =='Hockey') {
      title="HOCKEY";
    } else {
      title="WRESTLING";
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Colors.indigo.shade400,
          Colors.blue.shade300,
        ],
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                  width: 40, height: 40, child: Image.asset("assets/logo.png")),
               Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            "${widget.userName}",
            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _listMessagesWidget(CommunicationLoaded messages) {
    Timer(
        const Duration(milliseconds: 100),
        () => _scrollController
            .jumpTo(_scrollController.position.maxScrollExtent));

    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: messages.messages.length,
          itemBuilder: (_, index) {
            return messages.messages[index].senderId == widget.uid
                ? MessageLayout(
                    type: messages.messages[index].type,
                    senderId: messages.messages[index].senderId,
                    senderName: messages.messages[index].senderName,
                    text: messages.messages[index].message,
                    time: DateFormat('hh:mm a')
                        .format(messages.messages[index].time.toDate()),
                    color: Colors.green[300],
                    align: TextAlign.left,
                    nip: BubbleNip.rightTop,
                    boxAlignment: CrossAxisAlignment.end,
                    boxMainAxisAlignment: MainAxisAlignment.end,
                    uid: widget.uid,
                  )
                : MessageLayout(
                    uid: messages.messages[index].senderId,
                    type: messages.messages[index].type,
                    senderName: messages.messages[index].senderName,
                    text: messages.messages[index].message,
                    time: DateFormat('hh:mm a')
                        .format(messages.messages[index].time.toDate()),
                    color: Colors.blue,
                    align: TextAlign.left,
                    nip: BubbleNip.leftTop,
                    boxAlignment: CrossAxisAlignment.start,
                    boxMainAxisAlignment: MainAxisAlignment.start,
                  );
          },
        ),
      ),
    );
  }

  Widget _sendTextMessageWidget(String type) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 80),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(0.0)),
            border: Border.all(color: Colors.black.withOpacity(.4), width: 2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _emojiWidget(),
                const SizedBox(
                  width: 8,
                ),
                _textFieldWidget(),
              ],
            ),
            Row(
              children: [
                _micWidget(),
                const SizedBox(
                  width: 8,
                ),
                _sendMessageButton(type),
              ],
            )
          ],
        ),
      ),
    );
  }

  _emojiWidget() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(.2),
          borderRadius: const BorderRadius.all(Radius.circular(40))),
      child: const Icon(
        Icons.emoji_symbols,
        color: Colors.white,
      ),
    );
  }

  _micWidget() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(.2),
          borderRadius: const BorderRadius.all(Radius.circular(40))),
      child: const Icon(
        Icons.mic,
        color: Colors.white,
      ),
    );
  }

  _textFieldWidget() {
    return ResponsiveBuilder(
      builder: (_, sizingInformation) {
        return Container(
          width: sizingInformation.screenSize.width * 0.65,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 60,
            ),
            child: Scrollbar(
              child: TextField(
                controller: _messageController,
                maxLines: null,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "TYPE HERE..."),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _sendMessageButton(String s) {
    return InkWell(
      onTap: () {
        if (_messageController.text.isNotEmpty) {
          _sendTextMessage(s);
          _messageController.clear();
        }
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(40))),
        child: const Icon(
          Icons.send,
          color: Colors.white,
        ),
      ),
    );
  }

  void _sendTextMessage(String s) {
    BlocProvider.of<CommunicationCubit>(context).sendTextMsg(
        uid: widget.uid,
        name: widget.userName,
        message: _messageController.text,
        type: s);
  }
}
