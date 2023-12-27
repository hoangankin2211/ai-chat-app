import 'dart:async';

import 'package:chat_app/core/domain/usecase/use_case.dart';
import 'package:chat_app/domain/entity/thread/thread.dart';
import 'package:chat_app/domain/repository/thread/thread_repository.dart';

class GetThreadUseCase extends UseCase<List<Thread>, void> {
  final ThreadRepository _threadRepository;

  GetThreadUseCase(this._threadRepository);

  @override
  Future<List<Thread>> call({required void params}) {
    try {
      return _threadRepository.getThreads();
    } catch (e) {
      throw e;
    }
  }
}
