import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/assets.dart';

/// ✅ USER SERVICE VIEW DETAILS (PRO UI + Payment Details Bottom Sheet)
///
/// Required assets in assets.dart:
/// - Images.mapPreview          // map placeholder image (you will replace with GoogleMap later)
/// - Images.paymentHero         // (optional) top illustration like your 3rd screenshot
/// - Images.men                 // avatar image
///
/// Example:
/// class Images {
///   static const men = "assets/images/men.png";
///   static const mapPreview = "assets/images/map_preview.png";
///   static const paymentHero = "assets/images/payment_hero.png";
/// }
class UserServiceViewDetailsScreen extends StatelessWidget {
  const UserServiceViewDetailsScreen({super.key});

  static const _green = Color(0xFF2FA86A);
  static const _text = Color(0xFF1F1F1F);
  static const _muted = Color(0xFF8B8B8B);
  static const _line = Color(0xFFEDEDED);
  static const _pill = Color(0xFFEFEFEF);
  static const _danger = Color(0xFFFF1E3A);

  // Toggle: show illustration header like your 3rd screenshot
  final bool showHeroHeader = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
          children: [
            // Back
            // ✅ PERFECTLY PLACED BACK ARROW (fixed header)
            SizedBox(
              height: 48,
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => Get.back(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                  ),
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18,
                    color: _green,
                  ),
                ),
              ),
            ),

            // TOP: either Hero illustration OR Map preview (you can keep both if you want)


            _TopMediaCard(
              height: 140,
              child: Image.asset(
                Images.men, // ✅ later replace this widget with GoogleMap
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 12),

            // Provider row (matches screenshot)
            _ProviderStrip(
              avatar: Images.men,
              name: "Mr. Hamid",
              subtitle: "Professional",
              rating: 4.8,
            ),

            const SizedBox(height: 14),

            // Main details card
            Container(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _line),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.06),
                    blurRadius: 16,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + status pill
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Cleaning Service",
                          style: TextStyle(
                            fontFamily: "Urbanist",
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: _text,
                            height: 1.1,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: _pill,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "Accepted",
                          style: TextStyle(
                            fontFamily: "Urbanist",
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF777777),
                            height: 1.1,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // View payment details (tap -> bottom sheet)
                  _PaymentChevronRow(
                    title: "View payment details",
                    onTap: () => _openPaymentDetails(context),
                  ),

                  const SizedBox(height: 12),
                  const Divider(height: 1, thickness: 1, color: _line),
                  const SizedBox(height: 12),

                  // Addresses
                  const _DotRow(text: "Road No. 6 Avenue - 05"),
                  const SizedBox(height: 10),
                  const _DotRow(text: "Moroccan university road"),

                  const SizedBox(height: 14),

                  // Meta rows
                  const _MetaRow(icon: Icons.calendar_month_outlined, label: "Date:", value: "12 July 2025"),
                  const SizedBox(height: 12),
                  const _MetaRow(icon: Icons.access_time_rounded, label: "Time:", value: "10:00 AM–11 AM"),
                  const SizedBox(height: 12),
                  const _MetaRow(icon: Icons.cleaning_services_outlined, label: "Services:", value: "Cleaner"),
                  const SizedBox(height: 12),
                  const _MetaRow(icon: Icons.mail_outline_rounded, label: "Email:", value: "example@gmail.com"),
                  const SizedBox(height: 12),
                  const _MetaRow(icon: Icons.call_outlined, label: "Phone:", value: "012562589663"),

                  const SizedBox(height: 14),

                  // Duration / Distance
                  Row(
                    children: const [
                      Expanded(child: _SmallStatCard(icon: Icons.access_time_rounded, title: "Duration", value: "2h")),
                      SizedBox(width: 12),
                      Expanded(child: _SmallStatCard(icon: Icons.place_outlined, title: "Distance", value: "1.1 Km")),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Send message
                  SizedBox(
                    height: 46,
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFBDBDBD)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: const Icon(Icons.chat_bubble_outline_rounded, size: 18, color: _text),
                      label: const Text(
                        "Send massage",
                        style: TextStyle(
                          fontFamily: "Urbanist",
                          fontSize: 13.5,
                          fontWeight: FontWeight.w800,
                          color: _text,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Cancel booking
                  SizedBox(
                    height: 46,
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _confirmCancel(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _danger,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: const Icon(Icons.close_rounded, color: Colors.white, size: 18),
                      label: const Text(
                        "Cancel Booking",
                        style: TextStyle(
                          fontFamily: "Urbanist",
                          fontSize: 13.5,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void _openPaymentDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(.35),
      builder: (_) => const _ServicePriceSheet(
        serviceName: "Cleaning",
        hourlyRate: 12.50,
        bookedHours: 2,
        minCharge: 12.50,
        managementFee: 0.83,
        vatFee: 0.17,
      ),
    );
  }

  static void _confirmCancel(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Cancel booking?"),
        content: const Text("Are you sure you want to cancel this booking?"),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("No")),
          TextButton(onPressed: () => Get.back(), child: const Text("Yes")),
        ],
      ),
    );
  }
}

/* ----------------------------- TOP MEDIA CARD ----------------------------- */

class _TopMediaCard extends StatelessWidget {
  const _TopMediaCard({required this.child, required this.height});
  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: height,
        width: double.infinity,
        color: const Color(0xFFF2F2F2),
        child: child,
      ),
    );
  }
}

