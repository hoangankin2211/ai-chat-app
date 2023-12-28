import 'package:chat_app/core/stores/error/error_store.dart';
import 'package:chat_app/domain/entity/thread/thread.dart';
import 'package:chat_app/domain/usecase/thread/get_thread_usecase.dart';
import 'package:chat_app/domain/usecase/thread/insert_thread_usecase.dart';
import 'package:chat_app/presentation/home/store/message/message_store.dart';
import 'package:chat_app/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'thread_store.g.dart';

class ThreadStore = _ThreadStore with _$ThreadStore;

abstract class _ThreadStore with Store {
  _ThreadStore(this.errorStore, this._getThreadUseCase,
      this._insertThreadUseCase, this._messageStore);

  final GetThreadUseCase _getThreadUseCase;
  final MessageStore _messageStore;
  final InsertThreadUseCase _insertThreadUseCase;
  final ErrorStore errorStore;

  static ObservableFuture<List<Thread>> emptyThreadResponse =
      ObservableFuture.value([]);

  @observable
  Thread? selectedThread;

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

  @observable
  bool isLoading = false;

  @computed
  bool get addThreadSuccess =>
      fetchThreadsFuture.status == FutureStatus.fulfilled;

  // actions:-------------------------------------------------------------------
  @action
  Future getThreads() async {
    isLoading = true;
    final future = _getThreadUseCase.call(params: null);
    fetchThreadsFuture = ObservableFuture(future);
    future.then((threadList) {
      this.threadList = threadList
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
    isLoading = false;
  }

  @action
  Future addThread({String title = "Untitled"}) async {
    final future = _insertThreadUseCase.call(
      params: Thread(
        id: 0,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        title: title,
      ),
    );
    addThreadFuture = ObservableFuture(future);
    future.then((thread) {
      this.threadList = (this.threadList?.toList() ?? [])..insert(0, thread);
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future<void> changeThread({Thread? thread}) async {
    selectedThread = thread;
    await _messageStore.changeThread(thread: thread);
  }
}
