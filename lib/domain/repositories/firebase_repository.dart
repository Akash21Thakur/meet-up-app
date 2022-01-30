

import '../entities/text_message_entity.dart';
import '../entities/user_entity.dart';

abstract class FireBaseRepository{
  Future<void> signUp(String email,String password);
  Future<void> signIn(String email,String password);
  Future<bool> isSignIn();
  Future<void> signOut();
  Future<String> getCurrentUid();
  Future<void> getCreateCurrentUser(
      String email, String name, String profileUrl);
  Future<void> sendTextMessage(TextMessageEntity textMessage,String s);
  Stream<List<UserEntity>> getUsers();
  Stream<List<TextMessageEntity>> getMessages(String type);
}