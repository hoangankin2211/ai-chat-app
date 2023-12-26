import 'package:chat_app/core/data/network/dio/configs/dio_configs.dart';
import 'package:chat_app/core/data/network/dio/dio_client.dart';
import 'package:chat_app/core/data/network/dio/interceptors/auth_interceptor.dart';
import 'package:chat_app/core/data/network/dio/interceptors/logging_interceptor.dart';
import 'package:chat_app/data/network/constants/endpoints.dart';
import 'package:chat_app/data/network/interceptors/error_interceptor.dart';
import 'package:chat_app/data/network/rest_client.dart';
import 'package:chat_app/data/sharedpref/shared_preference_helper.dart';
import 'package:event_bus/event_bus.dart';

import '../../../di/service_locator.dart';

mixin NetworkModule {
  static Future<void> configureNetworkModuleInjection() async {
    // event bus:---------------------------------------------------------------
    getIt.registerSingleton<EventBus>(EventBus());

    // interceptors:------------------------------------------------------------
    getIt.registerSingleton<LoggingInterceptor>(LoggingInterceptor());
    getIt.registerSingleton<ErrorInterceptor>(ErrorInterceptor(getIt()));
    getIt.registerSingleton<AuthInterceptor>(
      AuthInterceptor(
        accessToken: () async =>
            await getIt<SharedPreferenceHelper>().authToken,
      ),
    );

    // rest client:-------------------------------------------------------------
    getIt.registerSingleton(RestClient());

    // dio:---------------------------------------------------------------------
    getIt.registerSingleton<DioConfigs>(
      const DioConfigs(
        baseUrl: Endpoints.baseUrl,
        connectionTimeout: Endpoints.connectionTimeout,
        receiveTimeout: Endpoints.receiveTimeout,
      ),
    );
    getIt.registerSingleton<DioClient>(
      DioClient(dioConfigs: getIt())
        ..addInterceptors(
          [
            getIt<AuthInterceptor>(),
            getIt<ErrorInterceptor>(),
            getIt<LoggingInterceptor>(),
          ],
        ),
    );

    // api's:-------------------------------------------------------------------
    // getIt.registerSingleton(PostApi(getIt<DioClient>(), getIt<RestClient>()));
  }
}
