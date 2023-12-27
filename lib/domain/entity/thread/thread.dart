import 'package:hive/hive.dart';

import 'package:chat_app/constants/hive_constant.dart';

part 'thread.g.dart';

@HiveType(typeId: HiveConstant.threadHiveId)
class Thread extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int createdAt;

  @HiveField(2)
  String? header;

  @HiveField(3)
  String? title;

  @HiveField(4)
  String? lastMessage;

  @HiveField(5)
  int? lastUpdate;

  Thread({
    required this.id,
    required this.createdAt,
    this.header,
    this.title,
    this.lastMessage,
    this.lastUpdate,
  });

  Thread copyWith({
    int? id,
    int? createdAt,
    String? header,
    String? title,
    String? lastMessage,
    int? lastUpdate,
  }) {
    return Thread(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      header: header ?? this.header,
      title: title ?? this.title,
      lastMessage: lastMessage ?? this.lastMessage,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }
}
