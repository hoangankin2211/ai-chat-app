import 'dart:async';

import 'package:chat_app/core/domain/usecase/use_case.dart';
import 'package:chat_app/domain/entity/thread/thread.dart';
import 'package:chat_app/domain/repository/thread/thread_repository.dart';

class UpdateThreadUseCase extends UseCase<int, Thread> {
  final ThreadRepository _threadRepository;

  UpdateThreadUseCase(this._threadRepository);

  @override
  FutureOr<int> call({required Thread params}) {
    try {
      return _threadRepository.updateThread(params);
    } catch (e) {
      throw e;
    }
  }
}
