import 'dart:async';

import 'package:chat_app/data/local/datasources/thread/thread_datasource.dart';
import 'package:chat_app/data/repository/setting/setting_repository_impl.dart';
import 'package:chat_app/data/repository/thread/thread_repository_impl.dart';
import 'package:chat_app/data/sharedpref/shared_preference_helper.dart';
import 'package:chat_app/domain/entity/thread/thread.dart';
import 'package:chat_app/domain/repository/setting/setting_repository.dart';
import 'package:chat_app/domain/repository/thread/thread_repository.dart';
import 'package:hive/hive.dart';

import '../../../di/service_locator.dart';

mixin RepositoryModule {
  static Future<void> configureRepositoryModuleInjection() async {
    getIt.registerSingleton<SettingRepository>(
        SettingRepositoryImpl(getIt<SharedPreferenceHelper>()));

    getIt.registerSingleton<ThreadDataSource>(
        ThreadDataSource(getIt<Box<Thread>>()));

    getIt.registerSingleton<ThreadRepository>(
        ThreadRepositoryImpl(getIt<ThreadDataSource>()));
  }
}
