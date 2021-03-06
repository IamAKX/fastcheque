import 'package:fastcheque/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.textCtrl,
    required this.iconData,
    required this.hint,
    this.textInputType,
    this.enabled,
  }) : super(key: key);

  final TextEditingController textCtrl;
  final IconData iconData;
  final String hint;
  final TextInputType? textInputType;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding),
      child: TextField(
        enabled: enabled != null ? enabled : true,
        keyboardType:
            textInputType == null ? TextInputType.text : textInputType,
        autocorrect: true,
        controller: textCtrl,
        decoration: InputDecoration(
          hintText: hint,
          labelText: hint,
          prefixIcon: Icon(iconData),
        ),
      ),
    );
  }
}
