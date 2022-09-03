import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  AppLocalizations get l10n => AppLocalizations.of(this)!;
  NavigatorState get navigator => Navigator.of(this);
  get showSnackbar => ScaffoldMessenger.of(this).showSnackBar;
}
