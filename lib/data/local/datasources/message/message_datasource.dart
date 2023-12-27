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

  Future<int> insertMessage(Message message) async {
    int id = await messageBox.add(message);
    updateMessage(message.copyWith(id: id));
    return id;
  }

  void updateMessage(Message message) {
    messageBox.put(message.id, message);
  }

  Future<void> deleteMessage(int id) {
    return messageBox.delete(id);
  }
}
