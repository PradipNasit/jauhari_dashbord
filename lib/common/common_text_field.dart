import 'package:flutter/material.dart';
import 'package:jauhari_dashbord/Helper/color_helper.dart';

class CommonTextField extends StatelessWidget {
  final String hintText;               // Placeholder text
  final TextEditingController? controller; // Controller for the text field
  final bool obscureText;              // For password fields
  final String? Function(String?)? validator; // Validation function
  final TextInputType keyboardType;    // Type of keyboard to use
  final Color borderColor;              // Border color
  final Color fillColor;                // Fill color
  final Color textColor;                // Text color
  final double borderRadius;            // Border radius
  final bool readOnly;
  int? maxCount;
  final void Function(String)? onChanged; // Callback for text changes

  // Constructor with default values
  CommonTextField({
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.maxCount,
    this.keyboardType = TextInputType.text,
    this.borderColor = Colors.grey,    // Default border color
    this.fillColor = Colors.white,      // Default fill color
    this.textColor = Colors.black,      // Default text color
    this.borderRadius = 8.0,
    this.readOnly = false,// Default border radius
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
      onChanged: onChanged,
      readOnly: readOnly,
      maxLength: maxCount,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: ColorHelper.brownColor), // Hint text color
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: ColorHelper.brownColor), // Focused border color
        ),
      ),
      style: TextStyle(color: textColor), // Text color
    );
  }
}