/* ----------------------------- PROVIDER STRIP ----------------------------- */

class _ProviderStrip extends StatelessWidget {
  const _ProviderStrip({
    required this.avatar,
    required this.name,
    required this.subtitle,
    required this.rating,
  });

  final String avatar;
  final String name;
  final String subtitle;
  final double rating;

  static const _text = Color(0xFF1F1F1F);
  static const _muted = Color(0xFF8B8B8B);
  static const _line = Color(0xFFEDEDED);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _line),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Image.asset(avatar, width: 40, height: 40, fit: BoxFit.cover),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontFamily: "Urbanist",
                    fontSize: 14.5,
                    fontWeight: FontWeight.w900,
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
                    fontWeight: FontWeight.w600,
                    color: _muted,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(
              fontFamily: "Urbanist",
              fontSize: 12.5,
              fontWeight: FontWeight.w900,
              color: _text,
            ),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.star_rounded, color: Color(0xFFF4B400), size: 18),
        ],
      ),
    );
  }
}

/* ----------------------------- PAYMENT ROW ----------------------------- */

class _PaymentChevronRow extends StatelessWidget {
  const _PaymentChevronRow({required this.title, required this.onTap});
  final String title;
  final VoidCallback onTap;

  static const _green = Color(0xFF2FA86A);
  static const _text = Color(0xFF1F1F1F);
  static const _line = Color(0xFFEDEDED);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: _green.withOpacity(.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.payments_outlined, size: 16, color: _green),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: "Urbanist",
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: _text,
                    height: 1.1,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right_rounded, size: 22, color: _text),
            ],
          ),
        ),
      ),
    );
  }
}

/* ----------------------------- DOT + META ----------------------------- */

class _DotRow extends StatelessWidget {
  const _DotRow({required this.text});
  final String text;

  static const _text = Color(0xFF1F1F1F);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 7, height: 7, decoration: const BoxDecoration(color: Color(0xFF2FA86A), shape: BoxShape.circle)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: "Urbanist",
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: _text,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  static const _text = Color(0xFF1F1F1F);
  static const _muted = Color(0xFF8B8B8B);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: _text),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(
            fontFamily: "Urbanist",
            fontSize: 12.5,
            fontWeight: FontWeight.w800,
            color: _text,
            height: 1.1,
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: "Urbanist",
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: _muted,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}

class _SmallStatCard extends StatelessWidget {
  const _SmallStatCard({required this.icon, required this.title, required this.value});

  final IconData icon;
  final String title;
  final String value;

