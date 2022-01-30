import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:meet_up_app/presentation/pages/web/single_chat_page_web.dart';

import '../../../data/model/user_model.dart';
import '../../bloc/auth/auth_cubit.dart';
import '../../bloc/login/login_cubit.dart';
import '../../bloc/user/user_cubit.dart';
import '../../screens/single_chat_screen.dart';

class WelcomePageWeb extends StatefulWidget {
  final String uid;
  const WelcomePageWeb({Key? key, required this.uid}) : super(key: key);

  @override
  State<WelcomePageWeb> createState() => _WelcomePageWebState();
}

class _WelcomePageWebState extends State<WelcomePageWeb> {
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (_, state) {
      if (state is UserLoaded) {
        return _bodyWidget(state);
      }
      return _loadingWidget();
    });
  }

  Widget _bodyWidget(UserLoaded users) {
    final user = users.users.firstWhere((user) => user.uid == widget.uid,
        orElse: () => UserModel());
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.indigo.shade400,
                  Colors.blue.shade300,
                ],
              ),
            ),
          ),
          Container(
            // alignment: Alignment.center,
            // height: ,
            // width: 200,
            child: Lottie.asset(
              "assets/cycling.json",
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
                margin: const EdgeInsets.only(top: 150),
                child: Text(
                  "MEET UP APP WELCOMES\n        ${user.name}",
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Lottie.asset("assets/bubble.json"),
          ),
          _joinGlobalChatButton(user.name),
          _logOutWidget(),
        ],
      ),
    );
  }

  Widget _loadingWidget() {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.indigo.shade400,
                  Colors.blue.shade300,
                ],
              ),
            ),
          ),
          const Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }

  Widget _joinGlobalChatButton(String name) {
    return Align(
      alignment: Alignment.center,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 150,
            ),
            const Text(
              "Join Us For Fun",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 200,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 150,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SingleChatScreen(
                            username: name, uid: widget.uid, type: 'Cricket'),
                      ),
                    );
                  },
                  child: Container(
                    width: 250,
                    height: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.3),
                        borderRadius:
                            BorderRadius.all(const Radius.circular(20)),
                        border: Border.all(color: Colors.white60, width: 2)),
                    child: const Text(
                      "CRICKET",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 60,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SingleChatPageWeb(
                            userName: name, uid: widget.uid, type: 'Football'),
                      ),
                    );
                  },
                  child: Container(
                    width: 250,
                    height: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(color: Colors.white60, width: 2)),
                    child: const Text(
                      "FOOTBALL",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 60,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SingleChatPageWeb(
                            userName: name, uid: widget.uid, type: 'Wrestling'),
                      ),
                    );
                  },
                  child: Container(
                    width: 250,
                    height: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(color: Colors.white60, width: 2)),
                    child: const Text(
                      "WRESTLING",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 60,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SingleChatPageWeb(
                            userName: name, uid: widget.uid, type: 'Hockey'),
                      ),
                    );
                  },
                  child: Container(
                    width: 250,
                    height: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(color: Colors.white60, width: 2)),
                    child: const Text(
                      "HOCKEY",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _logOutWidget() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: InkWell(
        onTap: () {
          // TODO:Logout
          BlocProvider.of<AuthCubit>(context).loggedOut();
          BlocProvider.of<LoginCubit>(context).submitSignOut();
        },
        child: Container(
          margin: const EdgeInsets.only(left: 15, bottom: 15),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.3),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Icon(
            Icons.exit_to_app,
            size: 30,
          ),
        ),
      ),
    );
  }
}
