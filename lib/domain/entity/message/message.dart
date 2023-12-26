// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:chat_app/constants/hive_constant.dart';

part 'message.g.dart';

@HiveType(typeId: HiveConstant.messageHiveId)
class Message {
  @HiveField(0)
  int id;

  @HiveField(1)
  int threadId;

  @HiveField(2)
  String title;

  @HiveField(3)
  int createdAt;

  @HiveField(4)
  int? updatedAt;

  @HiveField(5)
  String status;

  @HiveField(6)
  String type;
  Message({
    required this.id,
    required this.threadId,
    required this.title,
    required this.createdAt,
    this.updatedAt,
    required this.status,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'conversationId': threadId,
      'title': title,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'status': status,
      'type': type,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as int,
      threadId: map['conversationId'] as int,
      title: map['title'] as String,
      createdAt: map['createdAt'] as int,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as int : null,
      status: map['status'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);
}
