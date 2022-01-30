import '../../domain/entities/text_message_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/firebase_repository.dart';
import '../datasource/firebase_remote_datasorce.dart';

class FireBaseRepositoryImpl implements FireBaseRepository {
  final FirebaseRemoteDataSource firebaseRemoteDataSource;

  FireBaseRepositoryImpl({required this.firebaseRemoteDataSource});

  @override
  Future<String> getCurrentUid() async =>
      await firebaseRemoteDataSource.getCurrentUid();

  @override
  Future<bool> isSignIn() async =>
      await firebaseRemoteDataSource.isSignIn();

  @override
  Future<void> signIn(String email, String password) async =>
      await firebaseRemoteDataSource.signIn(email, password);

  @override
  Future<void> signUp(String email, String password) async =>
      await firebaseRemoteDataSource.signUp(email, password);

  @override
  Future<void> getCreateCurrentUser(String email, String name,
      String profileUrl)async {
    return await firebaseRemoteDataSource.getCreateCurrentUser(email, name, profileUrl);
  }

  @override
  Stream<List<TextMessageEntity>> getMessages(String type) {
    return firebaseRemoteDataSource.getMessages(type);
  }

  @override
  Stream<List<UserEntity>> getUsers() {
    return firebaseRemoteDataSource.getUsers();
  }

  @override
  Future<void> sendTextMessage(TextMessageEntity textMessage,String s) {
    return firebaseRemoteDataSource.sendTextMessage(textMessage,s);
  }

  @override
  Future<void> signOut() => firebaseRemoteDataSource.signOut();

}
