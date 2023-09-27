import 'package:flutter/material.dart';
import 'package:muuv/config/color.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.icon,
    required this.text,
    this.obscure = false,
    required this.isEmail,
    this.enableSuffixIcon = false,
    this.visible = false,
    this.onTap,
    this.isphone = false,
    this.isAddress = false,
    this.controller,
    this.validator,
  });
  final IconData icon;
  final String text;
  late bool? obscure;
  final bool isEmail;
  final bool isphone;
  final bool isAddress;
  final bool? enableSuffixIcon;
  late bool? visible;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: TextFormField(
        style: TextStyle(color: ColorConfig.secondary),
        obscureText: obscure!,
        keyboardType: isEmail
            ? TextInputType.emailAddress
            : isphone
                ? TextInputType.phone
                : isAddress
                    ? TextInputType.streetAddress
                    : TextInputType.text,
        cursorColor: ColorConfig.primary,
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: ColorConfig.primary,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                if (onTap != null) {
                  onTap!();
                }
              },
              child: Icon(
                enableSuffixIcon!
                    ? !visible!
                        ? Icons.visibility
                        : Icons.visibility_off
                    : null,
                color: ColorConfig.primary,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(35.0)),
              borderSide: BorderSide(
                color: ColorConfig.secondary.withOpacity(0.4),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(35.0)),
              borderSide: BorderSide(
                color: ColorConfig.secondary.withOpacity(0.4),
              ),
            ),
            contentPadding: EdgeInsets.all(10),
            hintText: text,
            hintStyle: TextStyle(fontSize: 14, color: ColorConfig.secondary)),
        controller: controller,
        validator: validator,
      ),
    );
  }
}
