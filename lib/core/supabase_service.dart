import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl = 'https://bwspawueluzqakffmqsa.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ3c3Bhd3VlbHV6cWFrZmZtcXNhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzM2NjY5OTUsImV4cCI6MjA4OTI0Mjk5NX0.jcHgv9wwfSuPTKCFJ-OsMIBhnEuSZV8Aq4vGYMfKzx4';
  static const String googleRedirectUrl = 'senser://login-callback/';
}

class SupabaseService {
  static SupabaseClient get client => Supabase.instance.client;

  static String? displayName(User? user) {
    final metadata = user?.userMetadata;
    final name = metadata?['full_name'] ?? metadata?['name'];
    return name is String && name.trim().isNotEmpty ? name.trim() : null;
  }

  static String? avatarUrl(User? user) {
    final metadata = user?.userMetadata;
    final avatar = metadata?['avatar_url'] ?? metadata?['picture'] ?? metadata?['avatarUrl'];
    return avatar is String && avatar.trim().isNotEmpty ? avatar.trim() : null;
  }

  static Future<void> init() async {
    await Supabase.initialize(
      url: SupabaseConfig.supabaseUrl,
      anonKey: SupabaseConfig.supabaseAnonKey,
      debug: true,
    );
  }

  static Future<bool> signInWithGoogle() async {
    return client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: kIsWeb ? null : SupabaseConfig.googleRedirectUrl,
      queryParams: const {
        'prompt': 'select_account',
      },
    );
  }

  static Future<Map<String, dynamic>?> fetchProfile(String userId) async {
    try {
      final data = await client.from('profiles').select('*').eq('id', userId).single();
      return data as Map<String, dynamic>?;
    } catch (error) {
      return null;
    }
  }

  static Future<void> upsertProfile(String userId, String fullName, String phone) async {
    await client.from('profiles').upsert({
      'id': userId,
      'full_name': fullName,
      'phone': phone,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    }).eq('id', userId);
  }
}

