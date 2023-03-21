import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/providers/settings_provider.dart';
import 'package:todo/ui/edit_task/edit_task_screen.dart';
import 'package:todo/ui/home/home_screen.dart';
import 'package:todo/ui/my_theme.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (context) => SettingsProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  late SettingsProvider settingsProvider;

  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of<SettingsProvider>(context);
    initSharedPref();
    return MaterialApp(
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: settingsProvider.currentTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(settingsProvider.currentLanguage),
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        EditTaskScreen.routeName: (_) => EditTaskScreen()
      },
      initialRoute: HomeScreen.routeName,
      debugShowCheckedModeBanner: false,
    );
  }

  initSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    String lang = prefs.getString('language') ?? 'en';
    settingsProvider.changeLanguage(lang);
    String? theme = prefs.getString('theme');
    if (theme == 'light') {
      settingsProvider.changeTheme(ThemeMode.light);
    } else if (theme == 'dark') {
      settingsProvider.changeTheme(ThemeMode.dark);
    }
  }
}
