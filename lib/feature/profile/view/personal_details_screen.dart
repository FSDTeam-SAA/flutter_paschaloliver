import 'package:flutter/material.dart';

/// ---------------------------------------------------------------------------
/// PERSONAL DETAILS (matches your screenshot)
/// - Top bar: back + title + Edit (right)
/// - Avatar + name
/// - Reviews + Services stats
/// - About me
/// - Outstanding rating + category bars
/// - Comments list
/// ---------------------------------------------------------------------------
class PersonalDetailsScreen extends StatelessWidget {
  const PersonalDetailsScreen({
    super.key,
    this.onEdit,
  });

  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    // demo data (replace with your API data)
    const userName = "Paschaloliver";
    const reviewsCount = 13;
    const servicesCount = 19;
    const about =
        "Integer id augue iaculis, iaculis orci ut, blandit quam. Donec in elit auctor, finibus quam in, phare";

    final ratingRows = const <_RatingRowData>[
      _RatingRowData(label: "Service", value: 4.8),
      _RatingRowData(label: "Communication", value: 5.0),
      _RatingRowData(label: "Kindness", value: 5.0),
      _RatingRowData(label: "Booked Time", value: 5.0),
      _RatingRowData(label: "Comfort", value: 5.0),
    ];

    final comments = List.generate(
      4,
          (i) => const _CommentData(
        name: "Esther",
        timeAgo: "3 day ago",
        rating: 5,
        comment: "He is very polite and comfortable.",
        isVerified: true,
      ),
    );

    return Scaffold(
      backgroundColor: _C.bg,
      body: SafeArea(
        child: Column(
          children: [
            // Top AppBar (custom like screenshot)
            Container(
              padding: const EdgeInsets.fromLTRB(8, 10, 12, 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: _C.divider, width: 1)),
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(10),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                        color: _C.green,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Expanded(
                    child: Text(
                      "Personal Details",
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: _C.text,
                        height: 1.1,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onEdit,
                    borderRadius: BorderRadius.circular(10),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: _C.green,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 18),
                children: [
                  const SizedBox(height: 16),

                  // Avatar
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const CircleAvatar(
                          radius: 44,
                          backgroundColor: Color(0xFFE6E6E6),
                          child: Icon(Icons.person, size: 34, color: Color(0xFF777777)),
                        ),
                        // (No camera button in this screen screenshot)
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Name
                  Center(
                    child: Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 12.8,
                        fontWeight: FontWeight.w700,
                        color: _C.text,
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Stats row (Reviews / Services)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Row(
                      children: const [
                        Expanded(
                          child: _StatCell(
                            topText: "5",
                            topIcon: Icons.star,
                            bottomText: "13 reviews",
                          ),
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: _StatCell(
                            topText: "19",
                            bottomText: "Services",
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),
                  const Divider(height: 1, thickness: 1, color: _C.divider),

                  // About me
                  const Padding(
                    padding: EdgeInsets.fromLTRB(22, 14, 22, 6),
                    child: Text(
                      "About me",
                      style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w800,
                        color: _C.green,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 0, 22, 14),
                    child: Text(
                      about,
                      style: const TextStyle(
                        fontSize: 11.8,
                        fontWeight: FontWeight.w500,
                        color: _C.subText,
                        height: 1.35,
                      ),
                    ),
                  ),

                  const Divider(height: 1, thickness: 1, color: _C.divider),

                  // Outstanding summary
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 14, 22, 10),
                    child: Row(
                      children: const [
                        Text(
                          "5",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: _C.text),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.star, size: 16, color: _C.star),
                        SizedBox(width: 8),
                        Text(
                          "Outstanding",
                          style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: _C.text),
                        ),
                        SizedBox(width: 6),
                        Text(
                          "(13 ratings)",
                          style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: _C.subText),
                        ),
                      ],
                    ),
                  ),

                  // Rating rows
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 0, 22, 12),
                    child: Column(
                      children: ratingRows
                          .map(
                            (r) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: _RatingRow(data: r),
                        ),
                      )
                          .toList(),
                    ),
                  ),

                  const Divider(height: 1, thickness: 1, color: _C.divider),

                  // Comments
                  const Padding(
                    padding: EdgeInsets.fromLTRB(22, 14, 22, 10),
                    child: Text(
                      "Comments",
                      style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w800,
                        color: _C.green,
                      ),
                    ),
                  ),

                  ...comments.map((c) => _CommentTile(data: c)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// -------------------------
/// Stats cell
/// -------------------------
class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.topText,
    required this.bottomText,
    this.topIcon,
  });

