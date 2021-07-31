import 'package:fastcheque/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.textCtrl,
    required this.iconData,
    required this.hint,
  }) : super(key: key);

  final TextEditingController textCtrl;
  final IconData iconData;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding),
      child: TextField(
        keyboardType: TextInputType.text,
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
