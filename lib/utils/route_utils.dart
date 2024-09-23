import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/forgot_password_screen.dart';
import '../screens/setting_screen.dart';
import '../screens/register_screen.dart';
import '../screens/splash_screen.dart';

Route<dynamic> createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
  // transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //   return FadeTransition(
  //     opacity: animation,
  //     child: child,
  //   );
  // },
}

Map<String, WidgetBuilder> generateRoutes(BuildContext context) {
  return {
    '/': (context) => SplashScreen(),
    '/login': (context) => LoginScreen(),
    '/home': (context) => HomeScreen(),
    '/setting': (context) => SettingScreen(),
    '/forgot-password': (context) => ForgotPasswordScreen(username: ''),
    '/register': (context) => RegistrationForm(),
  };
}