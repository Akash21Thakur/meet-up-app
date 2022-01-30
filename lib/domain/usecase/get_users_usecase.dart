


import '../entities/user_entity.dart';
import '../repositories/firebase_repository.dart';

class GetUsersUseCase {
  final FireBaseRepository repository;

  GetUsersUseCase({required this.repository});

  Stream<List<UserEntity>> call() => repository.getUsers();


}