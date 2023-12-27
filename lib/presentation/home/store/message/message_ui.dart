import 'package:chat_app/domain/entity/message/message.dart';
import 'package:flutter/material.dart';

class MessageUI {
  Message? message;
  bool isLoadingMessage;
  final Function(String message)? onDoneLoading;
  final Stream<String>? streamString;

  MessageUI({
    this.streamString,
    this.message,
    this.isLoadingMessage = false,
    this.onDoneLoading,
  });

  Stream<String> createResponseMessage() async* {
    if (!isLoadingMessage) {
      yield this.message?.title ?? "";
    } else if (streamString != null) {
      yield* streamString!;
    } else {
      List<String> character = (message?.title ?? "").split('');
      String temp = "";
      for (int i = 0; i < character.length; i++) {
        await Future.delayed(Duration(milliseconds: 100));
        temp += character[i];
        yield temp;
      }
      if (onDoneLoading != null) onDoneLoading!(temp);
    }
    isLoadingMessage = false;
  }
}
