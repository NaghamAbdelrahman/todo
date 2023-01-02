import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/home/settings/category_widget.dart';
import 'package:todo/ui/home/settings/theme_bottom_sheet.dart';

import '../../../providers/settings_provider.dart';
import 'language_bottom_sheet.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Column(
      children: [
        Container(
          height: screenSize.height * 0.1,
          color: Theme.of(context).primaryColor,
        ),
        Padding(
          padding: EdgeInsets.all(screenSize.height * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CategoryWidget(
                  tittle: AppLocalizations.of(context)!.language,
                  userSelection: settingsProvider.currentLanguage == 'en'
                      ? 'English'
                      : 'العربية',
                  action: showLanguageBottomSheet),
              CategoryWidget(
                  tittle: AppLocalizations.of(context)!.theme,
                  userSelection:
                      settingsProvider.currentTheme == ThemeMode.light
                          ? AppLocalizations.of(context)!.light
                          : AppLocalizations.of(context)!.dark,
                  action: showThemeBottomSheet),
            ],
          ),
        ),
      ],
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return const ThemeBottomSheet();
        });
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return const LanguageBottomSheet();
        });
  }
}
