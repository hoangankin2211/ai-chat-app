import 'dart:developer';

import 'package:chat_app/data/local/datasources/thread/thread_datasource.dart';
import 'package:chat_app/domain/entity/thread/thread.dart';
import 'package:chat_app/domain/repository/thread/thread_repository.dart';

class ThreadRepositoryImpl implements ThreadRepository {
  final ThreadDataSource _threadDataSource;

  ThreadRepositoryImpl(this._threadDataSource);

  @override
  Future<Thread> addThread(Thread thread) async {
    try {
      int id = await _threadDataSource.insertThread(thread);
      _threadDataSource.updateThread(thread.copyWith(id: id));
      return thread.copyWith(id: id);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> deleteThread(int thread) async {
    try {
      return _threadDataSource.deleteThread(thread);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Thread> getThread(int id) async {
    try {
      Thread? thread = _threadDataSource.getThread(id);
      if (thread == null) {
        throw Exception('Thread not found');
      }
      return thread;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<Thread>> getThreads() {
    try {
      return Future.value(_threadDataSource.getThreads());
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<bool> updateThread(Thread thread) {
    try {
      _threadDataSource.updateThread(thread);
      return Future.value(true);
    } catch (e) {
      log(e.toString());
      return Future.value(false);
    }
  }
}
