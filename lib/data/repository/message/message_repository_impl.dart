import 'package:chat_app/data/local/datasources/message/message_datasource.dart';
import 'package:chat_app/domain/entity/message/message.dart';
import 'package:chat_app/domain/repository/message/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageDataSource _messageDataSource;

  MessageRepositoryImpl(this._messageDataSource);

  @override
  Future<void> deleteMessage(int id) {
    try {
      return _messageDataSource.deleteMessage(id);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Message?> getMessage(int id) {
    try {
      return Future.value(_messageDataSource.getMessage(id));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<Message>> getMessageByThread(int threadId) {
    try {
      return Future.value(_messageDataSource.getMessageByThread(threadId));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<Message>> getMessages() {
    try {
      return Future.value(_messageDataSource.getMessages());
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Message> insertMessage(Message message) async {
    try {
      int id = await _messageDataSource.insertMessage(message);
      final messageWithId = message.copyWith(id: id);
      _messageDataSource.updateMessage(messageWithId);
      return Future.value(messageWithId);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Message> updateMessage(Message message) async {
    try {
      _messageDataSource.updateMessage(message);
      return (await getMessage(message.id))!;
    } catch (e) {
      throw e;
    }
  }
}
