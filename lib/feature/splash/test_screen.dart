/* import 'package:flutter/material.dart';


class HandyNaijaHomeScreen extends StatelessWidget {
  const HandyNaijaHomeScreen({super.key});

  Widget _categoryIcon({
    required IconData icon,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Icon(icon, size: 35, color: Color(0xFFFF6B00)), // অরেঞ্জ কালার
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00A86B), // HandyNaija-এর গ্রিন
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "HandyNaija",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
          IconButton(icon: const Icon(Icons.notifications_outlined, color: Colors.white), onPressed: () {}),
          const SizedBox(width: 10),
        ],
      ),
      body: Stack(
        children: [
          // "N" শেপ – আরও মোটা, গোল কোণা, টিল্টেড
          Center(
            child: Transform.rotate(
              angle: -0.15, // সামান্য টিল্ট
              child: CustomPaint(
                size: Size(
                  MediaQuery.of(context).size.width * 0.85,
                  MediaQuery.of(context).size.height * 0.7,
                ),
                painter: NaijaNShapePainter(),
              ),
            ),
          ),

          // ক্যাটাগরিগুলো – আসল পজিশনে
          ..._buildCategoryPositions(context),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: _buildAddAddressButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  List<Widget> _buildCategoryPositions(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return [
      Positioned(top: size.height * 0.18, left: size.width * 0.18, child: _categoryIcon(icon: Icons.home, label: "Home")),
      Positioned(top: size.height * 0.15, right: size.width * 0.12, child: _categoryIcon(icon: Icons.computer, label: "Tech & IT\nSupport")),
      Positioned(top: size.height * 0.38, left: size.width * 0.08, child: _categoryIcon(icon: Icons.brush, label: "Beauty")),
      Positioned(top: size.height * 0.40, left: size.width * 0.35, child: _categoryIcon(icon: Icons.build, label: "Repair &\nMaintenance")),
      Positioned(top: size.height * 0.38, right: size.width * 0.08, child: _categoryIcon(icon: Icons.directions_car, label: "Automobile")),
      Positioned(bottom: size.height * 0.22, left: size.width * 0.12, child: _categoryIcon(icon: Icons.event, label: "Media &\nEvents")),
      Positioned(bottom: size.height * 0.18, right: size.width * 0.12, child: _categoryIcon(icon: Icons.shopping_bag, label: "Others")),
    ];
  }

  Widget _buildAddAddressButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 70),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF00A86B),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: const Text("+ Add address", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.search, "Search", true),
          _navItem(Icons.favorite_border, "Favorites", false),
          const SizedBox(width: 40),
          _navItem(Icons.message_outlined, "Inbox", false),
          _navItem(Icons.person_outline, "Profile", false),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? const Color(0xFF00A86B) : Colors.grey),
        Text(label, style: TextStyle(color: isActive ? const Color(0xFF00A86B) : Colors.grey, fontSize: 10)),
      ],
    );
  }
}

class NaijaNShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3) // হালকা সাদা-ধূসর
      ..strokeWidth = size.width * 0.28
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path();

    // বাম লাইন
    path.moveTo(size.width * 0.15, size.height * 0.05);
    path.lineTo(size.width * 0.15, size.height * 0.95);

    // ডান লাইন
    path.moveTo(size.width * 0.85, size.height * 0.05);
    path.lineTo(size.width * 0.85, size.height * 0.95);

    // তির্যক লাইন
    path.moveTo(size.width * 0.15, size.height * 0.05);
    path.lineTo(size.width * 0.85, size.height * 0.95);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
} */