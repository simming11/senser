import 'package:flutter/material.dart';
import 'app.dart';
export 'app.dart';
import 'core/supabase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.init();
  runApp(const SenserApp());
}
