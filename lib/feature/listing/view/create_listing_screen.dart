import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/assets.dart';
import 'list_home_category_screen.dart';

/// ✅ CreateListingScreen (PRO + matches 2nd screenshot)
/// - Top progress bar (small green start + long grey track)
/// - Back arrow
/// - Title + subtitle
/// - Search field
/// - Center "N" background + 7 circular category bubbles (exact layout)
class CreateListingScreen extends StatefulWidget {
  const CreateListingScreen({super.key});

  static const Color green = Color(0xFF2FA86A);
  static const Color muted = Color(0xFF6F6F6F);
  static const Color border = Color(0xFFBDBDBD);
  static const Color track = Color(0xFFE7E7E7);

  @override
  State<CreateListingScreen> createState() => _CreateListingScreenState();
}

class _CreateListingScreenState extends State<CreateListingScreen> {
  final _searchCtrl = TextEditingController();
  final double _progress = 0.06; // small green start (like screenshot)

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _openCategory(String category) {
    Get.to(() => const ListingHomeCategoryScreen());
  }

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

              // Progress bar
              _TopProgress(value: _progress),
              const SizedBox(height: 16),

              // Back
              InkWell(
                onTap: () => Get.back(),
                borderRadius: BorderRadius.circular(10),
                child: const Padding(
                  padding: EdgeInsets.all(6),
                  child: Icon(Icons.arrow_back_ios_new_rounded,
                      size: 18, color: CreateListingScreen.green),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Create your listing",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: CreateListingScreen.green,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Select or search for the service you want you offer",
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color: CreateListingScreen.muted,
                  height: 1.25,
                ),
              ),

              const SizedBox(height: 14),

              _SearchField(
                controller: _searchCtrl,
                hint: "Handyman, cleaning, ironing...",
                onChanged: (_) {},
              ),

              const SizedBox(height: 18),

              // Category cluster area
              Expanded(
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: 340,
                      height: 430,
                      child: _CategoryCluster(
                        onTap: _openCategory,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

/* ------------------------ Top progress ------------------------ */

class _TopProgress extends StatelessWidget {
  const _TopProgress({required this.value});
  final double value;

  @override
  Widget build(BuildContext context) {
    final v = value.clamp(0.0, 1.0);
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: SizedBox(
        height: 10,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(color: CreateListingScreen.track),
            ),
            FractionallySizedBox(
              widthFactor: v,
              child: Container(color: CreateListingScreen.green),
            ),
          ],
        ),
      ),
    );
  }
}

/* ------------------------ Search field ------------------------ */

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.hint,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1E1E1E),
        ),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search_rounded, size: 20),
          prefixIconColor: const Color(0xFF7B7B7B),
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            color: Color(0xFFB6B6B6),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: CreateListingScreen.border, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: CreateListingScreen.border, width: 1.2),
          ),
        ),
      ),
    );
  }
}

/* ------------------------ Cluster ------------------------ */

class _CategoryCluster extends StatelessWidget {
  const _CategoryCluster({required this.onTap});
  final void Function(String category) onTap;