  static const _bg = Color(0xFFF2F2F2);
  static const _text = Color(0xFF1F1F1F);
  static const _muted = Color(0xFF8B8B8B);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(color: _bg, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(icon, size: 18, color: _text),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: "Urbanist",
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: _muted,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: "Urbanist",
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: _text,
            ),
          ),
        ],
      ),
    );
  }
}

/* ============================ SERVICE PRICE SHEET ============================ */

class _ServicePriceSheet extends StatelessWidget {
  const _ServicePriceSheet({
    required this.serviceName,
    required this.hourlyRate,
    required this.bookedHours,
    required this.minCharge,
    required this.managementFee,
    required this.vatFee,
  });

  final String serviceName;
  final double hourlyRate;
  final int bookedHours;
  final double minCharge;
  final double managementFee;
  final double vatFee;

  static const _green = Color(0xFF2FA86A);
  static const _text = Color(0xFF1F1F1F);
  static const _muted = Color(0xFF8B8B8B);
  static const _line = Color(0xFFEDEDED);

  String _money(double v) => "₦${v.toStringAsFixed(2)}";

  @override
  Widget build(BuildContext context) {
    final subtotal = hourlyRate * bookedHours;
    final price = subtotal + minCharge + managementFee + vatFee;

    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.18),
              blurRadius: 22,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 46,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFDADADA),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(height: 10),

            // Header
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Service price",
                    style: TextStyle(
                      fontFamily: "Urbanist",
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: _green,
                      height: 1.1,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Get.back(),
                  borderRadius: BorderRadius.circular(16),
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.close, size: 18, color: Color(0xFF8B8B8B)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            _PriceRow(left: serviceName, right: "${_money(hourlyRate)}/h"),
            const SizedBox(height: 10),
            _PriceRow(left: "Booked hours", right: "${bookedHours}h"),
            const SizedBox(height: 10),
            _PriceRow(left: "Subtotal", right: _money(subtotal)),
            const SizedBox(height: 12),

            _PriceRow(left: "Professional's minimum charge", right: "+ ${_money(minCharge)}", showInfo: true),
            const SizedBox(height: 10),
            _PriceRow(left: "Management fees", right: "+ ${_money(managementFee)}", showInfo: true),
            const SizedBox(height: 10),
            _PriceRow(left: "VAT ( heading fee )", right: "+ ${_money(vatFee)}", showInfo: true),

            const SizedBox(height: 12),
            const Divider(height: 1, thickness: 1, color: _line),
            const SizedBox(height: 10),

            Row(
              children: [
                const Text(
                  "Price:",
                  style: TextStyle(
                    fontFamily: "Urbanist",
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: _text,
                  ),
                ),
                const Spacer(),
                Text(
                  _money(price),
                  style: const TextStyle(
                    fontFamily: "Urbanist",
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: _text,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: _green, width: 1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text(
                        "Exit",
                        style: TextStyle(
                          fontFamily: "Urbanist",
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: _green,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _green,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text(
                        "Remain",
                        style: TextStyle(
                          fontFamily: "Urbanist",
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
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
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({required this.left, required this.right, this.showInfo = false});

  final String left;
  final String right;
  final bool showInfo;

  static const _text = Color(0xFF1F1F1F);
  static const _muted = Color(0xFF8B8B8B);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Flexible(
                child: Text(
                  left,
                  style: const TextStyle(
                    fontFamily: "Urbanist",
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: _text,
                    height: 1.1,
                  ),
                ),
              ),
              if (showInfo) ...[
                const SizedBox(width: 6),
                const Icon(Icons.info_outline_rounded, size: 16, color: _muted),
              ],
            ],
          ),
        ),
        const SizedBox(width: 10),
        Text(
          right,
          style: const TextStyle(
            fontFamily: "Urbanist",
            fontSize: 12.5,
            fontWeight: FontWeight.w800,
            color: _text,
            height: 1.1,
          ),
        ),
      ],
    );
  }
}
