import 'package:chat_app/core/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

part 'thread_store.g.dart';

class ThreadStore = _ThreadStore with _$ThreadStore;

abstract class _ThreadStore with Store {
  // constructor:---------------------------------------------------------------
  _ThreadStore(this.errorStore);

  // stores:--------------------------------------------------------------------
  // store for handling errors
  final ErrorStore errorStore;

  // store variables:-----------------------------------------------------------
  // static ObservableFuture<ThreadList?> emptyThreadResponse =
  //     ObservableFuture.value(null);

  // @observable
  // ObservableFuture<ThreadList?> fetchThreadsFuture =
  //     ObservableFuture<ThreadList?>(emptyThreadResponse);

  // @observable
  // ThreadList? postList;

  @observable
  bool success = false;

  // @computed
  // bool get loading => fetchThreadsFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  // @action
  // Future getThreads() async {
  //   final future = _getThreadUseCase.call(params: null);
  //   fetchThreadsFuture = ObservableFuture(future);

  //   future.then((postList) {
  //     this.postList = postList;
  //   }).catchError((error) {
  //     errorStore.errorMessage = DioErrorUtil.handleError(error);
  //   });
  // }
}
