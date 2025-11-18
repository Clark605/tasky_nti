import 'package:flutter/material.dart';
import 'package:tasky_nti/core/theme/app_colors.dart';
import 'package:tasky_nti/core/theme/app_fonts.dart';

typedef MyValidator = String? Function(String?);

// ignore: must_be_immutable
class AppTextFormField extends StatefulWidget {
  final TextInputType keyboardType;
  final String? hintText;
  bool obscureText;
  final bool isPassword;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final MyValidator validator;

  AppTextFormField({
    required this.controller,
    required this.validator,
    this.hintText,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isPassword = false,
    super.key,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
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
                  color: AppColors.subtitleText,
                  size: 24,
                ),
                onPressed: () {
                  setState(() {
                    widget.obscureText = !widget.obscureText;
                  });
                },
              )
            : null,
        prefixIcon: widget.prefixIcon,

        contentPadding: const EdgeInsets.all(15),
        enabledBorder: outlineInputBorder(
          color: AppColors.border,
          radius: 10,
          width: 1,
        ),
        focusedBorder: outlineInputBorder(
          color: AppColors.primary,
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
