import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meet_up_app/presentation/bloc/communication/communication_cubit.dart';
import 'package:meet_up_app/presentation/bloc/login/login_cubit.dart';
import 'package:meet_up_app/presentation/bloc/user/user_cubit.dart';
import 'package:meet_up_app/presentation/screens/welcome_screen.dart';
import './presentation/bloc/auth/auth_cubit.dart';
import 'package:firebase_core/firebase_core.dart';

import './presentation/screens/home_screen.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => di.sl<AuthCubit>()..appStarted(),
        ),
        BlocProvider<LoginCubit>(
          create: (_) => di.sl<LoginCubit>(),
        ),
        BlocProvider<UserCubit>(
          create: (_) => di.sl<UserCubit>(),
        ),
        BlocProvider<CommunicationCubit>(
          create: (_) => di.sl<CommunicationCubit>(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Group Chat Room Responsive',
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return WelcomeScreen(uid: authState.uid);
                }
                if (authState is UnAuthenticated) {
                  return HomeScreen();
                }
                return Container();
              },
            );
          }
        },
      ),
    );
  }
}