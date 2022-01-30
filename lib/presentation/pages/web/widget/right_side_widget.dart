import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../bloc/auth/auth_cubit.dart';
import '../../../bloc/login/login_cubit.dart';

class RightSideWidget extends StatefulWidget {
  final SizingInformation sizingInformation;

  const RightSideWidget({Key? key, required this.sizingInformation})
      : super(key: key);

  @override
  State<RightSideWidget> createState() => _RightSideWidgetState();
}

class _RightSideWidgetState extends State<RightSideWidget> {

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  bool isLoginPage = true;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state is LoginLoading) {
          return _loadingWidget();
        }
        return _bodyWidget();
      },
      listener: (context, state) {
        if (state is LoginSuccess){
          BlocProvider.of<AuthCubit>(context).loggedIn();
        }
      },
    );
  }

  Widget _loadingWidget() {

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            _imageWidget(),
            const SizedBox(
              height: 15,
            ),
            _fromWidget(),
            const SizedBox(
              height: 15,
            ),
            _buttonWidget(),
            const SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _rowTextWidget(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Lottie.asset("assets/loading.json"),
            ),
          ],
        );
    //   ],
    // );
  }

  Widget _bodyWidget() {
    return Stack(
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
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
                transform: Matrix4.rotationZ(-8 * pi / 180)
                  ..translate(-10.0),
                // ..translate(-10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.deepOrange.shade900,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 8,
                      color: Colors.black26,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: const Text(
                  'MEET-UP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    // fontFamily: 'Anton',
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            _imageWidget(),
            const SizedBox(
              height: 15,
            ),
            _fromWidget(),
            const SizedBox(
              height: 15,
            ),
            _buttonWidget(),
            const SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _rowTextWidget(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _imageWidget() {
    return Container(
      height: 100,
      width: 100,
      child: Lottie.asset("assets/login.json"),
    );
  }

  Widget _fromWidget() {

    return Column(
      children: [
        isLoginPage == true
            ? const Text(
                "",
                style: TextStyle(fontSize: 0),
              )
            : Container(
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(const Radius.circular(40)),
                  border: Border.all(color: Colors.grey, width: 1.0),
                ),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "User Name",
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
              ),
        isLoginPage == true
            ? const Text(
                "",
                style: TextStyle(fontSize: 0),
              )
            : const SizedBox(
                height: 20,
              ),
        Container(
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            border: Border.all(color: Colors.grey, width: 1.0),
          ),
          child: TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Email Address",
              prefixIcon: Icon(Icons.alternate_email),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            border: Border.all(color: Colors.grey, width: 1.0),
          ),
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Password",
              prefixIcon: Icon(Icons.lock_outline),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buttonWidget() {
    return InkWell(
      onTap: () {
        if (isLoginPage == true) {
          _submitLogin();
        } else {
          _submitRegistration();
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        // width: widget.sizingInformation.screenSize.width,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: const BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: Text(
          isLoginPage == true ?"LOGIN" : "REGISTER",
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Widget _rowTextWidget() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLoginPage == true ? "Don't have account?" : "Have an account?",
          style: TextStyle(fontSize: 16, color: Colors.indigo[400]),
        ),
        InkWell(
          onTap: () {
            setState(() {
              if (isLoginPage == true) {
                isLoginPage = false;
              } else {
                isLoginPage = true;
              }
            });
          },
          child: Text(
            isLoginPage == true ? " Sign Up" : " Sign In",
            style: const TextStyle(
                fontSize: 16,
                color: Colors.indigo,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  void _submitLogin() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      BlocProvider.of<LoginCubit>(context).submitLogin(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  void _submitRegistration() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _nameController.text.isNotEmpty) {
      BlocProvider.of<LoginCubit>(context).submitRegistration(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
      );
    }
  }
}
