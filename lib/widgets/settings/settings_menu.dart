import 'package:flutter/material.dart';

import '../../core/app_palette.dart';

class SettingsMenuGroup extends StatelessWidget {
  const SettingsMenuGroup({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppPalette.cardPink,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(children: children),
    );
  }
}

class SettingsMenuItem extends StatelessWidget {
  const SettingsMenuItem({
    super.key,
    required this.icon,
    required this.label,
    this.isLogout = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isLogout;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Color color = isLogout ? AppPalette.logout : AppPalette.textDark;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
              ),
            ),
            Icon(Icons.chevron_right, color: color, size: 34),
          ],
        ),
      ),
    );
  }
}

class SettingsDividerLine extends StatelessWidget {
  const SettingsDividerLine({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(color: Colors.black87, thickness: 3, height: 1);
  }
}
