import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'HangingScreen.dart';

/// ✅ Price of your service (matches screenshot)
/// - Top progress bar
/// - Back arrow (green)
/// - "Save and exit" on right
/// - Title + subtitle
/// - Green link text (underline)
/// - List rows with left icon, label, right chevron + dividers
class PriceOfServiceScreen extends StatelessWidget {
  const PriceOfServiceScreen({super.key});

  static const Color _green = Color(0xFF2FA86A);
  static const Color _muted = Color(0xFF6F6F6F);
  static const Color _text = Color(0xFF1E1E1E);
  static const Color _divider = Color(0xFFE6E6E6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),

              // ✅ Progress bar (left green fill + grey)
              const _TopProgress(value: 0.16),

              const SizedBox(height: 16),

              // Back + Save and exit
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                    color: _green,
                    onPressed: () => Get.back(),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      // TODO: save draft
                      Get.back();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: _muted,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: Size.zero,
                    ),
                    child: const Text(
                      "Save and exit",
                      style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Title
              const Text(
                "Price of your service",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: _green,
                  height: 1.12,
                ),
              ),
              const SizedBox(height: 6),

              // Subtitle
              const Text(
                "Set the price and duration of the services you want to\noffer",
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w400,
                  color: _muted,
                  height: 1.25,
                ),
              ),

              const SizedBox(height: 10),

              // Green link
              InkWell(
                onTap: () {
                  // TODO: open info page / bottom sheet
                },
                child: const Text(
                  "How much you will make for my services?",
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: _green,
                    decoration: TextDecoration.underline,
                    decorationThickness: 1.2,
                  ),
                ),
              ),

              const SizedBox(height: 12),
              const Divider(color: _divider, height: 1),

              // List
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _ServiceRow(
                      icon: Icons.construction_outlined,
                      title: "Hanging",
                      onTap: () {
                        Get.to(() => const HangingScreen());
                      },
                    ),
                    const Divider(color: _divider, height: 1),

                    _ServiceRow(
                      icon: Icons.build_outlined,
                      title: "Small Repair",
                      onTap: () {},
                    ),
                    const Divider(color: _divider, height: 1),

                    _ServiceRow(
                      icon: Icons.chair_alt_outlined,
                      title: "Furniture assembly",
                      onTap: () {},
                    ),
                    const Divider(color: _divider, height: 1),

                    _ServiceRow(
                      icon: Icons.handyman_outlined,
                      title: "Installation",
                      onTap: () {},
                    ),
                    const Divider(color: _divider, height: 1),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===================== PROGRESS =====================
class _TopProgress extends StatelessWidget {
  const _TopProgress({required this.value});

  final double value; // 0..1

  @override
  Widget build(BuildContext context) {
    final v = value.clamp(0.0, 1.0);

    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;
        const h = 12.0;
        final fillW = (w * v).clamp(h, w);

        return ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: Container(
            height: h,
            color: const Color(0xFFE7E7E7),
            alignment: Alignment.centerLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: fillW,
              height: h,
              decoration: BoxDecoration(
                color: PriceOfServiceScreen._green,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ===================== LIST ROW =====================
class _ServiceRow extends StatelessWidget {
  const _ServiceRow({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 20, color: PriceOfServiceScreen._text),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                  color: PriceOfServiceScreen._text,
                ),
              ),
            ),
            const Icon(Icons.chevron_right_rounded, size: 22, color: Color(0xFF9E9E9E)),
          ],
        ),
      ),
    );
  }
}
