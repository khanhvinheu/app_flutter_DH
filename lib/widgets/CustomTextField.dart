import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextInputType keyboardType;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  CustomTextField(
      {required this.label,
      required this.hintText,
      this.keyboardType = TextInputType.text,
      this.onSaved,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '$label ',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              '*',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        SizedBox(height: 10),
        TextFormField(
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onSaved: onSaved ??
              (value) {
                // Default action if onSaved is not provided
                print('Value saved: $value');
              },
        ),
        SizedBox(height: 0),
      ],
    );
  }
}
