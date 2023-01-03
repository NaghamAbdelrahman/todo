import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../providers/settings_provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({Key? key}) : super(key: key);

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              settingsProvider.changeTheme(ThemeMode.light);
            },
            child: settingsProvider.lightMood()
                ? selectedItem(AppLocalizations.of(context)!.light)
                : unSelectedItem(AppLocalizations.of(context)!.light),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              settingsProvider.changeTheme(ThemeMode.dark);
            },
            child: settingsProvider.currentTheme == ThemeMode.dark
                ? selectedItem(AppLocalizations.of(context)!.dark)
                : unSelectedItem(AppLocalizations.of(context)!.dark),
          )
        ],
      ),
    );
  }

  Widget selectedItem(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: Theme.of(context).primaryColor)),
        Icon(
          Icons.check,
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }

  Widget unSelectedItem(String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
