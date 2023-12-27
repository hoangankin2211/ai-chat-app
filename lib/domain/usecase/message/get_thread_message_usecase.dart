import 'dart:async';

import 'package:chat_app/core/domain/usecase/use_case.dart';
import 'package:chat_app/domain/entity/message/message.dart';
import 'package:chat_app/domain/repository/message/message_repository.dart';

class GetThreadMessageUseCase extends UseCase<List<Message>?, int> {
  final MessageRepository _messageRepository;

  GetThreadMessageUseCase(this._messageRepository);

  @override
  Future<List<Message>?> call({required int params}) async {
    return _messageRepository.getMessageByThread(params);
  }
}
