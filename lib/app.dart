import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/app_palette.dart';
import 'screens/auth_screen.dart';
import 'screens/settings_screen.dart';

class SenserApp extends StatelessWidget {
  const SenserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = snapshot.data?.session ?? Supabase.instance.client.auth.currentSession;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Senser Settings UI',
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'Georgia',
            scaffoldBackgroundColor: AppPalette.backgroundTeal,
          ),
          home: session == null ? const AuthScreen() : const SettingsScreen(),
        );
      },
    );
  }
}
