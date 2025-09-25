import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_contact_picker_plus/flutter_native_contact_picker_plus.dart';
import 'package:flutter_native_contact_picker_plus/model/contact_model.dart';

import '../../../core/constants/strings.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(const HomeStates.initial());

  final TextEditingController expenseAmount = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final FlutterContactPickerPlus _contactPicker = FlutterContactPickerPlus();


  double _currentAmount = 0.0;
  bool _isManualInput = false;
  bool _isUsername = true;

  double get currentAmount => _currentAmount;
  bool get isManualInput => _isManualInput;
  bool get isUsername => _isUsername;
  String get fullUsername => '${usernameController.text}@gowallet';


  // void setUsername(String value) {
  //   usernameController.text = value;
  //   log("username: ${usernameController.text}");
  //  // emit(const HomeStates.loaded());
  // }
  void setTransferMethod(bool isUsername) {
    if (_isUsername != isUsername) {
      _isUsername = isUsername;
      // Clear the text when switching to prevent cross-contamination
      if (isUsername) {
        phoneController.clear();
      } else {
        usernameController.clear();
      }
      emit(HomeStates.transferMethodChanged(isUsername));
    }
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

  Future<void> openContactPicker() async {
    try {
      // This opens the native contacts app and returns selected contact
      Contact? contact = await _contactPicker.selectContact();

      if (contact != null && contact.phoneNumbers != null && contact.phoneNumbers!.isNotEmpty) {
        // Use the first phone number if multiple exist
        String selectedPhone = contact.phoneNumbers!.first;
        setPhoneNumber(selectedPhone);
      }
    } catch (e) {
      log("Error opening contacts: $e");
    }
  }

  void setPhoneNumber(String rawPhone) {
    String cleanPhone = _formatEgyptianPhone(rawPhone);
    if (cleanPhone.isNotEmpty) {
      phoneController.text = cleanPhone;
      emit(const HomeStates.loaded());
    }
  }

  String _formatEgyptianPhone(String rawPhone) {
    // Remove all non-digits
    String digits = rawPhone.replaceAll(RegExp(r'[^0-9]'), '');

    // Handle different formats
    if (digits.startsWith('2010') || digits.startsWith('2011') ||
        digits.startsWith('2012') || digits.startsWith('2015')) {
      // Remove country code +20
      digits = digits.substring(2);
    } else if (digits.startsWith('20') && digits.length == 13) {
      // Remove country code 20
      digits = digits.substring(2);
    }

    // Ensure it's 11 digits starting with 01
    if (digits.length == 11 && digits.startsWith('01') &&
        ['010', '011', '012', '015'].any((prefix) => digits.startsWith(prefix))) {
      return digits;
    }

    return '';
  }

}
