import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/app_palette.dart';
import '../core/supabase_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;
  String? _error;
  String? _notice;
  bool _isSignUp = false;

  String _friendlyErrorMessage(Object error) {
    final rawMessage = error.toString();
    final errorType = error.runtimeType.toString();

    if (errorType == 'AuthRetryableFetchException') {
      if (rawMessage.contains('statusCode: 502')) {
        return 'Google sign-in is temporarily unavailable. Please wait a moment and try again.';
      }

      return 'A temporary network problem occurred. Please check your connection and try again.';
    }

    if (error is AuthApiException) {
      switch (error.code) {
        case 'provider_not_enabled':
          return 'Google sign-in is not enabled in Supabase yet.';
        case 'validation_failed':
          return 'The Google sign-in request is invalid. Please check the redirect settings.';
      }

      final message = error.message.trim();
      if (message.isNotEmpty) {
        return message;
      }
    }

    final message = rawMessage.replaceFirst('Exception: ', '').trim();
    return message.isEmpty ? 'Something went wrong. Please try again.' : message;
  }

  Future<void> _continueWithGoogle() async {
    setState(() {
      _error = null;
      _notice = null;
      _isLoading = true;
    });

    try {
      final launched = await SupabaseService.signInWithGoogle();
      if (!launched) {
        throw Exception('Could not open Google sign-in.');
      }

      if (!mounted) return;

      if (!kIsWeb) {
        setState(() {
          _notice = 'Continue in your browser, then you will return to the app automatically.';
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = _friendlyErrorMessage(e);
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final actionLabel = _isSignUp ? 'Create with Google' : 'Continue with Google';
    final hintLabel = _isSignUp
        ? 'Use your Google account to create a new Senser account.'
        : 'Use your Google account to sign in to Senser.';

    return Scaffold(
      backgroundColor: AppPalette.backgroundTeal,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Senser',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w800,
                    color: AppPalette.softWhite,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  _isSignUp ? 'Create account' : 'Sign in',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppPalette.softWhite, fontSize: 22),
                ),
                const SizedBox(height: 28),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        hintLabel,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppPalette.softWhite,
                          fontSize: 16,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        height: 56,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _continueWithGoogle,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppPalette.textDark,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(strokeWidth: 2.4),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 28,
                                      height: 28,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'G',
                                        style: TextStyle(
                                          color: Color(0xFF4285F4),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      actionLabel,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                if (_notice != null)
                  Text(
                    _notice!,
                    style: const TextStyle(color: AppPalette.softWhite),
                    textAlign: TextAlign.center,
                  ),
                if (_notice != null) const SizedBox(height: 12),
                if (_error != null)
                  Text(
                    _error!,
                    style: const TextStyle(color: Colors.redAccent),
                    textAlign: TextAlign.center,
                  ),
                if (_error != null) const SizedBox(height: 12),
                TextButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          setState(() {
                            _isSignUp = !_isSignUp;
                            _error = null;
                            _notice = null;
                          });
                        },
                  child: Text(
                    _isSignUp ? 'Already have account? Sign in' : 'New user? Create account',
                    style: const TextStyle(color: AppPalette.softWhite),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
