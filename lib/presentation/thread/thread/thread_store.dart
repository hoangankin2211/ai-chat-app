import 'package:chat_app/core/stores/error/error_store.dart';
import 'package:chat_app/domain/entity/thread/thread.dart';
import 'package:chat_app/domain/usecase/thread/get_thread_usecase.dart';
import 'package:chat_app/domain/usecase/thread/insert_thread_usecase.dart';
import 'package:chat_app/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'thread_store.g.dart';

class ThreadStore = _ThreadStore with _$ThreadStore;

abstract class _ThreadStore with Store {
  _ThreadStore(
      this.errorStore, this._getThreadUseCase, this._insertThreadUseCase);

  final GetThreadUseCase _getThreadUseCase;
  final InsertThreadUseCase _insertThreadUseCase;
  final ErrorStore errorStore;

  static ObservableFuture<List<Thread>> emptyThreadResponse =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<Thread>> fetchThreadsFuture =
      ObservableFuture<List<Thread>>(emptyThreadResponse);

  @observable
  ObservableFuture<Thread?> addThreadFuture =
      ObservableFuture(ObservableFuture.value(null));

  @observable
  List<Thread>? threadList;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchThreadsFuture.status == FutureStatus.pending;

  @computed
  bool get addThreadSuccess =>
      fetchThreadsFuture.status == FutureStatus.fulfilled;

  // actions:-------------------------------------------------------------------
  @action
  Future getThreads() async {
    final future = _getThreadUseCase.call(params: null);
    fetchThreadsFuture = ObservableFuture(future);
    future.then((threadList) {
      this.threadList = threadList;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future addThread({required String title}) async {
    final future = _insertThreadUseCase.call(
      params: Thread(id: 0, createdAt: DateTime.now().millisecondsSinceEpoch),
    );
    addThreadFuture = ObservableFuture(future);
    future.then((thread) {
      this.threadList = (this.threadList?.toList() ?? [])..add(thread);
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
