import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AmountInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final result = int.tryParse(newValue.text);

    if (result == null) {
      return newValue;
    }

    final formatted = "${NumberFormat("###,###,###,###").format(result)}원";

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length - 1),
    );
  }
}