  @override
  Widget build(BuildContext context) {
    // Base frame for positions (fixed like screenshot)
    const double w = 340;
    const double h = 430;

    // Bubble size (close to screenshot)
    const double d = 96;
    const double r = d / 2;

    // Column centers
    const double leftX = 78;
    const double midX = w / 2;
    const double rightX = w - 78;

    // Row centers (spacing like screenshot)
    const double topY = 95;
    const double midY = 230;
    const double botY = 365;

    Positioned pos(double cx, double cy, Widget child) {
      return Positioned(
        left: cx - r,
        top: cy - r,
        width: d,
        height: d,
        child: child,
      );
    }

    return Stack(
      children: [
        // N background
        Positioned.fill(
          child: CustomPaint(
            painter: _NPainter(
              bubble: d,
              leftX: leftX,
              rightX: rightX,
              topY: topY,
              botY: botY,
            ),
          ),
        ),

        // TOP
        pos(
          leftX,
          topY,
          _Bubble(
            iconPath: Images.homeIcon,
            label: "Home",
            onTap: () => onTap("Home"),
          ),
        ),
        pos(
          rightX,
          topY,
          _Bubble(
            iconPath: Images.techItIcon,
            label: "Tech & IT\nSupport",
            onTap: () => onTap("Tech & IT Support"),
          ),
        ),

        // MID
        pos(
          leftX,
          midY,
          _Bubble(
            iconPath: Images.beautyIcon,
            label: "Beauty",
            onTap: () => onTap("Beauty"),
          ),
        ),
        pos(
          midX,
          midY,
          _Bubble(
            iconPath: Images.maintanceIcon,
            label: "Repair &\nMaintenance",
            onTap: () => onTap("Repair & Maintenance"),
          ),
        ),
        pos(
          rightX,
          midY,
          _Bubble(
            iconPath: Images.automactionIcon,
            label: "Automobile",
            onTap: () => onTap("Automobile"),
          ),
        ),

        // BOTTOM
        pos(
          leftX,
          botY,
          _Bubble(
            iconPath: Images.mediaIcon,
            label: "Media &\nEvents",
            onTap: () => onTap("Media & Events"),
          ),
        ),
        pos(
          rightX,
          botY,
          _Bubble(
            iconPath: Images.othersIcon,
            label: "Others",
            onTap: () => onTap("Others"),
          ),
        ),
      ],
    );
  }
}

/* ------------------------ N Painter ------------------------ */

class _NPainter extends CustomPainter {
  _NPainter({
    required this.bubble,
    required this.leftX,
    required this.rightX,
    required this.topY,
    required this.botY,
  });

  final double bubble;
  final double leftX;
  final double rightX;
  final double topY;
  final double botY;

  @override
  void paint(Canvas canvas, Size size) {
    const nColor = Color(0xFFE6E6E6);

    // thickness tuned to look like screenshot behind circles
    final double thickness = bubble * 0.58; // ~56
    final double barW = thickness * 0.88;
    final Radius rad = Radius.circular(barW * 0.46);

    final fill = Paint()
      ..color = nColor
      ..style = PaintingStyle.fill;

    // Left vertical bar
    final leftBar = RRect.fromRectAndRadius(
      Rect.fromLTRB(
        leftX - barW / 2,
        topY - bubble * 0.36,
        leftX + barW / 2,
        botY + bubble * 0.36,
      ),
      rad,
    );

    // Right vertical bar
    final rightBar = RRect.fromRectAndRadius(
      Rect.fromLTRB(
        rightX - barW / 2,
        topY - bubble * 0.30,
        rightX + barW / 2,
        botY + bubble * 0.30,
      ),
      rad,
    );

    canvas.drawRRect(leftBar, fill);
    canvas.drawRRect(rightBar, fill);

    // Diagonal stroke
    final stroke = Paint()
      ..color = nColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(leftX, topY + bubble * 0.10),
      Offset(rightX, botY - bubble * 0.10),
      stroke,
    );

    // Soft blend behind middle bubble
    final midBlend = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width / 2, (topY + botY) / 2),
        width: bubble * 0.95,
        height: bubble * 0.95,
      ),
      Radius.circular(bubble * 0.30),
    );
    canvas.drawRRect(midBlend, fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/* ------------------------ Bubble ------------------------ */

class _Bubble extends StatelessWidget {
  const _Bubble({
    required this.iconPath,
    required this.label,
    required this.onTap,
  });

  final String iconPath;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              // cleaner shadow (like screenshot)
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 14,
                spreadRadius: 0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  iconPath,
                  width: 34,
                  height: 34,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 6),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 12.2,
                    fontWeight: FontWeight.w800,
                    height: 1.12,
                    color: Color(0xFF1E1E1E),
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
