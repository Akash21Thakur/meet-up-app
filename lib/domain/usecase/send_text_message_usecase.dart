


import '../entities/text_message_entity.dart';
import '../repositories/firebase_repository.dart';

class SendTextMessageUseCase{
  final FireBaseRepository repository;
  // final String type;

  SendTextMessageUseCase({required this.repository});

  Future<void> call(TextMessageEntity textMessage,String s){
    return repository.sendTextMessage(textMessage,s);
  }

}