import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/assets.dart';
import '../models/favourite_model.dart';
import 'handyman_profile_screen.dart';

/// ✅ Favorites screen (matches your screenshot)
/// - Green title "Favorites"
/// - 2 list items with divider lines
/// - Left circular service icon
/// - Title + subtitle (professionals count)
/// - Small avatar stack under subtitle (overlap) + "+1" bubble
/// - Right chevron
///
/// Replace avatar/service icons with your real assets if needed.

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  static const _green = Color(0xFF2FA86A);
  static const _text = Color(0xFF1F1F1F);
  static const _muted = Color(0xFF8B8B8B);
  static const _line = Color(0xFFEDEDED);

  @override
  Widget build(BuildContext context) {
    final items = <FavoriteCategory>[
      FavoriteCategory(
        title: "Handyman",
        professionalsText: "1 professionals",
        avatarCount: 1,
        extraCount: 0,
        onTap: () {
          // TODO: open Handyman favorites list
          Get.to(() => const HandymanProfileScreen());
        },
      ),
      FavoriteCategory(
        title: "Cleaning",
        professionalsText: "4 professionals",
        avatarCount: 3,
        extraCount: 1, // shows +1 bubble
        onTap: () {
          // TODO: open Cleaning favorites list
          Get.to(() => const HandymanProfileScreen());
        },
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 14),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                "Favorites",
                style: TextStyle(
                  fontFamily: "Urbanist",
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: _green,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(height: 1, thickness: 1, color: _line),

            // List
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: items.length,
                separatorBuilder: (_, __) => const Divider(height: 1, thickness: 1, color: _line),
                itemBuilder: (context, i) {
                  final it = items[i];
                  return _FavoriteRow(
                    title: it.title,
                    subtitle: it.professionalsText,
                    avatarCount: it.avatarCount,
                    extraCount: it.extraCount,
                    onTap: it.onTap,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ------------------------- Model ------------------------- */



/* ------------------------- Row UI ------------------------- */

class _FavoriteRow extends StatelessWidget {
  const _FavoriteRow({
    required this.title,
    required this.subtitle,
    required this.avatarCount,
    required this.extraCount,
    required this.onTap,
  });

  static const _text = Color(0xFF1F1F1F);
  static const _muted = Color(0xFF8B8B8B);

  final String title;
  final String subtitle;
  final int avatarCount; // number of visible avatars
  final int extraCount; // +N bubble (0 => hidden)
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        child: Row(
          children: [
            // Left service icon circle
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFF6F6F6),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  Images.cleaningAndhandymanIcon,   // String path
                  width: 22,
                  height: 22,
                ),
              ),

            ),
            const SizedBox(width: 12),

            // Title + subtitle + avatars
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: "Urbanist",
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: _text,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: "Urbanist",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: _muted,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _AvatarStack(
                    visibleCount: avatarCount,
                    extraCount: extraCount,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),
            const Icon(Icons.chevron_right_rounded, color: Color(0xFF8B8B8B), size: 22),
          ],
        ),
      ),
    );
  }
}

/* ------------------------- Avatar Stack ------------------------- */

class _AvatarStack extends StatelessWidget {
  const _AvatarStack({
    required this.visibleCount,
    required this.extraCount,
  });

  final int visibleCount;
  final int extraCount;

  @override
  Widget build(BuildContext context) {
    // Tune these to match screenshot
    const double size = 18;
    const double overlap = 10;

    final total = visibleCount + (extraCount > 0 ? 1 : 0);
    final width = total <= 0 ? 0.0 : (size + (total - 1) * overlap);

    return SizedBox(
      height: size,
      width: width,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (int i = 0; i < visibleCount; i++)
            Positioned(
              left: i * overlap,
              child: _AvatarCircle(
                size: size,
                // Demo avatar colors. Replace with NetworkImage/AssetImage if you want.
                color: _demoAvatarColor(i),
              ),
            ),

          if (extraCount > 0)
            Positioned(
              left: visibleCount * overlap,
              child: _PlusBubble(size: size, count: extraCount),
            ),
        ],
      ),
    );
  }

  Color _demoAvatarColor(int i) {
    const colors = [
      Color(0xFFFFC107),
      Color(0xFF4FC3F7),
      Color(0xFFE57373),
      Color(0xFF81C784),
    ];
    return colors[i % colors.length];
  }
}

class _AvatarCircle extends StatelessWidget {
  const _AvatarCircle({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: const SizedBox.shrink(),
    );
  }
}

class _PlusBubble extends StatelessWidget {
  const _PlusBubble({required this.size, required this.count});

  final double size;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Center(
        child: Text(
          "+$count",
          style: const TextStyle(
            fontFamily: "Urbanist",
            fontSize: 9.5,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1F1F1F),
            height: 1.0,
          ),
        ),
      ),
    );
  }
}
