import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.validator,
    this.maxLines = 1,
    this.prefixIcon,
    required this.label,
    required this.hint,
  });

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String label;
  final String hint;
  final int maxLines;
  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 5),

        TextFormField(
          controller: controller,
          validator: validator,
          maxLines: maxLines,

          decoration: InputDecoration(
            hintText: hint,

            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: Colors.grey,
                  )
                : null,

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ],
    );
  }
}