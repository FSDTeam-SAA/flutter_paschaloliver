import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/assets.dart';


class UserHomeCluster extends StatelessWidget {
  const UserHomeCluster({super.key});

  static const double _w = 342;
  static const double _h = 432;

  // ✅ exact circle diameter from your PNG
  static const double _d = 100;
  static const double _r = _d / 2;

  Positioned _pos(double cx, double cy, Widget child) {
    return Positioned(
      left: cx - _r,
      top: cy - _r,
      width: _d,
      height: _d,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        fit: BoxFit.contain,
        child: SizedBox(
          width: _w,
          height: _h,
          child: Stack(
            children: [
              // ✅ Your "N with circles" transparent image
              Positioned.fill(
                child: Image.asset(
                  Images.homeNBg, // <-- put your PNG path here
                  fit: BoxFit.fill,  // no inner padding => overlay matches
                ),
              ),

              // TOP LEFT: Home
              _pos(
                59.4,
                59.4,
                _CircleContent(
                  icon: Images.homeIcon,
                  label: "Home",
                  onTap: () {
                    // TODO
                  },
                ),
              ),

              // TOP RIGHT: Tech & IT Support
              _pos(
                282.3,
                59.4,
                _CircleContent(
                  icon: Images.techItIcon,
                  label: "Tech & IT\nSupport",
                  onTap: () {},
                ),
              ),

              // MID LEFT: Beauty
              _pos(
                59.4,
                216.6,
                _CircleContent(
                  icon: Images.beautyIcon,
                  label: "Beauty",
                  onTap: () {},
                ),
              ),

              // MID CENTER: Repair & Maintenance
              _pos(
                170.9,
                216.6,
                _CircleContent(
                  icon: Images.maintanceIcon,
                  label: "Repair &\nMaintenance",
                  onTap: () {},
                ),
              ),

              // MID RIGHT: Automobile
              _pos(
                282.3,
                216.6,
                _CircleContent(
                  icon: Images.automactionIcon,
                  label: "Automobile",
                  onTap: () {},
                ),
              ),

              // BOTTOM LEFT: Media & Events
              _pos(
                59.4,
                373.8,
                _CircleContent(
                  icon: Images.mediaIcon,
                  label: "Media &\nEvents",
                  onTap: () {},
                ),
              ),

              // BOTTOM RIGHT: Others
              _pos(
                282.3,
                373.8,
                _CircleContent(
                  icon: Images.othersIcon,
                  label: "Others",
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleContent extends StatelessWidget {
  const _CircleContent({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final String icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // background circle already exists in the PNG, so only place content centered.
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  icon,
                  width: 34,
                  height: 34,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 6),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                    color: Color(0xFF111111),
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
