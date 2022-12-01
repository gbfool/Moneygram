import 'package:hive/hive.dart';
import 'package:moneygram/utils/enum/transaction_type.dart';

part 'transaction.g.dart';

@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveField(0)
  String? notes;

  @HiveField(1)
  double amount;

  @HiveField(2)
  TransactionType type;

  @HiveField(3)
  int accountId;

  @HiveField(4)
  int categoryId;

  @HiveField(5)
  DateTime time;

  @HiveField(6)
  int? id;

  @HiveField(7, defaultValue: false)
  bool isSync;

  Transaction({
    this.notes,
    this.id,
    this.isSync = false,
    required this.amount,
    required this.time,
    required this.categoryId,
    required this.accountId,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
        'notes': notes,
        'amount': amount,
        'time': time.toIso8601String(),
        'type': type.nameString,
        'accountId': accountId,
        'categoryId': categoryId,
        'id': id,
        'is_sync': isSync
      };

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
      notes: json['notes'],
      amount: json['amount'],
      time: DateTime.parse(json['time']),
      categoryId: json['categoryId'],
      accountId: json['accountId'],
      type: (json['type'] as String).type,
      isSync: json['is_sync'] ?? false)
    ..id = json['id'];
}
