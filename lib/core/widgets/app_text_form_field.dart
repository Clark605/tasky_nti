import 'package:flutter/material.dart';
import 'package:tasky_nti/core/theme/app_fonts.dart';

typedef MyValidator = String? Function(String?);

// ignore: must_be_immutable
class AppTextFormFeild extends StatefulWidget {
  final TextInputType keyboardType;
  final String? hintText;
  bool obscureText;
  final bool isPassword;
  final TextEditingController controller;
  final MyValidator validator;

  AppTextFormFeild({
    required this.controller,
    required this.validator,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isPassword = false,
    super.key,
  });

  @override
  State<AppTextFormFeild> createState() => _AppTextFormFeildState();
}

class _AppTextFormFeildState extends State<AppTextFormFeild> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppFonts.labelText,
      obscureText: widget.obscureText,

      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppFonts.hintText,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  widget.obscureText ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xff454A4F),
                  size: 24,
                ),
                onPressed: () {
                  setState(() {
                    widget.obscureText = !widget.obscureText;
                  });
                },
              )
            : null,

        contentPadding: const EdgeInsets.all(15),
        enabledBorder: outlineInputBorder(
          color: Color(0xffBABABA),
          radius: 10,
          width: 1,
        ),
        focusedBorder: outlineInputBorder(
          color: Color(0xff5F33E1),
          radius: 10,
          width: 1,
        ),
        errorBorder: outlineInputBorder(
          color: Colors.red,
          radius: 10,
          width: 1,
        ),
        focusedErrorBorder: outlineInputBorder(
          color: Colors.red,
          radius: 10,
          width: 1,
        ),
      ),
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      validator: widget.validator,
    );
  }

  OutlineInputBorder outlineInputBorder({
    required double radius,
    required Color color,
    required double width,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
