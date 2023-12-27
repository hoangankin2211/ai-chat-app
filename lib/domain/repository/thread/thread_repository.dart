import 'package:chat_app/domain/entity/thread/thread.dart';

abstract class ThreadRepository {
  Future<List<Thread>> getThreads();
  Future<Thread> getThread(int id);
  Future<Thread> addThread(Thread thread);
  Future<bool> updateThread(Thread thread);
  Future<void> deleteThread(int thread);
}
