import '../repositories/firebase_repository.dart';

class GetCurrentUid{
  final FireBaseRepository repository;

  GetCurrentUid({required this.repository});

  Future<String> call() async => await repository.getCurrentUid();

}