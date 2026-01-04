import 'package:flutter/material.dart';
import 'InstallationScreen.dart';

class FurnitureAssemblyScreen extends StatefulWidget {
  const FurnitureAssemblyScreen({super.key});

  @override
  State<FurnitureAssemblyScreen> createState() => _FurnitureAssemblyScreenState();
}

class _FurnitureAssemblyScreenState extends State<FurnitureAssemblyScreen> {
  // Screenshot colors
  static const Color _green = Color(0xFF2FA86A);
  static const Color _muted = Color(0xFF8B8B8B);
  static const Color _divider = Color(0xFFD9D9D9);
  static const Color _track = Color(0xFFEAEAEA);

  static const Color _boxBorder = Color(0xFFBDBDBD);
  static const Color _boxFill = Color(0xFFE6E6E6);

  final List<_RowItem> _items = [
    _RowItem("Cabinets and similar items"),
    _RowItem("Bed"),
    _RowItem("Sideboard/chest of drawers"),
    _RowItem("Mirror"),
    _RowItem("Table"),
  ];

  // progress like screenshot (small green part on left)
  final double _progress = 0.16;

  bool _navigating = false;

  void _goNext() {
    if (_navigating) return;
    _navigating = true;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const InstallationScreen()),
    ).then((_) {
      _navigating = false;
    });
  }

  void _toggleAndMaybeGo(int i, bool nextValue) {
    setState(() => _items[i].checked = nextValue);

    // ✅ only go next when turning ON
    if (nextValue) _goNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // top progress bar (long)
              _TopProgressBar(value: _progress, track: _track, fill: _green),
              const SizedBox(height: 12),

              // back + save
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(10),
                    child: const Padding(
                      padding: EdgeInsets.all(6),
                      child: Icon(Icons.arrow_back, size: 22, color: _green),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      foregroundColor: _muted,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      textStyle: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500),
                    ),
                    child: const Text("Save and exit"),
                  ),
                ],
              ),

              const SizedBox(height: 6),

              // title
              const Text(
                "Furniture assembly",
                style: TextStyle(
                  color: _green,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  height: 1.15,
                ),
              ),

              const SizedBox(height: 10),

              // list box with border
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: _divider, width: 1),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _items.length,
                  separatorBuilder: (_, __) => const Divider(height: 1, thickness: 1, color: _divider),
                  itemBuilder: (context, i) {
                    final item = _items[i];

                    return InkWell(
                      onTap: () => _toggleAndMaybeGo(i, !item.checked),
                      child: Container(
                        height: 44,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.title,
                                style: const TextStyle(
                                  color: Color(0xFF2B2B2B),
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            _GreySquareCheck(
                              value: item.checked,
                              onTap: () => _toggleAndMaybeGo(i, !item.checked),
                              borderColor: _boxBorder,
                              fillColor: _boxFill,
                              checkColor: _green,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // keep space like screenshot (big empty area)
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}

class _RowItem {
  final String title;
  bool checked;
  _RowItem(this.title, {this.checked = false});
}

/// Long progress bar at the top (exact screenshot vibe)
class _TopProgressBar extends StatelessWidget {
  const _TopProgressBar({
    required this.value,
    required this.track,
    required this.fill,
  });

  final double value;
  final Color track;
  final Color fill;

  @override
  Widget build(BuildContext context) {
    final v = value.clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: Container(
        height: 10,
        color: track,
        child: Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: v,
            child: Container(color: fill),
          ),
        ),
      ),
    );
  }
}

/// Grey square checkbox like screenshot (always light grey box)
class _GreySquareCheck extends StatelessWidget {
  const _GreySquareCheck({
    required this.value,
    required this.onTap,
    required this.borderColor,
    required this.fillColor,
    required this.checkColor,
  });

  final bool value;
  final VoidCallback onTap;
  final Color borderColor;
  final Color fillColor;
  final Color checkColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(2),
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(2),
          border: Border.all(color: borderColor, width: 1.2),
        ),
        child: value
            ? Icon(Icons.check_rounded, size: 16, color: checkColor)
            : null,
      ),
    );
  }
}