  final String topText;
  final String bottomText;
  final IconData? topIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _C.divider, width: 1),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                topText,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: _C.text,
                  height: 1.1,
                ),
              ),
              if (topIcon != null) ...[
                const SizedBox(width: 4),
                Icon(topIcon, size: 16, color: _C.star),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Text(
            bottomText,
            style: const TextStyle(
              fontSize: 11.2,
              fontWeight: FontWeight.w600,
              color: _C.subText,
            ),
          ),
        ],
      ),
    );
  }
}

/// -------------------------
/// Rating row
/// -------------------------
class _RatingRowData {
  final String label;
  final double value;
  const _RatingRowData({required this.label, required this.value});
}

class _RatingRow extends StatelessWidget {
  const _RatingRow({required this.data});
  final _RatingRowData data;

  @override
  Widget build(BuildContext context) {
    final normalized = (data.value / 5.0).clamp(0.0, 1.0);

    return Row(
      children: [
        SizedBox(
          width: 108,
          child: Text(
            data.label,
            style: const TextStyle(
              fontSize: 11.6,
              fontWeight: FontWeight.w600,
              color: _C.text,
            ),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: normalized,
              minHeight: 5,
              backgroundColor: _C.barBg,
              valueColor: const AlwaysStoppedAnimation<Color>(_C.bar),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 28,
          child: Text(
            data.value == 5 ? "5" : data.value.toStringAsFixed(1),
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 11.6,
              fontWeight: FontWeight.w700,
              color: _C.text,
            ),
          ),
        ),
      ],
    );
  }
}

/// -------------------------
/// Comment tile
/// -------------------------
class _CommentData {
  final String name;
  final String timeAgo;
  final int rating;
  final String comment;
  final bool isVerified;

  const _CommentData({
    required this.name,
    required this.timeAgo,
    required this.rating,
    required this.comment,
    required this.isVerified,
  });
}

class _CommentTile extends StatelessWidget {
  const _CommentTile({required this.data});
  final _CommentData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 1, thickness: 1, color: _C.divider),
        Padding(
          padding: const EdgeInsets.fromLTRB(22, 12, 22, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFFE6E6E6),
                child: Icon(Icons.person, size: 18, color: Color(0xFF777777)),
              ),
              const SizedBox(width: 12),

              // text block
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          data.name,
                          style: const TextStyle(
                            fontSize: 12.6,
                            fontWeight: FontWeight.w800,
                            color: _C.text,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          data.timeAgo,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _C.subText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    if (data.isVerified)
                      Row(
                        children: const [
                          Icon(Icons.verified, size: 14, color: _C.green),
                          SizedBox(width: 6),
                          Text(
                            "Verified service",
                            style: TextStyle(
                              fontSize: 11.3,
                              fontWeight: FontWeight.w600,
                              color: _C.subText,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 6),
                    Text(
                      data.comment,
                      style: const TextStyle(
                        fontSize: 11.6,
                        fontWeight: FontWeight.w500,
                        color: _C.text,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),

              // rating right
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${data.rating}",
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: _C.text,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(width: 3),
                  const Icon(Icons.star, size: 14, color: _C.star),
                ],
              )

            ],
          ),
        ),
      ],
    );
  }
}

/// -------------------------
/// Colors
/// -------------------------
class _C {
  static const bg = Colors.white;

  static const green = Color(0xFF27AE60);
  static const text = Color(0xFF111111);
  static const subText = Color(0xFF7C7C7C);

  static const divider = Color(0xFFEDEDED);

  static const star = Color(0xFFF5B400);

  static const bar = Color(0xFFF5B400);
  static const barBg = Color(0xFFF1F1F1);
}
