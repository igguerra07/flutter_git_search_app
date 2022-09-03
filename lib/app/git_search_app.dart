import 'package:flutter/material.dart';
import 'package:git_app/app/features/home/home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GitSearchApp extends StatefulWidget {
  const GitSearchApp({Key? key}) : super(key: key);

  @override
  State<GitSearchApp> createState() => _GitSearchAppState();
}

class _GitSearchAppState extends State<GitSearchApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
