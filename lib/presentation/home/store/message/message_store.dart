import 'package:chat_app/domain/entity/thread/thread.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

part 'message_store.g.dart';

class MessageStore = _MessageStore with _$MessageStore;

abstract class _MessageStore with Store {
  // constructor:---------------------------------------------------------------
  _MessageStore() {
    init();
  }

  // actions:-------------------------------------------------------------------
  @action
  Stream<OpenAIStreamChatCompletionModel> sendMessage(String value) {
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
    return chatStream;
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
