import 'package:flutter/material.dart';

class CustomTextfieldWithTitle extends StatelessWidget {
  const CustomTextfieldWithTitle(
      {super.key,
      required this.hintText,
      this.isObscureText = false,
      required this.title,
      this.controller,
      this.validator});
  final String title;
  final String hintText;
  final bool isObscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 2,
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ],
        ),
        TextFormField(
          controller: controller,
          validator: validator,
          obscureText: isObscureText,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(
                  18,
                )),
          ),
        ),
      ],
    );
  }
}
