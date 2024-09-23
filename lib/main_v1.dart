import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/setting_screen.dart';
import 'screens/register_screen.dart';
import 'providers/ThemeProvider.dart';
import 'providers/LanguageProvider.dart';
import 'providers/UserProvider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'screens/splash_screen.dart';
void main() {
  // runApp(ChangeNotifierProvider(
  //     create: (context) => ThemeProvider(),
  //     child: MyApp(),
  //   ),
  // );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Biến để lưu trữ trạng thái ThemeMode
  // ThemeMode _themeMode = ThemeMode.system;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);    
    final languageProvider = Provider.of<LanguageProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
       localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        AppLocalizationDelegate(),
        // Thêm các delegates của bạn ở đây
      ],
      supportedLocales: [
        const Locale('en', ''), // English
        const Locale('vi', ''), // Vietnamese
      ],
      locale: languageProvider.locale, // Ngôn ngữ mặc định
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.blueGrey,   
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black, fontSize: 13),
          bodyMedium: TextStyle(color: Colors.white),    
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Đặt màu cho icon chung trong app
          size: 30, // Kích thước icon mặc định
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF202133),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontSize: 13),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
         iconTheme: const IconThemeData(
          color: Colors.black, // Đặt màu cho icon chung trong app
          size: 30, // Kích thước icon mặc định
        ),
      ),
      themeMode: themeProvider.themeMode, // Sử dụng theme dựa trên trạng thái _themeMode
      initialRoute: '/', // Đặt màn hình khởi động
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/setting': (context) => SettingScreen(),
        '/forgot-password': (context) => ForgotPasswordScreen(username: '',),
        '/register': (context) => RegistrationForm()
      }
    );
  }
}
