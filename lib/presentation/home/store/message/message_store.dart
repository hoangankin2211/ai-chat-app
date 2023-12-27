import 'package:chat_app/core/stores/error/error_store.dart';
import 'package:chat_app/domain/entity/message/message.dart';
import 'package:chat_app/domain/entity/message/role.dart';
import 'package:chat_app/domain/entity/thread/thread.dart';
import 'package:chat_app/domain/usecase/message/add_new_message_usecase.dart';
import 'package:chat_app/domain/usecase/message/get_thread_message_usecase.dart';
import 'package:chat_app/domain/usecase/thread/insert_thread_usecase.dart';
import 'package:chat_app/presentation/home/store/message/message_ui.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

part 'message_store.g.dart';

class MessageStore = _MessageStore with _$MessageStore;

abstract class _MessageStore with Store {
  final AddNewMessageUseCase _addNewMessageUseCase;
  final GetThreadMessageUseCase _getThreadMessageUseCase;
  final InsertThreadUseCase _insertThreadUseCase;
  final ErrorStore errorStore;

  // constructor:---------------------------------------------------------------
  _MessageStore(
    this._addNewMessageUseCase,
    this._getThreadMessageUseCase,
    this.errorStore,
    this._insertThreadUseCase,
  ) {
    init();
  }

  static ObservableFuture<List<Message>> emptyMessageResponse =
      ObservableFuture.value([]);

  @observable
  List<MessageUI> listMessage = [];

  @observable
  Thread? thread;

  @observable
  bool success = false;

  @observable
  bool loadingMessage = false;

  @observable
  Stream<String>? responseMessage;

  @computed
  bool get loading => fetchMessagesFuture.status == FutureStatus.pending;

  @computed
  bool get addMessageSuccess =>
      fetchMessagesFuture.status == FutureStatus.fulfilled;

  @observable
  ObservableFuture<List<Message>> fetchMessagesFuture =
      ObservableFuture<List<Message>>(emptyMessageResponse);

  // actions:-------------------------------------------------------------------

  @action
  Future getMessages() async {
    if (thread == null) {
      this.thread = await _insertThreadUseCase.call(
        params: Thread(
          id: 0,
          createdAt: DateTime.now().millisecondsSinceEpoch,
        ),
      );
    }
    final future = _getThreadMessageUseCase.call(params: thread!.id);
    fetchMessagesFuture = ObservableFuture(future.then((value) {
      if (value != null) return value;
      return [];
    }));

    future.then((messageList) {
      this.listMessage = (messageList ?? [])
          .map(
            (e) => MessageUI(message: e),
          )
          .toList();
    }).catchError((error) {
      errorStore.errorMessage = error.toString();
    });
  }

  @action
  Future addMessage({required String message, required Role role}) async {
    if (thread == null) {
      this.thread = await _insertThreadUseCase.call(
        params: Thread(
          id: 0,
          createdAt: DateTime.now().millisecondsSinceEpoch,
        ),
      );
    }

    final future = await _addNewMessageUseCase.call(
      params: Message(
        id: 0,
        threadId: thread!.id,
        title: message,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        role: role.name,
      ),
    );
    this.listMessage = [
      ...listMessage,
      MessageUI(
        message: future,
        isLoadingMessage: false,
      ),
    ];
    String result = "";
    responseMessage = sendMessage(future.title)
      ..listen((event) {
        result += event;
      }).onDone(() {
        this.listMessage = [
          ...listMessage,
          MessageUI(
            message: Message(
              id: 0,
              createdAt: DateTime.now().millisecondsSinceEpoch,
              threadId: 0,
              title: result,
              role: "assistant",
            ),
            isLoadingMessage: false,
          ),
        ];
        responseMessage = null;
      });
  }

  Stream<String> sendMessage(String value) {
    // The user message to be sent to the request.
    final userMessage = OpenAIChatCompletionChoiceMessageModel(
      content: value,
      role: OpenAIChatMessageRole.user,
    );
    final chatStream = OpenAI.instance.chat.createStream(
      model: "gpt-3.5-turbo",
      messages: [userMessage],
      n: 2,
    );

    return chatStream.map((event) {
      String result = event.choices.last.delta.content ?? "";
      return result;
    }).distinct();
  }

  @action
  List<Thread> getAllThread() {
    return Hive.box<Thread>('thread').values.toList();
  }

  @action
  Future<void> addThread(Thread thread) async {
    await Hive.box<Thread>('thread').add(thread);
  }

  List<String> getAllMessage() {
    return [];
  }

  @action
  List<OpenAIChatCompletionChoiceMessageModel> getMessage() {
    //  OpenAI.instance.chat.
    return [];
  }

  // general:-------------------------------------------------------------------
  void init() async {}

  // dispose:-------------------------------------------------------------------
  dispose() {}
}
