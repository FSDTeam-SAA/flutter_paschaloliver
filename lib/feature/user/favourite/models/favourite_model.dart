import 'dart:ui';

class FavoriteCategory {
  FavoriteCategory({
    required this.title,
    required this.professionalsText,
    required this.avatarCount,
    required this.extraCount,
    required this.onTap,
  });

  final String title;
  final String professionalsText;
  final int avatarCount;
  final int extraCount;
  final VoidCallback onTap;
}