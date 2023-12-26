import 'dart:async';

import 'package:chat_app/di/service_locator.dart';
import 'package:chat_app/domain/entity/message/message.dart';
import 'package:chat_app/domain/entity/thread/thread.dart';
import 'package:chat_app/presentation/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:hive/hive.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  OpenAI.apiKey = "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";
  OpenAI.baseUrl = "https://api.openai.com/v1";
  OpenAI.showLogs = true;

  await setPreferredOrientations();
  await ServiceLocator.configureDependencies();
  runApp(MyApp());
}

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}
