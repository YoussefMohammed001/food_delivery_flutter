
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  MyTextField({Key? key, required this.keyBoardType, required this.lableText, required this.textInputAction, this.suffixIcon, this.prefxi, required this.obscure, this.hintStyle, this.validator, this.controller, this.autovalidateMode, this.onSaved,}) : super(key: key);
final TextInputType keyBoardType;
final String lableText;
final TextInputAction textInputAction;
  final Widget? suffixIcon;
  final Widget? prefxi;
  final bool obscure;
  final TextStyle? hintStyle;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final  AutovalidateMode? autovalidateMode;
  final FormFieldSetter<String>? onSaved;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      autovalidateMode: autovalidateMode,
      controller: controller,
      validator:validator ,
      obscureText: obscure,
      textInputAction: textInputAction,
      keyboardType: keyBoardType,
      decoration: InputDecoration(
        labelText: lableText,
        suffixIcon: suffixIcon ,
        prefixIcon: prefxi,
        labelStyle: hintStyle,


        border: OutlineInputBorder()



      ),

    );
  }

}
