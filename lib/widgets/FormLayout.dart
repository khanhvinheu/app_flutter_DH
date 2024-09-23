import 'package:donghanh_flutter/screens/home_screen.dart';
import 'package:donghanh_flutter/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:donghanh_flutter/utils/route_utils.dart';

class FormLayout extends StatelessWidget {
  final String title;
  final String groupTitle;
  final List<Widget>
      formFields; // List of form fields (text fields, dropdowns, etc.)
  final Widget actionButton; // Action button for the form (e.g., submit button)

  FormLayout({
    required this.title,
    required this.groupTitle,
    required this.formFields,
    required this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title), // The title of the form screen
          centerTitle: true,
          // leading: IconButton(
          //     onPressed: () => {Navigator.of(context).push(createRoute(LoginScreen()))},
          //     icon: Icon(Icons.home)),
        ),
        body: Container(
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  this.groupTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
                // Display each form field
                Expanded(
                  child: ListView(
                    children: formFields
                        .map((field) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: field,
                            ))
                        .toList(),
                  ),
                ),
                SizedBox(height: 20),
                // The action button (like 'Register' or 'Submit')
                actionButton,
              ],
            ),
          ),
        ));
  }
}
