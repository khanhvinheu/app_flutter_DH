import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String imagePath;
  final String text;
  final String router;
  final double imageWidth;
  final double imageHeight;

  MenuItem({
    required this.imagePath,
    required this.text,
    required this.router,
    this.imageWidth = 40.0,
    this.imageHeight = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(1.0), // Set the border radius
      ),
      elevation: 1,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all<Size>(
                        const Size(double.infinity, 50)), // Chiều cao 60
                    padding: WidgetStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(horizontal: 14)),
                  ),
                  onPressed: () => {
                    
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        width: imageWidth, // Set image width
                        height: imageHeight, // Set image height
                      ),
                      const SizedBox(height: 10),
                      Text(
                        text,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
