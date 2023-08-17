
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class APTextField extends StatelessWidget {
  final String? title;
  final String? placeholder;
  final TextInputType? keyboardType;
  final TextInputAction? keyboardAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool? obscureText;
  final TextEditingController? controller;
  final int? lengthLimit;
  final int? lineLimit;
  final int? lineMin;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? borderSideColors;
  final double? borderRadius;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onEditingComplete;
  final bool? readOnly;
  final bool? autofocus;
  final bool? autocorrect;
  final bool? filled;
  final Color? fillColor;
  bool? enable = false;
  bool? hidelabel = false;
  bool? showError = false;
  final String? error;
  final ValueChanged<String>? onChanged;
  final double? height;
  final TextAlign? textAlign;
  final TextCapitalization? textCapitalization;
  Widget? suffix;
  final ToolbarOptions? toolbarOptions;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;

  APTextField({
    Key? key,
    this.title,
    this.placeholder,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText,
    this.controller,
    this.lengthLimit,
    this.lineLimit,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.borderSideColors,
    this.borderRadius,
    this.onTap,
    this.onEditingComplete,
    this.readOnly,
    this.autofocus,
    this.autocorrect,
    this.filled,
    this.fillColor,
    this.enable,
    this.hidelabel,
    this.showError,
    this.error,
    this.onChanged,
    this.height,
    this.textAlign,
    this.textCapitalization,
    this.suffix,
    this.keyboardAction,
    this.lineMin,
    this.toolbarOptions,
    this.focusNode,
    this.onFieldSubmitted,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: _textField(context),
    );
  }

  void onChangedHandler(String value) {
    if (onChanged != null) {
      onChanged!(value);
    }
  }

  _textField(BuildContext context) {
    return Column(
      children: [
        Container(
            height: height,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: TextFormField(
              focusNode: focusNode,
              controller: controller,
              keyboardType: keyboardType,
              toolbarOptions: toolbarOptions,
              inputFormatters: inputFormatters ?? [],
              textInputAction: keyboardAction ?? TextInputAction.done,
              textCapitalization: textCapitalization ?? TextCapitalization.none,
              minLines: lineMin,
              maxLength: lengthLimit,
              maxLines: lineLimit,
              validator: validator,
              autocorrect: autocorrect ?? false,
              enableSuggestions: false,
              obscureText: obscureText ?? false,
              readOnly: readOnly ?? false,
              autofocus: autofocus ?? false,
              textAlign: textAlign ?? TextAlign.start,
              decoration: InputDecoration(
                  suffixIcon: suffixIcon,
                  prefixIcon: prefixIcon,
                  hintText: placeholder,
                  suffix: suffix,
                  prefixIconConstraints: BoxConstraints(maxWidth: 60),
                  suffixIconConstraints: BoxConstraints(maxWidth: 100),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: hidelabel == true ? null : title,
                  isDense: true,
                  counterText: '',
                  filled: filled ?? false,
                  fillColor: fillColor ?? Colors.amberAccent,
                  hintStyle: const TextStyle(fontSize: 16 , color: Colors.grey),
                  labelStyle:  const TextStyle(fontSize: 16 ),
                  errorStyle:  const TextStyle(fontSize: 16 , color: Colors.red),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: borderSideColors ?? Colors.grey[350]!,
                      ),
                      borderRadius: BorderRadius.circular(borderRadius ?? 10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: borderSideColors ?? Colors.grey[350]!,
                      ),
                      borderRadius: BorderRadius.circular(borderRadius ?? 10)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: borderSideColors ?? Colors.grey[350]!,
                      ),
                      borderRadius: BorderRadius.circular(borderRadius ?? 10))),
              style:  const TextStyle(fontSize: 16 ),
              onTap: onTap,
              onEditingComplete: onEditingComplete,
              onFieldSubmitted: onFieldSubmitted,
              onChanged: onChangedHandler,
            )),
      ],
    );
  }
}
