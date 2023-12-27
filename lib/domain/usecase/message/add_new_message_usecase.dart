import 'dart:async';

import 'package:chat_app/core/domain/usecase/use_case.dart';
import 'package:chat_app/domain/entity/message/message.dart';
import 'package:chat_app/domain/repository/message/message_repository.dart';

class AddNewMessageUseCase extends UseCase<Message, Message> {
  final MessageRepository _messageRepository;

  AddNewMessageUseCase(this._messageRepository);

  @override
  Future<Message> call({required Message params}) {
    return _messageRepository.insertMessage(params);
  }
}
