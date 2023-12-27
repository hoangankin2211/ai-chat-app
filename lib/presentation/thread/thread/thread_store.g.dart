// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ThreadStore on _ThreadStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_ThreadStore.loading'))
      .value;
  Computed<bool>? _$addThreadSuccessComputed;

  @override
  bool get addThreadSuccess => (_$addThreadSuccessComputed ??= Computed<bool>(
          () => super.addThreadSuccess,
          name: '_ThreadStore.addThreadSuccess'))
      .value;

  late final _$fetchThreadsFutureAtom =
      Atom(name: '_ThreadStore.fetchThreadsFuture', context: context);

  @override
  ObservableFuture<List<Thread>> get fetchThreadsFuture {
    _$fetchThreadsFutureAtom.reportRead();
    return super.fetchThreadsFuture;
  }

  @override
  set fetchThreadsFuture(ObservableFuture<List<Thread>> value) {
    _$fetchThreadsFutureAtom.reportWrite(value, super.fetchThreadsFuture, () {
      super.fetchThreadsFuture = value;
    });
  }

  late final _$addThreadFutureAtom =
      Atom(name: '_ThreadStore.addThreadFuture', context: context);

  @override
  ObservableFuture<Thread?> get addThreadFuture {
    _$addThreadFutureAtom.reportRead();
    return super.addThreadFuture;
  }

  @override
  set addThreadFuture(ObservableFuture<Thread?> value) {
    _$addThreadFutureAtom.reportWrite(value, super.addThreadFuture, () {
      super.addThreadFuture = value;
    });
  }

  late final _$threadListAtom =
      Atom(name: '_ThreadStore.threadList', context: context);

  @override
  List<Thread>? get threadList {
    _$threadListAtom.reportRead();
    return super.threadList;
  }

  @override
  set threadList(List<Thread>? value) {
    _$threadListAtom.reportWrite(value, super.threadList, () {
      super.threadList = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_ThreadStore.success', context: context);

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

  late final _$getThreadsAsyncAction =
      AsyncAction('_ThreadStore.getThreads', context: context);

  @override
  Future<dynamic> getThreads() {
    return _$getThreadsAsyncAction.run(() => super.getThreads());
  }

  late final _$addThreadAsyncAction =
      AsyncAction('_ThreadStore.addThread', context: context);

  @override
  Future<dynamic> addThread({required String title}) {
    return _$addThreadAsyncAction.run(() => super.addThread(title: title));
  }

  @override
  String toString() {
    return '''
fetchThreadsFuture: ${fetchThreadsFuture},
addThreadFuture: ${addThreadFuture},
threadList: ${threadList},
success: ${success},
loading: ${loading},
addThreadSuccess: ${addThreadSuccess}
    ''';
  }
}
