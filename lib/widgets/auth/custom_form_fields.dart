import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String hintText;
  final bool isObscure;
  final void Function()? onPress;
  final IconData prefixIcon;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.validator,
    required this.hintText,
    this.isObscure = false,
    this.prefixIcon = Icons.text_fields,
    this.onPress,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  String? _errorText;
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isObscure && !isVisible,
          decoration: InputDecoration(
            prefixIcon: Icon(widget.prefixIcon, color: Colors.grey, size: 20),
            suffixIcon:
                widget.isObscure
                    ? IconButton(
                      icon:
                          isVisible
                              ? Icon(
                                Icons.visibility_off,
                                color: Colors.grey,
                                size: 20,
                              )
                              : Icon(
                                Icons.visibility,
                                color: Colors.grey,
                                size: 20,
                              ),
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                    )
                    : null,
            hintText: widget.hintText,
            hintStyle: const TextStyle(fontSize: 13),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Colors.indigoAccent,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1),
            ),
          ),
          validator: (value) {
            final error = widget.validator(value);
            setState(() {
              _errorText = error != null ? '* $error' : error;
            });
            return null;
          },
        ),
        if (_errorText != null)
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.red[50],
              border: Border.all(color: Colors.red[100]!),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              _errorText!,
              style: TextStyle(
                color: Colors.red[300],
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
