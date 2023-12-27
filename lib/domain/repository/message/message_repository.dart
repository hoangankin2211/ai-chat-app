import 'package:chat_app/domain/entity/message/message.dart';

abstract class MessageRepository {
  Future<List<Message>> getMessages();
  Future<Message?> getMessage(int id);
  Future<List<Message>?> getMessageByThread(int threadId);
  Future<Message> insertMessage(Message message);
  Future<Message> updateMessage(Message message);
  Future<void> deleteMessage(int id);
}
