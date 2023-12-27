import 'package:chat_app/constants/hive_constant.dart';
import 'package:chat_app/di/service_locator.dart';
import 'package:chat_app/domain/entity/message/message.dart';
import 'package:chat_app/domain/entity/thread/thread.dart';
import 'package:hive_flutter/adapters.dart';

mixin HiveModule {
  static Future<void> configureHiveModuleInjection() async {
    // user:--------------------------------------------------------------------
    await Hive.initFlutter();

    Hive.registerAdapter(MessageAdapter());
    Hive.registerAdapter(ThreadAdapter());

    getIt.registerSingleton<Box<Thread>>(
        await Hive.openBox(HiveConstant.threadBox));

    getIt.registerSingleton<Box<Message>>(
        await Hive.openBox(HiveConstant.chatBox));
  }
}
