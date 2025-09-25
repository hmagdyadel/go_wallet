



import 'package:flutter/services.dart';

class UsernameFormatter extends TextInputFormatter {
  final String suffix = '@gowallet';

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;

    // Remove @gowallet if pasted
    if (text.endsWith(suffix)) {
      text = text.replaceAll(suffix, '');
    }

    // Remove all non-letter characters
    text = text.replaceAll(RegExp(r'[^a-zA-Z]'), '');

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class PhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(RegExp(r'[^0-9]'), ''); // Only digits

    // Limit to 11 digits
    if (text.length > 11) {
      text = text.substring(0, 11);
    }

    // Must start with 010, 011, 012, or 015
    if (text.isNotEmpty) {
      if (text.length >= 3) {
        String prefix = text.substring(0, 3);
        if (!['010', '011', '012', '015'].contains(prefix)) {
          // If invalid prefix, keep the old value
          return oldValue;
        }
      } else if (text.length >= 2) {
        String prefix = text.substring(0, 2);
        if (!['01'].contains(prefix)) {
          return oldValue;
        }
      } else if (text.length >= 1) {
        if (text[0] != '0') {
          return oldValue;
        }
      }
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}