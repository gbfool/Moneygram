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

  Account(
      {this.id, this.isSync = false, required this.emoji, required this.name});

  Map<String, dynamic> toJson() =>
      {'emoji': emoji, 'name': name, 'id': id, 'isSync': isSync};

  factory Account.fromJson(Map<String, dynamic> json) => Account(
      name: json["name"], emoji: json["emoji"], isSync: json['isSync'] ?? false)
    ..id = json["id"];
}
