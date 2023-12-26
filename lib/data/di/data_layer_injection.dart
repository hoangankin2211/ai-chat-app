import 'package:chat_app/data/di/module/local_module.dart';
import 'package:chat_app/data/di/module/network_module.dart';
import 'package:chat_app/data/di/module/repository_module.dart';
import 'package:chat_app/domain/di/module/hive_module.dart';

mixin DataLayerInjection {
  static Future<void> configureDataLayerInjection() async {
    await LocalModule.configureLocalModuleInjection();
    await NetworkModule.configureNetworkModuleInjection();
    await RepositoryModule.configureRepositoryModuleInjection();
    await HiveModule.configureHiveModuleInjection();
  }
}
