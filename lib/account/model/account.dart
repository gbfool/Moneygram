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

  Account({required this.emoji, required this.name});

  Map<String, dynamic> toJson() => {
        'emoji': emoji,
        'name': name,
        'id': id,
      };

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        name: json["name"],
        emoji: json["emoji"],
      )..id = json["id"];
}
