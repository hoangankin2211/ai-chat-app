import 'dart:async';

import 'package:chat_app/core/domain/usecase/use_case.dart';
import 'package:chat_app/domain/entity/thread/thread.dart';
import 'package:chat_app/domain/repository/thread/thread_repository.dart';

class FindThreadById extends UseCase<Thread, int> {
  final ThreadRepository _threadRepository;

  FindThreadById(this._threadRepository);

  @override
  FutureOr<Thread> call({required int params}) {
    try {
      return _threadRepository.getThread(params);
    } catch (e) {
      throw e;
    }
  }
}
