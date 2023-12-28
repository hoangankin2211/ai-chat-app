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
  Computed<Message?>? _$getResponseMessageComputed;

  @override
  Message? get getResponseMessage => (_$getResponseMessageComputed ??=
          Computed<Message?>(() => super.getResponseMessage,
              name: '_MessageStore.getResponseMessage'))
      .value;

  late final _$listMessageAtom =
      Atom(name: '_MessageStore.listMessage', context: context);

  @override
  ObservableList<Message> get listMessage {
    _$listMessageAtom.reportRead();
    return super.listMessage;
  }

  @override
  set listMessage(ObservableList<Message> value) {
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

  late final _$responseMessageMapAtom =
      Atom(name: '_MessageStore.responseMessageMap', context: context);

  @override
  ObservableMap<int, Message> get responseMessageMap {
    _$responseMessageMapAtom.reportRead();
    return super.responseMessageMap;
  }

  @override
  set responseMessageMap(ObservableMap<int, Message> value) {
    _$responseMessageMapAtom.reportWrite(value, super.responseMessageMap, () {
      super.responseMessageMap = value;
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

  late final _$changeThreadAsyncAction =
      AsyncAction('_MessageStore.changeThread', context: context);

  @override
  Future<void> changeThread({Thread? thread}) {
    return _$changeThreadAsyncAction
        .run(() => super.changeThread(thread: thread));
  }

  late final _$getMessagesAsyncAction =
      AsyncAction('_MessageStore.getMessages', context: context);

  @override
  Future<dynamic> getMessages() {
    return _$getMessagesAsyncAction.run(() => super.getMessages());
  }

  late final _$sendMessageAsyncAction =
      AsyncAction('_MessageStore.sendMessage', context: context);

  @override
  Future<dynamic> sendMessage({required String message, required Role role}) {
    return _$sendMessageAsyncAction
        .run(() => super.sendMessage(message: message, role: role));
  }

  late final _$_MessageStoreActionController =
      ActionController(name: '_MessageStore', context: context);

  @override
  void _addToMessageList(Message newMessage) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore._addToMessageList');
    try {
      return super._addToMessageList(newMessage);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _updateResponseMessage(String event) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore._updateResponseMessage');
    try {
      return super._updateResponseMessage(event);
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
responseMessageMap: ${responseMessageMap},
fetchMessagesFuture: ${fetchMessagesFuture},
loading: ${loading},
addMessageSuccess: ${addMessageSuccess},
getResponseMessage: ${getResponseMessage}
    ''';
  }
}
