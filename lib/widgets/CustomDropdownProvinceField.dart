import 'package:flutter/material.dart';
import 'package:donghanh_flutter/models/DropdownItemProvinceModel.dart';

class CustomDropdownProvinceField extends StatelessWidget {
  final String label;
  final String? value;
  final List<DropdownItemProvince> items;
  final Function(String?) onChanged;

  CustomDropdownProvinceField({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Row(
          children: [
            Text(
              '${label} ',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              '*',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: value,         
          items: items.map((DropdownItemProvince item) {
            return DropdownMenuItem<String>(
              value: item.ProvinceCode, // The underlying value that will be saved
              child: Text(item.ProvinceName), // The text displayed in the dropdown
            );
          }).toList(),
          onChanged: onChanged,
          menuMaxHeight: 250.0, // Limit height for scrolling
         
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 0),
      ],
    );
  }
}
