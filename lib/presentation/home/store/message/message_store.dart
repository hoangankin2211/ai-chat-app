import 'package:chat_app/core/stores/error/error_store.dart';
import 'package:chat_app/domain/entity/message/message.dart';
import 'package:chat_app/domain/entity/message/role.dart';
import 'package:chat_app/domain/entity/thread/thread.dart';
import 'package:chat_app/domain/usecase/message/add_new_message_usecase.dart';
import 'package:chat_app/domain/usecase/message/get_thread_message_usecase.dart';
import 'package:chat_app/domain/usecase/thread/insert_thread_usecase.dart';
import 'package:dart_openai/dart_openai.dart';
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
  ) {}

  static ObservableFuture<List<Message>> emptyMessageResponse =
      ObservableFuture.value([]);

  @observable
  ObservableList<Message> listMessage = ObservableList();

  @observable
  Thread? thread;

  @observable
  bool success = false;

  @observable
  bool loadingMessage = false;

  @observable
  ObservableMap<int, Message> responseMessageMap = ObservableMap();

  @computed
  bool get loading => fetchMessagesFuture.status == FutureStatus.pending;

  @computed
  bool get addMessageSuccess =>
      fetchMessagesFuture.status == FutureStatus.fulfilled;

  @observable
  ObservableFuture<List<Message>> fetchMessagesFuture =
      ObservableFuture<List<Message>>(emptyMessageResponse);

  @computed
  Message? get getResponseMessage => responseMessageMap[thread?.id];

  // actions:-------------------------------------------------------------------

  @action
  Future<void> changeThread({Thread? thread}) async {
    if (this.thread != null && thread == null) {
      listMessage.clear();
      this.thread = null;
      return;
    }
    if (this.thread != null && thread != null && this.thread!.id == thread.id) {
      return;
    }

    this.thread = thread;
    getMessages();
  }

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
    loadingMessage = true;

    await Future.delayed(Duration(milliseconds: 150));

    final future = _getThreadMessageUseCase.call(params: thread!.id);

    fetchMessagesFuture = ObservableFuture(future.then((value) => value ?? []));

    future.then((messageList) {
      this.listMessage.clear();
      this.listMessage.addAll(messageList ?? []);
    }).catchError((error) {
      errorStore.errorMessage = error.toString();
    });

    loadingMessage = false;
  }

  @action
  Future sendMessage({required String message, required Role role}) async {
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

    _addToMessageList(future);

    createOpenAiStream(future.title).listen(_updateResponseMessage).onDone(
      () async {
        final responseMessage = responseMessageMap[thread!.id];
        _addToMessageList(
            await _addNewMessageUseCase.call(params: responseMessage!));
        responseMessageMap.remove(thread!.id);
      },
    );
  }

  @action
  void _addToMessageList(Message newMessage) {
    this.listMessage.add(newMessage);
  }

  @action
  void _updateResponseMessage(String event) {
    final responseMessage = responseMessageMap[thread!.id];

    if (responseMessage != null) {
      responseMessageMap.addAll({
        thread!.id: responseMessage.copyWith(
          title: responseMessage.title + event,
        )
      });
    } else {
      responseMessageMap.addAll({
        thread!.id: Message(
          id: 0,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          threadId: thread!.id,
          title: event,
          role: Role.assistant.name,
        )
      });
    }
  }

  Stream<String> createOpenAiStream(String value) {
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

    return chatStream
        .map((event) {
          String result = event.choices.last.delta.content ?? "";
          return result;
        })
        .distinct()
        .asyncExpand((event) async* {
          await Future.delayed(const Duration(milliseconds: 100));
          yield event;
        });
  }

  // dispose:-------------------------------------------------------------------
  dispose() {
    thread = null;
    success = false;
    loadingMessage = false;
  }
}
