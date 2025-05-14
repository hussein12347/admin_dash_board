import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.textInputType,
    this.isPassword = false,
    required this.controller,
    this.validator, this.onChange,
  });

  final String hintText;
  final TextInputType? textInputType;
  final bool isPassword;
  final TextEditingController controller;

  final String? Function(String?)? validator;
  final ValueChanged<String>? onChange;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(

onChanged: widget.onChange,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.isPassword ? isShow : false,
      // هذا يجعل النص مخفيًا
      keyboardType: widget.textInputType,
      decoration: InputDecoration(

        suffixIcon:
        widget.isPassword
            ? IconButton(
          icon:
          isShow
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off),
          onPressed: () {
            setState(() {
              isShow = !isShow;
            });
          },
        )
            : null,
        hintText: widget.hintText,
        filled: true,
        fillColor: const Color(0xFFD3D8D9).withOpacity(0.3) ,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
