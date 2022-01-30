


import '../entities/text_message_entity.dart';
import '../repositories/firebase_repository.dart';

class GetMessagesUseCase {
  final FireBaseRepository repository;

  GetMessagesUseCase({required this.repository});

  Stream<List<TextMessageEntity>> call(String type) => repository.getMessages(type);

}