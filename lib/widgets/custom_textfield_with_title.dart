import 'package:flutter/material.dart';

class CustomTextfieldWithTitle extends StatelessWidget {
  const CustomTextfieldWithTitle(
      {super.key,
      required this.hintText,
      this.isObscureText = false,
      required this.title,
      this.controller,
      this.keyboardType,
      this.validator,
      this.suffix});
  final String title;
  final String hintText;
  final bool isObscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? suffix;

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
          keyboardType: keyboardType,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 10),
            labelText: hintText,
            labelStyle: const TextStyle(fontSize: 14),
            hintText: hintText,
            filled: true,
            fillColor: Colors.grey.shade200,
            suffix: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: suffix,
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(
                  6,
                )),
          ),
        ),
      ],
    );
  }
}
