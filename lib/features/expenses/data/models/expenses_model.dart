import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

part 'expenses_model.g.dart';

@HiveType(typeId: 0)
class ExpenseModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userCode;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  final String title;

  @HiveField(4)
  final double amount;

  @HiveField(5)
  final String category;

  ExpenseModel({
    String? id,
    required this.userCode,
    DateTime? createdAt,
    required this.title,
    required this.amount,
    required this.category,
  }) : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  // Formatted date string like "03 Aug 2025 09:15 AM"
  String get formattedDate {
    return DateFormat('dd MMM yyyy hh:mm a').format(createdAt);
  }

  // Helper method to check if expense is from today
  bool get isToday {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final expenseDate = DateTime(
      createdAt.year,
      createdAt.month,
      createdAt.day,
    );
    return expenseDate == today;
  }

  // Helper method to check if expense is from last week (past 7 days)
  bool get isLastWeek {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    final sevenDaysAgoDate = DateTime(
      sevenDaysAgo.year,
      sevenDaysAgo.month,
      sevenDaysAgo.day,
    );
    final expenseDate = DateTime(
      createdAt.year,
      createdAt.month,
      createdAt.day,
    );
    return expenseDate.isAfter(sevenDaysAgoDate) && expenseDate.isBefore(
      DateTime(now.year, now.month, now.day).add(const Duration(days: 1)),
    );
  }

  // Helper method to check if expense is from last month (past 30 days)
  bool get isLastMonth {
    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));
    final thirtyDaysAgoDate = DateTime(
      thirtyDaysAgo.year,
      thirtyDaysAgo.month,
      thirtyDaysAgo.day,
    );
    final expenseDate = DateTime(
      createdAt.year,
      createdAt.month,
      createdAt.day,
    );
    return expenseDate.isAfter(thirtyDaysAgoDate) && expenseDate.isBefore(
      DateTime(now.year, now.month, now.day).add(const Duration(days: 1)),
    );
  }

  // Helper method to check if expense is from this month
  bool get isThisMonth {
    final now = DateTime.now();
    return createdAt.year == now.year && createdAt.month == now.month;
  }

  // Copy method for updates
  ExpenseModel copyWith({
    String? id,
    String? userCode,
    DateTime? createdAt,
    String? title,
    double? amount,
    String? category,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      userCode: userCode ?? this.userCode,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
    );
  }

  @override
  String toString() {
    return 'ExpenseModel(id: $id, userCode: $userCode, createdAt: $createdAt, title: $title, amount: $amount, category: $category)';
  }
}