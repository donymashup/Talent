import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;

  const CustomTextField({
    required this.labelText,
    required this.hintText,
    this.isPassword = false,
    this.controller,
    super.key,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = true; // Default to obscured text for password fields
  static String? passwordValue; // Store password temporarily

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText:
          widget.isPassword ? _isObscured : false, // Conditionally obscure text
      decoration: InputDecoration(
        fillColor: Colors.white, // Set background color to white
        filled: true, // Ensure the fill color is applied
        labelText: widget.labelText,
        hintText: widget.hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          borderSide: BorderSide(
            color: Colors.brown, // Change stroke color to red
            width: 2.0, // Add stroke width
          ),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "${widget.labelText} is required";
        }

        // Email validation
        if (widget.labelText == "Email") {
          final emailRegex =
              RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
          if (!emailRegex.hasMatch(value)) {
            return "Enter a valid email";
          }
        }

        // Password validation (Minimum 6 characters)
        if (widget.labelText == "Password") {
          if (value.length < 6) {
            return "Password must be at least 6 characters";
          }
          passwordValue = value; // Save password locally
        }

        // Confirm Password validation
        if (widget.labelText == "Confirm Password") {
          if (value.length < 6) {
            return "Password must be at least 6 characters";
          }
          if (value != passwordValue) {
            return "Passwords do not match";
          }
        }

        return null; // No validation errors
      },
    );
  }
}
