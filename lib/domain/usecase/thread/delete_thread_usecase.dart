import 'dart:async';

import 'package:chat_app/core/domain/usecase/use_case.dart';
import 'package:chat_app/domain/repository/thread/thread_repository.dart';

class DeleteThreadUseCase extends UseCase<bool, int> {
  final ThreadRepository _threadRepository;

  DeleteThreadUseCase(this._threadRepository);

  @override
  FutureOr<bool> call({required int params}) {
    try {
      _threadRepository.deleteThread(params);
      return true;
    } catch (e) {
      return false;
    }
  }
}
