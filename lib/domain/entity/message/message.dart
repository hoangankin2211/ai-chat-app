// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:chat_app/domain/entity/message/role.dart';
import 'package:hive/hive.dart';

import 'package:chat_app/constants/hive_constant.dart';

part 'message.g.dart';

@HiveType(typeId: HiveConstant.messageHiveId)
class Message {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int threadId;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final int createdAt;

  @HiveField(4)
  final int? updatedAt;

  @HiveField(6)
  final String role;

  const Message({
    required this.id,
    required this.threadId,
    required this.title,
    required this.createdAt,
    this.updatedAt,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'conversationId': threadId,
      'title': title,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'type': role,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as int,
      threadId: map['conversationId'] as int,
      title: map['title'] as String,
      createdAt: map['createdAt'] as int,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as int : null,
      role:
          Role.values.firstWhere((element) => element.name == map['type']).name,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  Message copyWith({
    int? id,
    int? threadId,
    String? title,
    int? createdAt,
    int? updatedAt,
    String? status,
    String? role,
  }) {
    return Message(
      id: id ?? this.id,
      threadId: threadId ?? this.threadId,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      role: role ?? this.role,
    );
  }
}
