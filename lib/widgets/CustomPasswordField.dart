import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  final String label;
  final bool defaultShowHide;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  CustomPasswordField({required this.label, required this.defaultShowHide, this.onSaved, this.validator, this.onChanged});

  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    // Set the initial visibility based on the defaultShowHide value
    _obscureText = widget.defaultShowHide;
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '${widget.label} ',
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
          obscureText: _obscureText,
          onSaved: widget.onSaved ??
              (value) {
                // Default action if onSaved is not provided
                print('Value saved: $value');
          },
          onChanged: widget.onChanged ??(value) {},
          decoration: InputDecoration(
            hintText: '******',
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: IconButton(
              icon:
                  Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },              
            ),
          ),
          validator: widget.validator,
        ),
        SizedBox(height: 0),
      ],
    );
  }
}
