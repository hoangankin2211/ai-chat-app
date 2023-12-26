import 'package:chat_app/domain/entity/message/message.dart';
import 'package:hive/hive.dart';

class MessageDataSource {
  final Box<Message> messageBox;

  const MessageDataSource(this.messageBox);

  List<Message> getMessages() {
    return messageBox.values.toList();
  }

  Message? getMessage(int id) {
    return messageBox.get(id);
  }

  Message? getMessageByThread(int threadId) {
    return messageBox.values
        .firstWhere((message) => message.threadId == threadId);
  }

  void insertMessage(Message message) {
    messageBox.add(message);
  }

  void updateMessage(Message message) {
    messageBox.put(message.id, message);
  }

  void deleteMessage(int id) {
    messageBox.delete(id);
  }
}
