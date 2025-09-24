import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/strings.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(const HomeStates.initial());

  final TextEditingController expenseAmount = TextEditingController();
  final TextEditingController usernameController = TextEditingController();


  double _currentAmount = 0.0;
  bool _isManualInput = false;
  bool _isUsername = true;

  double get currentAmount => _currentAmount;
  bool get isManualInput => _isManualInput;
  bool get isUsername => _isUsername;
  String get fullUsername => '${usernameController.text}@gowallet';


  void setUsername(String value) {
    //usernameController.text = value;
    emit(const HomeStates.loaded());
  }
  // Transfer method selection
  void setTransferMethod(bool isUsername) {
    emit(const HomeStates.toggleMethod());
    _isUsername = isUsername;
    emit(const HomeStates.loaded());
  }

  void onAmountChanged(String value) {
    emit(const HomeStates.toggleMethod());
    _isManualInput = true;
    if (value.isEmpty) {
      _currentAmount = 0.0;
      _isManualInput = false;
    } else {
      double newAmount = double.tryParse(value) ?? 0.0;
      _currentAmount = newAmount > balance ? balance.toDouble() : newAmount;

      if (newAmount > balance) {
        expenseAmount.text = balance.toString();
      }
    }
    emit(const HomeStates.loaded());
  }

  void incrementAmount(double increment) {
    emit(const HomeStates.toggleMethod());
    double newAmount = _currentAmount + increment;

    // Don't allow amount to exceed balance
    if (newAmount > balance) {
      _currentAmount = balance.toDouble();
    } else {
      _currentAmount = newAmount;
    }

    _isManualInput = false;
    expenseAmount.text = _currentAmount.toInt().toString();
    emit(const HomeStates.loaded());
  }

}
