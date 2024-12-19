import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.icon,
    this.suffixIcon,
    this.isObscureText = false,
    this.onChanged,
  });

  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final Widget? suffixIcon;
  final bool isObscureText;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: isObscureText,
        onChanged: onChanged,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.blueGrey),
          prefixIcon: Icon(icon, color: Colors.blueGrey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                BorderSide(color: Colors.grey.withOpacity(0.5), width: 2),
          ),
          filled: true,
          fillColor: Colors.grey[100],
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
