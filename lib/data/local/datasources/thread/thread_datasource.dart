import 'package:chat_app/domain/entity/thread/thread.dart';
import 'package:hive/hive.dart';

class ThreadDataSource {
  final Box<Thread> threadBox;

  const ThreadDataSource(this.threadBox);

  List<Thread> getThreads() {
    return threadBox.values.toList();
  }

  Thread? getThread(int id) {
    return threadBox.get(id);
  }

  void insertThread(Thread thread) {
    threadBox.add(thread);
  }

  void updateThread(Thread thread) {
    threadBox.put(thread.id, thread);
  }

  void deleteThread(int id) {
    threadBox.delete(id);
  }
}
