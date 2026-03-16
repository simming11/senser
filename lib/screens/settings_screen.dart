import 'package:flutter/material.dart';

import '../core/app_palette.dart';
import '../widgets/settings/settings_menu.dart';
import 'profile_details_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: (constraints.maxHeight - 20).clamp(0, double.infinity),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Center(
                        child: Text(
                          'Settings',
                          style: TextStyle(
                            color: AppPalette.softWhite,
                            fontSize: 38,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: AppPalette.cardPink,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundColor: Color(0xFFD989A2),
                              child: Icon(Icons.person, color: AppPalette.cardPink),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'User :',
                                    style: TextStyle(color: AppPalette.textDark, fontSize: 18),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Email :',
                                    style: TextStyle(color: AppPalette.textDark, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        'Other Settings',
                        style: TextStyle(
                          color: AppPalette.softWhite,
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SettingsMenuGroup(
                        children: [
                          SettingsMenuItem(
                            icon: Icons.person_outline,
                            label: 'Profile details',
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => const ProfileDetailsScreen()),
                              );
                            },
                          ),
                          const SettingsDividerLine(),
                          const SettingsMenuItem(icon: Icons.lock_outline, label: 'Password'),
                          const SettingsDividerLine(),
                          const SettingsMenuItem(
                            icon: Icons.medical_services_outlined,
                            label: 'Emergency',
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      const SettingsMenuGroup(
                        children: [
                          SettingsMenuItem(icon: Icons.info_outline, label: 'About Application'),
                          SettingsDividerLine(),
                          SettingsMenuItem(icon: Icons.menu_book_outlined, label: 'Help/FAQ'),
                          SettingsDividerLine(),
                          SettingsMenuItem(icon: Icons.logout, label: 'Logout', isLogout: true),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const _BottomNavBar(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: AppPalette.cardPink,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(Icons.home_outlined, size: 30, color: Colors.black87),
          const Icon(Icons.calendar_today_outlined, size: 28, color: Colors.black87),
          const Icon(Icons.notifications_none, size: 30, color: Colors.black87),
          Container(
            width: 46,
            height: 46,
            decoration: const BoxDecoration(
              color: Color(0xFFBDB4AF),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.menu, color: Colors.black87, size: 30),
          ),
        ],
      ),
    );
  }
}
