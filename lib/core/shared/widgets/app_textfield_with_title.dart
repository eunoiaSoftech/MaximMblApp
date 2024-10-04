import 'package:flutter/material.dart';
import 'package:logistics_app/core/res/app_functions.dart';
import 'package:logistics_app/core/res/app_styles.dart';
import 'package:logistics_app/core/shared/widgets/app_textfield.dart';

class AppTextFieldWithTitle extends StatelessWidget {
  const AppTextFieldWithTitle(
      {super.key,
      this.pIcon,
      required this.hint,
      this.inputType,
      this.inputAction,
      this.controller,
      this.errorText,
      this.onChanged,
      this.keyboardType,
      this.maxLength,
      this.contentPadding = const EdgeInsets.fromLTRB(20, 12, 20, 12),
      this.iconHorizontalPadding = 20,
      required this.readOnly,
      this.onTap,
      this.iconSize = 22,
      this.obscureText = false,
      this.sIcon,
      this.suffix,
      this.borderCircular = 22,
      this.maxLines = 1,
      this.minLines = 1,
      required this.textFieldName,
      this.focusNode,
      this.textFieldHeight = 44,
      this.validator,
      this.assestImage,
      this.onSaved,
      this.fillColor,
      this.titleColor});

  final IconData? pIcon;
  final IconData? sIcon;
  final String? hint;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextEditingController? controller;
  final Function(String s)? onChanged;
  final Function(String? s)? onSaved;
  final String Function(String? s)? validator;
  final Function()? onTap;
  final String? errorText;
  final String textFieldName;
  final String? assestImage;
  final EdgeInsets contentPadding;
  final double iconHorizontalPadding;
  final double iconSize;
  final double borderCircular;
  final double textFieldHeight;
  final bool readOnly;
  final bool obscureText;
  final Widget? suffix;
  final FocusNode? focusNode;
  final Color? fillColor;
  final Color? titleColor;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    double size = appSize(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (assestImage != null)
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 20),
                child: Image(
                  image: AssetImage(
                    assestImage!,
                  ),
                  height: 18,
                ),
              ),
            Text(
              textFieldName,
              style: AppStyles.titleTextStyle(context),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
                child: AppTextField(
                    circular: borderCircular,
                    onTap: onTap,
                    onChanged: onChanged,
                    keyboardType: inputType,
                    height: textFieldHeight,
                    controller: controller,
                    hintText: hint)),
          ],
        ),
      ],
    );
  }
}
