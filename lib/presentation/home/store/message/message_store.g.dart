// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MessageStore on _MessageStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_MessageStore.loading'))
      .value;
  Computed<bool>? _$addMessageSuccessComputed;

  @override
  bool get addMessageSuccess => (_$addMessageSuccessComputed ??= Computed<bool>(
          () => super.addMessageSuccess,
          name: '_MessageStore.addMessageSuccess'))
      .value;

  late final _$listMessageAtom =
      Atom(name: '_MessageStore.listMessage', context: context);

  @override
  List<MessageUI> get listMessage {
    _$listMessageAtom.reportRead();
    return super.listMessage;
  }

  @override
  set listMessage(List<MessageUI> value) {
    _$listMessageAtom.reportWrite(value, super.listMessage, () {
      super.listMessage = value;
    });
  }

  late final _$threadAtom =
      Atom(name: '_MessageStore.thread', context: context);

  @override
  Thread? get thread {
    _$threadAtom.reportRead();
    return super.thread;
  }

  @override
  set thread(Thread? value) {
    _$threadAtom.reportWrite(value, super.thread, () {
      super.thread = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_MessageStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$loadingMessageAtom =
      Atom(name: '_MessageStore.loadingMessage', context: context);

  @override
  bool get loadingMessage {
    _$loadingMessageAtom.reportRead();
    return super.loadingMessage;
  }

  @override
  set loadingMessage(bool value) {
    _$loadingMessageAtom.reportWrite(value, super.loadingMessage, () {
      super.loadingMessage = value;
    });
  }

  late final _$fetchMessagesFutureAtom =
      Atom(name: '_MessageStore.fetchMessagesFuture', context: context);

  @override
  ObservableFuture<List<Message>> get fetchMessagesFuture {
    _$fetchMessagesFutureAtom.reportRead();
    return super.fetchMessagesFuture;
  }

  @override
  set fetchMessagesFuture(ObservableFuture<List<Message>> value) {
    _$fetchMessagesFutureAtom.reportWrite(value, super.fetchMessagesFuture, () {
      super.fetchMessagesFuture = value;
    });
  }

  late final _$getMessagesAsyncAction =
      AsyncAction('_MessageStore.getMessages', context: context);

  @override
  Future<dynamic> getMessages() {
    return _$getMessagesAsyncAction.run(() => super.getMessages());
  }

  late final _$addMessageAsyncAction =
      AsyncAction('_MessageStore.addMessage', context: context);

  @override
  Future<dynamic> addMessage({required String message, required Role role}) {
    return _$addMessageAsyncAction
        .run(() => super.addMessage(message: message, role: role));
  }

  late final _$addThreadAsyncAction =
      AsyncAction('_MessageStore.addThread', context: context);

  @override
  Future<void> addThread(Thread thread) {
    return _$addThreadAsyncAction.run(() => super.addThread(thread));
  }

  late final _$_MessageStoreActionController =
      ActionController(name: '_MessageStore', context: context);

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
listMessage: ${listMessage},
thread: ${thread},
success: ${success},
loadingMessage: ${loadingMessage},
fetchMessagesFuture: ${fetchMessagesFuture},
loading: ${loading},
addMessageSuccess: ${addMessageSuccess}
    ''';
  }
}
