import 'dart:async';

import 'package:chat_app/data/repository/setting/setting_repository_impl.dart';
import 'package:chat_app/data/sharedpref/shared_preference_helper.dart';
import 'package:chat_app/domain/repository/setting/setting_repository.dart';

import '../../../di/service_locator.dart';

mixin RepositoryModule {
  static Future<void> configureRepositoryModuleInjection() async {
    getIt.registerSingleton<SettingRepository>(SettingRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
    ));
  }
}
