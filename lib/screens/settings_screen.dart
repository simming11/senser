import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/app_palette.dart';
import '../core/supabase_service.dart';
import '../widgets/settings/settings_menu.dart';
import 'profile_details_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> _showInfoDialog(String title, String message) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('ปิด'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final email = user?.email ?? 'No email';
    final displayName = SupabaseService.displayName(user);
    final avatarUrl = SupabaseService.avatarUrl(user);

    return Scaffold(
      bottomNavigationBar: const SafeArea(
        top: false,
        minimum: EdgeInsets.fromLTRB(10, 0, 10, 12),
        child: _BottomNavBar(),
      ),
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
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: const Color(0xFFD989A2),
                              backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
                              child: avatarUrl == null
                                  ? const Icon(Icons.person, color: AppPalette.cardPink)
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (displayName != null)
                                    Text(
                                      displayName,
                                      style: const TextStyle(
                                        color: AppPalette.textDark,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  if (displayName != null) const SizedBox(height: 4),
                                  Text(
                                    email,
                                    style: const TextStyle(color: AppPalette.textDark, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
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
                          SettingsMenuItem(
                            icon: Icons.medical_services_outlined,
                            label: 'เบอร์ฉุกเฉิน',
                            onTap: () {
                              _showInfoDialog(
                                'เบอร์ฉุกเฉิน',
                                'กรณีฉุกเฉินสามารถโทร 1669 ได้ทันที',
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      SettingsMenuGroup(
                        children: [
                          SettingsMenuItem(
                            icon: Icons.info_outline,
                            label: 'About app',
                            onTap: () {
                              _showInfoDialog(
                                'About app',
                                'แอพพลิเคชันนี้ทำขึ้นเพื่อจำลองและตรวจเช็คระบบการแจ้งเตือน',
                              );
                            },
                          ),
                          const SettingsDividerLine(),
                          SettingsMenuItem(
                            icon: Icons.menu_book_outlined,
                            label: 'ติดต่อสอบถามเพิ่มเติม',
                            onTap: () {
                              _showInfoDialog(
                                'ติดต่อสอบถามเพิ่มเติม',
                                'หากต้องการสอบถามเพิ่มเติม กรุณาติดต่อผู้พัฒนาแอพพลิเคชัน',
                              );
                            },
                          ),
                          const SettingsDividerLine(),
                          SettingsMenuItem(
                            icon: Icons.logout,
                            label: 'Logout',
                            isLogout: true,
                            onTap: () async {
                              await Supabase.instance.client.auth.signOut();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
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
