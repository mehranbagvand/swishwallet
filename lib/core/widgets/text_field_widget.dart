import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16))),
    );
  }
}

const double _radius = 16;

typedef TextChangeCallback = void Function(String text);

var maskFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####', filter: {"#": RegExp(r'[0-9]')});

class CFTextField extends StatelessWidget {
  final String? hint;
  final TextStyle? hintStyle;
  final String? label;
  final TextChangeCallback? onTextChange;
  final TextInputType type;
  final bool isRequired;
  final bool enabled;
  final bool isNumberCard;
  final Widget? prefixIcon;
  final bool readOnly;
  final void Function()? onTap;
  final String? initialValue;
  final int maxLines;
  final double maxWidth;
  final int minLength;
  final Color fillColor;
  final Color focusedBorderColor;
  final Color enabledBorderColor;
  final int? maxLength;
  final Widget? suffixIcon;
  final ValueChanged<String>? onFieldSubmitted;
  final MaskTextInputFormatter? formatterExtra;
  final TextInputAction? textInputAction;
  final bool obscure;
  final FocusNode? focusNode;
  final InputDecoration? inputDecoration;
  final TextDirection? textDirection;
  final TextEditingController? controller;
  final bool? autofocus;

  const CFTextField(
      {this.label,
        this.hint,
        this.hintStyle,
        this.isRequired = true,
        this.enabled = true,
        this.type = TextInputType.text,
        this.onTextChange,
        this.initialValue,
        this.minLength = 0,
        this.maxLength = 255,
        this.readOnly = false,
        this.onTap,
        this.maxLines = 1,
        this.maxWidth = 360,
        Key? key,
        this.suffixIcon,
        this.obscure = false,
        this.focusNode,
        this.textDirection,
        this.prefixIcon, this.textInputAction, this.onFieldSubmitted,
        this.isNumberCard = false, this.formatterExtra,
        this.fillColor = Colors.white,
        this.focusedBorderColor =const Color(0xff8B8B8B),
        this.enabledBorderColor=const Color(0xffD3D3D3), this.inputDecoration, this.controller, this.autofocus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label?.isNotEmpty ?? false)
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 10),
              child: Text.rich(TextSpan(
                  text: label!,
                  style: const TextStyle(
                      fontSize: 15,fontWeight: FontWeight.bold),
                  children: [TextSpan(
                    text: isRequired?" *":"",
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,fontWeight: FontWeight.bold),
                  )]
              )),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: TextFormField(
              controller: controller,
              textInputAction:textInputAction,
              autofocus: autofocus ?? true,
              focusNode: focusNode,
              enabled: enabled,
              initialValue: initialValue,
              onFieldSubmitted: onFieldSubmitted,
              readOnly: readOnly,
              onTap: onTap,
              maxLines: maxLines,
              textDirection: textDirection,
              obscureText: obscure,
              validator: (value) {
                if (isRequired && (value?.isEmpty ?? true)) {
                  return "This field must not be empty".tr;
                }
                if (minLength > 0 && (value?.length ?? 0) < minLength) {
                  return "At least # character"
                      .tr.replaceAll("#", minLength.toString());
                }
                if ((value?.isNotEmpty ?? false) &&
                    type == TextInputType.emailAddress &&
                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value ?? "")) return "Enter a valid email".tr;
                if ((value?.isNotEmpty ?? false) &&
                    type == TextInputType.phone &&
                    !RegExp(r"^09[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]")
                        .hasMatch(value ?? "")) {
                  return "Invalid mobile number".tr;
                }
                return null;
              },
              onChanged: onTextChange,
              keyboardType: type,
              inputFormatters: [
                if (type == TextInputType.phone || type == TextInputType.number)
                  FilteringTextInputFormatter.digitsOnly,
                if (isNumberCard) maskFormatter,
                if (formatterExtra!=null) formatterExtra!,
                LengthLimitingTextInputFormatter(maxLength),
              ],
              decoration: inputDecoration??InputDecoration(
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                filled: !context.isDarkMode,
                contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                hintText: hint,
                fillColor: fillColor,
                hintStyle: hintStyle??const TextStyle(
                    color: Color(0xff9297B0),
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(_radius)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: enabledBorderColor, width: 0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(_radius)),
                ),
                focusedBorder:  OutlineInputBorder(
                  borderSide: BorderSide(
                      color: focusedBorderColor,
                      width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(_radius)),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary, width: 1),
                  borderRadius:
                  const BorderRadius.all(Radius.circular(_radius)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class CFTextFieldSimple extends StatelessWidget {
  final String? hint;
  final String? label;
  final TextChangeCallback? onTextChange;
  final TextInputType type;
  final bool isRequired;
  final bool enabled;
  final bool isNumberCard;
  final Widget? prefixIcon;
  final bool readOnly;
  final void Function()? onTap;
  final String? initialValue;
  final int maxLines;
  final double maxWidth;
  final int minLength;
  final Color fillColor;
  final Color focusedBorderColor;
  final Color enabledBorderColor;
  final int? maxLength;
  final Widget? suffixIcon;
  final ValueChanged<String>? onFieldSubmitted;
  final MaskTextInputFormatter? formatterExtra;
  final TextInputAction? textInputAction;
  final bool obscure;
  final FocusNode? focusNode;
  final InputDecoration? inputDecoration;
  final TextDirection? textDirection;
  final TextEditingController? controller;

  const CFTextFieldSimple(
      {this.label,
        this.hint,
        this.isRequired = true,
        this.enabled = true,
        this.type = TextInputType.text,
        this.onTextChange,
        this.initialValue,
        this.minLength = 0,
        this.maxLength = 255,
        this.readOnly = false,
        this.onTap,
        this.maxLines = 1,
        this.maxWidth = 360,
        Key? key,
        this.suffixIcon,
        this.obscure = false,
        this.focusNode,
        this.textDirection,
        this.controller,
        this.prefixIcon, this.textInputAction, this.onFieldSubmitted,
        this.isNumberCard = false, this.formatterExtra,
        this.fillColor = Colors.white,
        this.focusedBorderColor =const Color(0xff8B8B8B),
        this.enabledBorderColor=const Color(0xffD3D3D3), this.inputDecoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label?.isNotEmpty ?? false)
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: Text.rich(TextSpan(
                  text: label!,
                  style: const TextStyle(
                      fontSize: 15,color: Color(0xff969696)),
                  children: [TextSpan(
                    text: isRequired?" *":"",
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,fontWeight: FontWeight.bold),
                  )]
              )),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: TextFormField(
              textInputAction:textInputAction,
              autofocus: true,
              controller: controller,
              focusNode: focusNode,
              enabled: enabled,
              initialValue: initialValue,
              onFieldSubmitted: onFieldSubmitted,
              readOnly: readOnly,
              onTap: onTap,
              maxLines: maxLines,
              textDirection: textDirection,
              obscureText: obscure,
              validator: (value) {
                if (isRequired && (value?.isEmpty ?? true)) {
                  return "This field must not be empty".tr;
                }
                if (minLength > 0 && (value?.length ?? 0) < minLength) {
                  return "At least # character"
                      .tr.replaceAll("#", minLength.toString());
                }
                if ((value?.isNotEmpty ?? false) &&
                    type == TextInputType.emailAddress &&
                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value ?? "")) return "Enter a valid email".tr;
                if ((value?.isNotEmpty ?? false) &&
                    type == TextInputType.phone &&
                    !RegExp(r"^09[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]")
                        .hasMatch(value ?? "")) {
                  return "Invalid mobile number".tr;
                }
                return null;
              },
              onChanged: onTextChange,
              keyboardType: type,
              inputFormatters: [
                if (type == TextInputType.phone || type == TextInputType.number)
                  FilteringTextInputFormatter.digitsOnly,
                if (isNumberCard) maskFormatter,
                if (formatterExtra!=null) formatterExtra!,
                LengthLimitingTextInputFormatter(maxLength),
              ],
              decoration: inputDecoration??InputDecoration(
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                filled: !context.isDarkMode,
                contentPadding: const EdgeInsets.
                symmetric(vertical: 5, horizontal: 10),
                hintText: hint,
                fillColor: fillColor,
                hintStyle: const TextStyle(
                    color: Color(0xff9297B0),
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
