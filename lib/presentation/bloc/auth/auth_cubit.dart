import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/usecase/get_current_uid.dart';
import '../../../domain/usecase/is_sign_usecase.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsSignInUseCase isSignInUseCase;
  final GetCurrentUid getCurrentUidUseCase;
  AuthCubit({required this.isSignInUseCase,required this.getCurrentUidUseCase}) : super(AuthInitial());


  Future<void> appStarted()async{

    try{
      final isSignIn=await isSignInUseCase.call();
      print("Sign $isSignIn");
      if (isSignIn==true){
        final currentUid=await getCurrentUidUseCase.call();
        emit(Authenticated(uid: currentUid));
      }else{
        emit(UnAuthenticated());
      }
    }catch(_){
      print("heelo appStarted catch");
      emit(UnAuthenticated());
    }
  }
  Future<void> loggedIn() async{
    final currentUid=await getCurrentUidUseCase.call();
    emit(Authenticated(uid: currentUid));
  }
  Future<void> loggedOut() async {
    emit(UnAuthenticated());
  }
}
