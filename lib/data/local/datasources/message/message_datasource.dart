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

  List<Message>? getMessageByThread(int threadId) {
    try {
      return messageBox.values
          .where((message) => message.threadId == threadId)
          .toList();
    } catch (e) {
      return null;
    }
  }

  Future<int> insertMessage(Message message) async {
    int id = await messageBox.add(message);
    return id;
  }

  void updateMessage(Message message) {
    messageBox.put(message.id, message);
  }

  Future<void> deleteMessage(int id) {
    return messageBox.delete(id);
  }
}
