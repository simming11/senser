import 'package:flutter/material.dart';

import 'core/app_palette.dart';
import 'screens/settings_screen.dart';

class SenserApp extends StatelessWidget {
  const SenserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Senser Settings UI',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Georgia',
        scaffoldBackgroundColor: AppPalette.backgroundTeal,
      ),
      home: const SettingsScreen(),
    );
  }
}
