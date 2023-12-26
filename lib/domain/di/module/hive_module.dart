import 'package:chat_app/domain/entity/message/message.dart';
import 'package:chat_app/domain/entity/thread/thread.dart';
import 'package:hive/hive.dart';

mixin HiveModule {
  static Future<void> configureHiveModuleInjection() async {
    // user:--------------------------------------------------------------------
    Hive.registerAdapter(MessageAdapter());
    Hive.registerAdapter(ThreadAdapter());
  }
}
