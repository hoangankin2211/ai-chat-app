import 'dart:async';

import 'package:chat_app/di/service_locator.dart';
import 'package:chat_app/domain/usecase/message/add_new_message_usecase.dart';
import 'package:chat_app/domain/usecase/message/get_thread_message_usecase.dart';
import 'package:chat_app/domain/usecase/thread/delete_thread_usecase.dart';
import 'package:chat_app/domain/usecase/thread/find_thread_by_id.dart';
import 'package:chat_app/domain/usecase/thread/get_thread_usecase.dart';
import 'package:chat_app/domain/usecase/thread/insert_thread_usecase.dart';
import 'package:chat_app/domain/usecase/thread/update_thread_usecase.dart';
import 'package:get_it/get_it.dart';

mixin UseCaseModule {
  static Future<void> configureUseCaseModuleInjection() async {
    await getIt.registerSingleton<InsertThreadUseCase>(
        InsertThreadUseCase(getIt.get()));
    await getIt.registerSingleton<DeleteThreadUseCase>(
        DeleteThreadUseCase(getIt.get()));
    await getIt
        .registerSingleton<GetThreadUseCase>(GetThreadUseCase(getIt.get()));
    await getIt.registerSingleton<FindThreadById>(FindThreadById(getIt.get()));
    await getIt.registerSingleton<UpdateThreadUseCase>(
        UpdateThreadUseCase(getIt.get()));

    await getIt.registerSingleton<AddNewMessageUseCase>(
        AddNewMessageUseCase(getIt.get()));

    await getIt.registerSingleton<GetThreadMessageUseCase>(
        GetThreadMessageUseCase(getIt.get()));
  }
}
