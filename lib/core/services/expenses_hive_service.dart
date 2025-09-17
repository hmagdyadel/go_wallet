import 'package:hive/hive.dart';

import '../../features/expenses/data/models/expenses_model.dart';

class ExpensesHiveService {
  static const String _boxName = 'expenses_box';
  static const String _categoriesBoxName = 'categories_box';
  Box<ExpenseModel>? _expensesBox;
  Box<String>? _categoriesBox;

  // Initialize Hive boxes
  Future<void> init() async {
    try {
      _expensesBox = await Hive.openBox<ExpenseModel>(_boxName);
      _categoriesBox = await Hive.openBox<String>(_categoriesBoxName);
    } catch (e) {
      throw Exception('Failed to initialize expenses box: $e');
    }
  }

  // Get the expenses box instance
  Box<ExpenseModel> get box {
    if (_expensesBox == null || !_expensesBox!.isOpen) {
      throw Exception('Expenses box is not initialized. Call init() first.');
    }
    return _expensesBox!;
  }

  // Get the categories box instance
  Box<String> get categoriesBox {
    if (_categoriesBox == null || !_categoriesBox!.isOpen) {
      throw Exception('Categories box is not initialized. Call init() first.');
    }
    return _categoriesBox!;
  }

  // Add new expense
  Future<void> addExpense(ExpenseModel expense) async {
    try {
      await box.add(expense);
      // Save category if it doesn't exist
      await _saveCategoryIfNotExists(expense.category);
    } catch (e) {
      throw Exception('Failed to add expense: $e');
    }
  }

  // Save category if it doesn't exist
  Future<void> _saveCategoryIfNotExists(String category) async {
    try {
      final existingCategories = getSavedCategories();
      if (!existingCategories.contains(category.toLowerCase())) {
        await categoriesBox.add(category);
      }
    } catch (e) {
      throw Exception('Failed to save category: $e');
    }
  }

  // Get all saved categories
  List<String> getSavedCategories() {
    try {
      return categoriesBox.values.toList();
    } catch (e) {
      return [];
    }
  }

  // Get category suggestions based on input
  List<String> getCategorySuggestions(String input) {
    try {
      if (input.isEmpty) return getSavedCategories();

      final allCategories = getSavedCategories();
      return allCategories
          .where((category) =>
          category.toLowerCase().contains(input.toLowerCase()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  // Get all expenses
  List<ExpenseModel> getAllExpenses() {
    try {
      return box.values.toList();
    } catch (e) {
      throw Exception('Failed to get expenses: $e');
    }
  }

  // Get expenses by user code
  List<ExpenseModel> getExpensesByUserCode(String userCode) {
    try {
      return box.values
          .where((expense) => expense.userCode == userCode)
          .toList();
    } catch (e) {
      throw Exception('Failed to get expenses by user code: $e');
    }
  }

  // Get today's expenses for a user
  List<ExpenseModel> getTodayExpenses(String userCode) {
    try {
      return getExpensesByUserCode(
        userCode,
      ).where((expense) => expense.isToday).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt)); // Latest first
    } catch (e) {
      throw Exception('Failed to get today expenses: $e');
    }
  }

  // Get this week's expenses for a user
  List<ExpenseModel> getThisWeekExpenses(String userCode) {
    try {
      return getExpensesByUserCode(
        userCode,
      ).where((expense) => expense.isThisWeek).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt)); // Latest first
    } catch (e) {
      throw Exception('Failed to get week expenses: $e');
    }
  }

  // Get this month's expenses for a user
  List<ExpenseModel> getThisMonthExpenses(String userCode) {
    try {
      return getExpensesByUserCode(
        userCode,
      ).where((expense) => expense.isThisMonth).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt)); // Latest first
    } catch (e) {
      throw Exception('Failed to get month expenses: $e');
    }
  }

  // Get expenses by date range
  List<ExpenseModel> getExpensesByDateRange(
      String userCode,
      DateTime startDate,
      DateTime endDate,
      ) {
    try {
      return getExpensesByUserCode(userCode)
          .where(
            (expense) =>
        expense.createdAt.isAfter(
          startDate.subtract(const Duration(seconds: 1)),
        ) &&
            expense.createdAt.isBefore(
              endDate.add(const Duration(days: 1)),
            ),
      )
          .toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt)); // Latest first
    } catch (e) {
      throw Exception('Failed to get expenses by date range: $e');
    }
  }

  // Update expense
  Future<void> updateExpense(int index, ExpenseModel expense) async {
    try {
      await box.putAt(index, expense);
      // Save category if it doesn't exist
      await _saveCategoryIfNotExists(expense.category);
    } catch (e) {
      throw Exception('Failed to update expense: $e');
    }
  }

  // Delete expense by index
  Future<void> deleteExpense(int index) async {
    try {
      await box.deleteAt(index);
    } catch (e) {
      throw Exception('Failed to delete expense: $e');
    }
  }

  // Delete expense by id
  Future<void> deleteExpenseById(String expenseId) async {
    try {
      final expenses = box.values.toList();
      for (int i = 0; i < expenses.length; i++) {
        if (expenses[i].id == expenseId) {
          await box.deleteAt(i);
          break;
        }
      }
    } catch (e) {
      throw Exception('Failed to delete expense by id: $e');
    }
  }

  // Get total amount for today
  double getTodayTotal(String userCode) {
    try {
      return getTodayExpenses(
        userCode,
      ).fold(0.0, (total, expense) => total + expense.amount);
    } catch (e) {
      throw Exception('Failed to get today total: $e');
    }
  }

  // Get total amount for this week
  double getThisWeekTotal(String userCode) {
    try {
      return getThisWeekExpenses(
        userCode,
      ).fold(0.0, (total, expense) => total + expense.amount);
    } catch (e) {
      throw Exception('Failed to get week total: $e');
    }
  }

  // Get total amount for this month
  double getThisMonthTotal(String userCode) {
    try {
      return getThisMonthExpenses(
        userCode,
      ).fold(0.0, (total, expense) => total + expense.amount);
    } catch (e) {
      throw Exception('Failed to get month total: $e');
    }
  }

  // Clear all expenses
  Future<void> clearAllExpenses() async {
    try {
      await box.clear();
    } catch (e) {
      throw Exception('Failed to clear all expenses: $e');
    }
  }

  // Clear all categories
  Future<void> clearAllCategories() async {
    try {
      await categoriesBox.clear();
    } catch (e) {
      throw Exception('Failed to clear all categories: $e');
    }
  }

  // Close the boxes
  Future<void> close() async {
    try {
      await _expensesBox?.close();
      await _categoriesBox?.close();
    } catch (e) {
      throw Exception('Failed to close expenses boxes: $e');
    }
  }
}