import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  TextEditingController editingController;
  String? hintText;
  String? labelText;
  Color? textColor;
  Color? hintColor;
  Color? fillColor;
  int? textSize;
  EdgeInsetsGeometry? padding;
  bool isRequired;
  String? errorText;
  Function(String val) onChange;
  Function? onPostFixClick;
  double? height;
  double? width;
  double? radius;
  bool? obscureText;
  IconData? preFixIcon;
  IconData? postFixIcon;
  bool enabled;
  int? maxLines;
  TextInputAction? textInputAction;

  CustomTextField({
    super.key,
    required this.editingController,
    this.labelText,
    this.hintText,
    this.padding,
    this.textColor,
    this.enabled = true,
    this.textSize,
    this.fillColor,
    this.isRequired = false,
    this.errorText,
    required this.onChange,
    this.height,
    this.width,
    this.textInputAction,
    this.radius,
    this.obscureText,
    this.preFixIcon,
    this.hintColor,
    this.postFixIcon,
    this.onPostFixClick,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Container(
      //padding: padding ?? const EdgeInsets.symmetric(horizontal: 12),
      margin:
          padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      height: height ?? 60,
      width: width ?? size.width,
      decoration: BoxDecoration(
          color: fillColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(radius ?? 8.0)),
      child: TextFormField(
        controller: editingController,
        enabled: enabled,
        textInputAction: textInputAction,
        maxLines: maxLines ?? 1,
        obscureText: obscureText ?? false,
        autovalidateMode: AutovalidateMode.disabled,
        validator: isRequired
            ? (value) {
                if (value == null || value.isEmpty) {
                  return errorText ?? 'This field is required';
                }
                return null;
              }
            : null,
        onChanged: onChange,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.orange),
                borderRadius: BorderRadius.circular(radius ?? 8.0)),
            labelText: labelText ?? hintText ?? '',
            prefixIcon: preFixIcon != null
                ? Icon(preFixIcon, size: 20, color: Colors.orange)
                : null,
            suffixIcon: postFixIcon != null
                ? onPostFixClick != null
                    ? GestureDetector(
                        onTap: () {
                          onPostFixClick!.call();
                        },
                        child: Container(
                          height: double.infinity,
                          width: 60,
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius ?? 12),
                              color: Colors.orange),
                          child: Icon(
                            postFixIcon,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Icon(
                        postFixIcon,
                        size: 20,
                        color: Colors.white,
                      )
                : null,
            fillColor: fillColor ?? Colors.transparent,
            errorStyle: const TextStyle(fontSize: 12),
            labelStyle: TextStyle(color: textColor ?? Colors.black),
            hintStyle: TextStyle(color: hintColor ?? Colors.grey[500]),
            hintText: hintText ?? ''),
      ),
    );
  }
}
