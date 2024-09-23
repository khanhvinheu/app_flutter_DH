import 'package:flutter/material.dart';
import 'package:donghanh_flutter/widgets/MenuItem.dart';
import 'package:donghanh_flutter/generated/l10n.dart';

class CustormMenu extends StatelessWidget {
  final List<Map<String, String>> listMenu;

  CustormMenu({
    required this.listMenu, // Pass list of menu items
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Theme.of(context).primaryColor, // Background color
        child: GridView.count(
          crossAxisCount: 3, // Number of columns
          children: List.generate(
            listMenu
                .length, // Dynamically create items based on listMenu length
            (index) {
              final menuItem = listMenu[index]; // Get the current menu item

              return MenuItem(
                imagePath: menuItem['imagePath'] ??
                    'assets/images/default.png', // Provide image path or default
                text: menuItem['text'] ??
                    'Default Text', // Provide text or default
                router:  menuItem['router'] ??
                    '/',
              );
            },
          ),
        ),
      ),
    );
  }
}
