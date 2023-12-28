// import 'package:chat_app/domain/entity/message/message.dart';

// class MessageUI {
//   Message message;
//   bool isLoadingMessage;
//   final Function(String message)? onDoneLoading;
//   Stream<String>? responseMessageStream;

//   MessageUI({
//     this.responseMessageStream,
//     this.message = const Message(
//       id: 0,
//       threadId: 0,
//       title: "",
//       createdAt: 0,
//       role: "assistant",
//     ),
//     this.isLoadingMessage = false,
//     this.onDoneLoading,
//   });

//   Stream<String> createResponseMessage() async* {
//     if (!isLoadingMessage) {
//       yield this.message.title;
//     } else if (responseMessageStream != null) {
//       yield* responseMessageStream!;
//     } else {
//       List<String> character = (message.title).split('');
//       String temp = "";
//       for (int i = 0; i < character.length; i++) {
//         await Future.delayed(Duration(milliseconds: 100));
//         temp += character[i];
//         yield temp;
//       }
//       if (onDoneLoading != null) onDoneLoading!(temp);
//     }
//     isLoadingMessage = false;
//   }
// }
