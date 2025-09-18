import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/strings.dart';
import '../../../core/helpers/enums.dart';
import '../../../core/services/expenses_hive_service.dart';
import '../data/models/expenses_model.dart';
import 'expenses_states.dart';

class ExpensesCubit extends Cubit<ExpensesStates> {
  ExpensesCubit(this._hiveService) : super(const ExpensesStates.initial()) {
    _initializeService();
  }

  final ExpensesHiveService _hiveService;

  final TextEditingController expenseTitle = TextEditingController();
  final TextEditingController expenseAmount = TextEditingController();
  final TextEditingController expenseCategory = TextEditingController();

  double _currentAmount = 0.0;
  bool _isManualInput = false;
  List<ExpenseModel> _expenses = [];
  ExpensesType _currentFilter = ExpensesType.today;
  List<String> _categorySuggestions = [];

  // Getters
  double get currentAmount => _currentAmount;

  bool get isManualInput => _isManualInput;

  List<ExpenseModel> get expenses => _expenses;

  ExpensesType get currentFilter => _currentFilter;

  List<String> get categorySuggestions => _categorySuggestions;

  Future<void> _initializeService() async {
    try {
      await _hiveService.init();
      await loadExpenses();
    } catch (e) {
      emit(ExpensesStates.error(message: 'Failed to initialize service: $e'));
    }
  }

  void onAmountChanged(String value) {
    _isManualInput = true;
    if (value.isEmpty) {
      _currentAmount = 0.0;
      _isManualInput = false;
    } else {
      _currentAmount = double.tryParse(value) ?? 0.0;
    }
    emit(const ExpensesStates.loaded());
  }

  void onCategoryChanged(String value) {
    emit(const ExpensesStates.loadingCategory());
    if (value.isEmpty) {
      _categorySuggestions = [];
    } else {
      _loadCategorySuggestions(value);
    }
    emit(const ExpensesStates.loaded());
  }

  void _loadCategorySuggestions(String input) {
    try {
      List<String> suggestions = _hiveService.getCategorySuggestions(input);

      // Remove duplicates by converting to Set and back to List
      suggestions = suggestions.toSet().toList();

      // If no suggestions found but user is typing, provide default categories
      if (suggestions.isEmpty && input.isNotEmpty) {
        suggestions = _getDefaultCategories()
            .where((category) => category.toLowerCase().contains(input.toLowerCase()))
            .toList();
      }

      _categorySuggestions = suggestions;
    } catch (e) {
      // If there's an error and user is typing, provide filtered default categories
      if (input.isNotEmpty) {
        _categorySuggestions = _getDefaultCategories()
            .where((category) => category.toLowerCase().contains(input.toLowerCase()))
            .toList();
      } else {
        _categorySuggestions = [];
      }
    }
  }

  List<String> _getDefaultCategories() {
    return [
      "food_dining".tr(),
      "transportation".tr(),
      "shopping".tr(),
      "entertainment".tr(),
      "bills_utilities".tr(),
      "healthcare".tr(),
      "education".tr(),
      "travel".tr(),
      "personal_care".tr(),
      "groceries".tr(),
      "gas_fuel".tr(),
      "home_garden".tr(),
      "clothing".tr(),
      "technology".tr(),
      "sports_fitness".tr(),
      "others".tr(),
    ];
  }



  void selectCategory(String category) {
    emit(const ExpensesStates.loadingCategory());
    expenseCategory.text = category;
    _categorySuggestions = [];
    emit(const ExpensesStates.loaded());
  }

  void incrementAmount(double increment) {
    _currentAmount += increment;
    _isManualInput = false;
    expenseAmount.text = _currentAmount.toInt().toString();
    emit(const ExpensesStates.loaded());
  }

  void resetAmount() {
    _currentAmount = 0.0;
    _isManualInput = false;
    expenseAmount.text = "0";
    emit(const ExpensesStates.loaded());
  }

