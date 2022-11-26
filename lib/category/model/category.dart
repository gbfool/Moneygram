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

  Category({required this.emoji, required this.name});

  Map<String, dynamic> toJson() => {
        'emoji': emoji,
        'name': name,
        'id': id,
      };

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        emoji: json["emoji"],
      )..id = json["id"];
}
