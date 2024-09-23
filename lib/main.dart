import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/ThemeProvider.dart';
import 'providers/LanguageProvider.dart';
import 'providers/UserProvider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'utils/route_utils.dart';
import 'utils/theme_utils.dart';

void main() {
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
      ],
      supportedLocales: languageProvider.supportedLocales,  // Lấy locales từ LanguageProvider
      locale: languageProvider.locale,
      theme: getLightTheme(),  // Sử dụng hàm để lấy Light theme
      darkTheme: getDarkTheme(),  // Sử dụng hàm để lấy Dark theme
      themeMode: themeProvider.themeMode,
      onGenerateRoute: (settings) {
        // Sử dụng hàm generateRoutes để lấy widget
        final routeBuilders = generateRoutes(context);
        final WidgetBuilder? builder = routeBuilders[settings.name];
        if (builder != null) {
          return createRoute(builder(context)); // Trả về route với animation
        }
        return null; // Trả về null nếu không tìm thấy route
      },
    );
  }
}
