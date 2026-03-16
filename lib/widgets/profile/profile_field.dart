import 'package:flutter/material.dart';

import '../../core/app_palette.dart';

class ProfileField extends StatelessWidget {
  const ProfileField({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF95AFB2),
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Divider(color: AppPalette.lineWhite, thickness: 3),
      ],
    );
  }
}
