import 'package:flutter/material.dart';

import '../core/app_palette.dart';
import '../widgets/profile/profile_field.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: (constraints.maxHeight - 22).clamp(0, double.infinity),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back, color: AppPalette.softWhite, size: 34),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(height: 8),
                      const Divider(color: AppPalette.lineWhite, thickness: 3),
                      const SizedBox(height: 16),
                      const Text(
                        'Profile details',
                        style: TextStyle(
                          color: AppPalette.softWhite,
                          fontSize: 42,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 22),
                      Center(
                        child: Stack(
                          children: [
                            const CircleAvatar(
                              radius: 45,
                              backgroundColor: Color(0xFFD97FA2),
                              child: Icon(Icons.person, color: Color(0xFFF6DCE5), size: 64),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 6,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF2DA8FF),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.edit, color: Colors.white, size: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      const ProfileField(label: 'Full Name'),
                      const SizedBox(height: 16),
                      const ProfileField(label: 'E-mail'),
                      const SizedBox(height: 16),
                      const ProfileField(label: 'Phone-Number'),
                      const SizedBox(height: 16),
                      const ProfileField(label: 'Password'),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 54,
                              child: ElevatedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFF0F0F0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(26),
                                  ),
                                ),
                                child: const Text(
                                  'CANCEL',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 28,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: SizedBox(
                              height: 54,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppPalette.save,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(26),
                                  ),
                                ),
                                child: const Text(
                                  'SAVE',
                                  style: TextStyle(
                                    color: AppPalette.softWhite,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 28,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
