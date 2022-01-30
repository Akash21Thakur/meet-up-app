import '../repositories/firebase_repository.dart';

class SignUpUseCase{
  final FireBaseRepository repository;

  SignUpUseCase({required this.repository});

  Future<void> call(String email,String password) async{
    return repository.signUp(email, password);
  }
}