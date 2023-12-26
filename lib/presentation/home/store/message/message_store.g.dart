// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MessageStore on _MessageStore, Store {
  late final _$addThreadAsyncAction =
      AsyncAction('_MessageStore.addThread', context: context);

  @override
  Future<void> addThread(Thread thread) {
    return _$addThreadAsyncAction.run(() => super.addThread(thread));
  }

  late final _$_MessageStoreActionController =
      ActionController(name: '_MessageStore', context: context);

  @override
  Stream<OpenAIStreamChatCompletionModel> sendMessage(String value) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.sendMessage');
    try {
      return super.sendMessage(value);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<Thread> getAllThread() {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.getAllThread');
    try {
      return super.getAllThread();
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<OpenAIChatCompletionChoiceMessageModel> getMessage() {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.getMessage');
    try {
      return super.getMessage();
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