  void clearAllInputs() {
    expenseTitle.clear();
    expenseAmount.clear();
    expenseCategory.clear();
    _currentAmount = 0.0;
    _isManualInput = false;
    _categorySuggestions = [];
    emit(const ExpensesStates.loaded());
  }

  // Add new expense
  Future<void> addExpense() async {
    try {
      // Validation
      if (expenseTitle.text.trim().isEmpty) {
        emit(const ExpensesStates.error(message: 'Please enter expense title'));
        return;
      }

      if (_currentAmount <= 0) {
        emit(
          const ExpensesStates.error(message: 'Please enter a valid amount'),
        );
        return;
      }

      if (expenseCategory.text.trim().isEmpty) {
        emit(
          const ExpensesStates.error(message: 'Please enter expense category'),
        );
        return;
      }

      emit(const ExpensesStates.loading());

      final expense = ExpenseModel(
        userCode: userCode,
        title: expenseTitle.text.trim(),
        amount: _currentAmount,
        category: expenseCategory.text.trim(),
      );

      await _hiveService.addExpense(expense);

      // Clear inputs after successful addition
      clearAllInputs();

      // Reload expenses
      emit(ExpensesStates.success('Expense added successfully'));
      await loadExpenses();
    } catch (e) {
      emit(ExpensesStates.error(message: 'Failed to add expense: $e'));
    }
  }

  // Load expenses based on current filter
  Future<void> loadExpenses() async {
    try {
      emit(const ExpensesStates.loading());

      switch (_currentFilter) {
        case ExpensesType.today:
          _expenses = _hiveService.getTodayExpenses(userCode);
          break;
        case ExpensesType.lastWeek:
          _expenses = _hiveService.getThisWeekExpenses(userCode);
          break;
        case ExpensesType.lastMonth:
          _expenses = _hiveService.getThisMonthExpenses(userCode);
          break;
      }
      emit(const ExpensesStates.loaded());
      if (_expenses.isEmpty) {
        emit(const ExpensesStates.empty());
      }
    } catch (e) {
      emit(ExpensesStates.error(message: 'Failed to load expenses: $e'));
    }
  }

  // Change time filter
  Future<void> changeTimeFilter(ExpensesType filter) async {
    if (_currentFilter != filter) {
      _currentFilter = filter;
      await loadExpenses();
    }
  }

  // Get total amount for current filter
  double getCurrentTotal() {
    try {
      switch (_currentFilter) {
        case ExpensesType.today:
          return _hiveService.getTodayTotal(userCode);
        case ExpensesType.lastWeek:
          return _hiveService.getThisWeekTotal(userCode);
        case ExpensesType.lastMonth:
          return _hiveService.getThisMonthTotal(userCode);
      }
    } catch (e) {
      return 0.0;
    }
  }

  // Delete expense
  Future<void> deleteExpense(String expenseId) async {
    try {
      emit(const ExpensesStates.loading());

      await _hiveService.deleteExpenseById(expenseId);
      await loadExpenses();

      emit(ExpensesStates.success('Expense deleted successfully'));
    } catch (e) {
      emit(ExpensesStates.error(message: 'Failed to delete expense: $e'));
    }
  }

  // Update expense
  Future<void> updateExpense(ExpenseModel updatedExpense) async {
    try {
      emit(const ExpensesStates.loading());

      // Find the expense index and update
      final allExpenses = _hiveService.getAllExpenses();
      for (int i = 0; i < allExpenses.length; i++) {
        if (allExpenses[i].id == updatedExpense.id) {
          await _hiveService.updateExpense(i, updatedExpense);
          break;
        }
      }

      await loadExpenses();
      emit(ExpensesStates.success('Expense updated successfully'));
    } catch (e) {
      emit(ExpensesStates.error(message: 'Failed to update expense: $e'));
    }
  }

  @override
  Future<void> close() {
    expenseTitle.dispose();
    expenseAmount.dispose();
    expenseCategory.dispose();
    return super.close();
  }
}

//dropdown_flutter
