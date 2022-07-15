import 'package:flutter/material.dart';
import 'package:test_task/presentation/login/login_page.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    Key? key,
    required this.controller,
    required this.textFieldType,
    required this.hint,
  }) : super(key: key);

  final TextEditingController controller;

  final AuthTextFieldType textFieldType;

  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: AuthTextFieldType.password == textFieldType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: AuthTextFieldType.email == textFieldType
          ? TextInputType.emailAddress
          : null,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "This field is required";
        }
        return null;
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hint,
      ),
    );
  }
}
