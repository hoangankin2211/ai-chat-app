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

  Future<int> insertThread(Thread thread) async {
    int id = await threadBox.add(thread);
    updateThread(thread.copyWith(id: id));
    return id;
  }

  void updateThread(Thread thread) {
    threadBox.put(thread.id, thread);
  }

  Future<void> deleteThread(int id) async {
    return threadBox.delete(id);
  }
}
