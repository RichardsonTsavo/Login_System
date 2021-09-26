import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/app/shared/utils/style/style.dart';

class CustomTextFormField extends StatefulWidget {
  final Widget? prefixIcon;
  final String hint;
  final Widget? suffixIcon;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final Function(String)? onSubmited;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final bool needTheSpace;
  final String? Function(String?)? validator;

   CustomTextFormField(
      {Key? key, this.prefixIcon,
        this.validator,
        required this.hint,
        this.suffixIcon,
        required this.obscureText,
        this.inputFormatters,
        this.onChanged,
        this.onSubmited,
        required this.needTheSpace,
        this.keyboardType,
        this.focusNode}) : super(key: key);
  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  ConstStyle constStyle = ConstStyle();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.needTheSpace ? 10 : 0,
        ),
        TextFormField(
          validator: widget.validator,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: widget.onSubmited,
          onChanged: widget.onChanged,
          cursorColor: constStyle.secondaryColor,
          obscureText: widget.obscureText,
          inputFormatters: widget.inputFormatters,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: constStyle.secondaryColor)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: constStyle.secondaryColor)),
              isDense: true,
              labelText: widget.hint,
              labelStyle: TextStyle(color: constStyle.secondaryColor,),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: constStyle.secondaryColor)),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon),
        )
      ],
    );
  }
}