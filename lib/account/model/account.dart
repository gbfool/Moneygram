import 'package:hive/hive.dart';

part 'account.g.dart';

@HiveType(typeId: 2)
class Account extends HiveObject {
  @HiveField(0)
  String emoji;

  @HiveField(1)
  String name;

  @HiveField(2)
  int? id;

  @HiveField(3, defaultValue: false)
  bool isSync;

  @HiveField(4)
  DateTime createdAt;

  @HiveField(5)
  DateTime updatedAt;

  Account(
      {this.id,
      this.isSync = false,
      required this.emoji,
      required this.name,
      required this.createdAt,
      required this.updatedAt});

  Map<String, dynamic> toJson() => {
        'emoji': emoji,
        'name': name,
        'id': id,
        'isSync': isSync,
        'createdAt': createdAt,
        'updatedAt': updatedAt
      };

  factory Account.fromJson(Map<String, dynamic> json) => Account(
      name: json["name"],
      emoji: json["emoji"],
      isSync: json['isSync'] ?? false,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'])
    ..id = json["id"];
}