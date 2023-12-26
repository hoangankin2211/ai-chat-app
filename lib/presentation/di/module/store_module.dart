import 'dart:async';

import 'package:chat_app/core/stores/error/error_store.dart';
import 'package:chat_app/core/stores/form/form_store.dart';
import 'package:chat_app/domain/repository/setting/setting_repository.dart';
import 'package:chat_app/presentation/home/store/language/language_store.dart';
import 'package:chat_app/presentation/home/store/theme/theme_store.dart';

import '../../../di/service_locator.dart';

mixin StoreModule {
  static Future<void> configureStoreModuleInjection() async {
    // factories:---------------------------------------------------------------
    getIt.registerFactory(() => ErrorStore());
    getIt.registerFactory(() => FormErrorStore());
    getIt.registerFactory(
      () => FormStore(getIt<FormErrorStore>(), getIt<ErrorStore>()),
    );

    // stores:------------------------------------------------------------------

    getIt.registerSingleton<ThemeStore>(
      ThemeStore(
        getIt<SettingRepository>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<LanguageStore>(
      LanguageStore(
        getIt<SettingRepository>(),
        getIt<ErrorStore>(),
      ),
    );
  }
}
