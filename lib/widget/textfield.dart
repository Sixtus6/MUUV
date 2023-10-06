import 'package:flutter/material.dart';
import 'package:muuv/config/color.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.icon,
      required this.text,
      this.obscure = false,
      required this.isEmail,
      this.enableSuffixIcon = false,
      this.visible = false,
      this.onTap,
      this.isphone = false,
      this.isAddress = false,
      this.validator,
       this.onchange,
      required this.myController});
  final IconData icon;
  final String text;
  late bool? obscure;
  final bool isEmail;
  final bool isphone;
  final bool isAddress;
  final bool? enableSuffixIcon;
  late bool? visible;
  final String? Function(String?)? validator;
  final String? Function(String?)? onchange;
  final VoidCallback? onTap;
  TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: TextFormField(
        onChanged: onchange,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        controller: myController,
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(35.0)),
              borderSide: BorderSide(
                color: ColorConfig.red.withOpacity(0.4),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(35.0)),
              borderSide: BorderSide(
                color: ColorConfig.red.withOpacity(0.4),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(35.0)),
              borderSide: BorderSide(
                color: ColorConfig.secondary.withOpacity(0.4),
              ),
            ),
            contentPadding: const EdgeInsets.all(10),
            hintText: text,
            hintStyle: TextStyle(fontSize: 14, color: ColorConfig.secondary)),
      ),
    );
  }
}
