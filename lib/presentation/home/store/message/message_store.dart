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
  bool isWaitingMessageResponse = false;

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
  Message? get getResponseMessage =>
      this.thread != null ? responseMessageMap[this.thread!.id!] : null;

  // actions:-------------------------------------------------------------------

  @action
  Future<void> changeThread({Thread? thread}) async {
    print("this.thread!.id :${this.thread?.id}");
    print("thread.id :${thread?.id}");

    if (this.thread == null && thread == null) {
      this.listMessage.clear();
      return;
    } else if (this.thread == null && thread != null) {
      this.thread = thread;
    } else if (this.thread != null && thread == null) {
      this.thread = null;
      this.listMessage.clear();
      return;
    }

    responseMessageMap.remove(this.thread!.id!);
    this.thread = thread;
    getMessages();
  }

  @action
  Future getMessages() async {
    if (thread == null) {
      // this.thread = await _insertThreadUseCase.call(
      //   params: Thread(
      //     createdAt: DateTime.now().millisecondsSinceEpoch,
      //   ),
      // );

      return;
    }

    loadingMessage = true;

    await Future.delayed(Duration(milliseconds: 150));

    final future = thread!.id != null
        ? _getThreadMessageUseCase.call(params: thread!.id!)
        : Future.value([] as List<Message>);

    fetchMessagesFuture = ObservableFuture(future.then((value) => value ?? []));

    future.then((messageList) {
      this.listMessage.clear();
      this.listMessage.addAll((messageList ?? [])
        ..sort(
          (a, b) {
            return a.createdAt.compareTo(b.createdAt);
          },
        ));
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
          createdAt: DateTime.now().millisecondsSinceEpoch,
          title: message,
        ),
      );
    }

    final future = await _addNewMessageUseCase.call(
      params: Message(
        threadId: thread!.id!,
        title: message,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        role: role.name,
      ),
    );

    _addToMessageList(future);

    isWaitingMessageResponse = true;

    final aiResponse = await createOpenAI(future.title);
    final threadId = thread!.id!;
    final _role = Role.assistant.name;
    final createTime = DateTime.now().millisecondsSinceEpoch;

    isWaitingMessageResponse = false;

    responseMessageMap.addAll({
      thread!.id!: Message(
        createdAt: createTime,
        threadId: threadId,
        title: "",
        role: _role,
      )
    });

    createStream(aiResponse).listen(_updateResponseMessage).onDone(
      () async {
        _addToMessageList(
          await _addNewMessageUseCase.call(
            params: Message(
              createdAt: createTime,
              threadId: threadId,
              title: aiResponse,
              role: _role,
            ),
          ),
        );

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
        thread!.id!: responseMessage.copyWith(
          title: responseMessage.title + event,
        )
      });
    }
  }

  Future<String> createOpenAI(String value) async {
    final userMessage = OpenAIChatCompletionChoiceMessageModel(
      role: OpenAIChatMessageRole.user,
      content: value,
    );

    final messageResponse = await OpenAI.instance.chat.create(
      model: "gpt-3.5-turbo",
      messages: [
        ...listMessage.map(
          (element) => OpenAIChatCompletionChoiceMessageModel(
            role: element.role == Role.assistant.name
                ? OpenAIChatMessageRole.assistant
                : OpenAIChatMessageRole.user,
            content: element.title,
          ),
        ),
        userMessage
      ],
    );

    print(messageResponse.choices);

    return messageResponse.choices.first.message.content;
  }

  Stream<String> createStream(String value) async* {
    List<String> character = value.split('');
    for (int i = 0; i < character.length; i++) {
      await Future.delayed(Duration(milliseconds: 50));
      yield character[i];
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
