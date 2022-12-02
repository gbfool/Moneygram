import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 3)
class Category extends HiveObject {
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

  Category(
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
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String()
      };

  String uniqueCode() {
    return "${id}#${createdAt.toIso8601String()}";
  }

  factory Category.fromJson(Map<String, dynamic> json) => Category(
      name: json["name"],
      emoji: json["emoji"],
      isSync: json['isSync'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']))
    ..id = json["id"];
}
