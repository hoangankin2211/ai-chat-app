import 'package:chat_app/domain/entity/message/message.dart';

abstract class MessageRepository {
  Future<List<Message>> getMessages();
  Future<Message?> getMessage(int id);
  Future<Message?> getMessageByThread(int threadId);
  Future<int> insertMessage(Message message);
  Future<void> updateMessage(Message message);
  Future<void> deleteMessage(int id);
}
