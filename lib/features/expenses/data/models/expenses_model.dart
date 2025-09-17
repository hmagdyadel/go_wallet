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

  // Helper method to check if expense is from this week
  bool get isThisWeek {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final startOfWeekDate = DateTime(
      startOfWeek.year,
      startOfWeek.month,
      startOfWeek.day,
    );
    return createdAt.isAfter(
      startOfWeekDate.subtract(const Duration(seconds: 1)),
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